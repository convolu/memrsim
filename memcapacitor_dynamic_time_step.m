clearvars;
close all;

CYCLES = 2;
sampling_coeff=15;
% FREQUENCY=[ 100, 800, 1e3, 1e4, 1e5, 1e6]';  %frequency of the sinusoidal input in Hz
FREQUENCY=linspace(1,50,20)';  %frequency of the sinusoidal input in Hz
TIME_END= CYCLES./FREQUENCY;
TIME_STEP=1./(2*sampling_coeff*FREQUENCY);

W0 = 5*1e-9;
D = 10*1e-9;
Ron = 1e2;
Roff = 3*1e3;
u = 1e-14;

C_init = 1e-7;   %In F
C_max = 10*1e-7;
C_min = 10*1e-10;
kappa = 10*1e6;

input_ampl = 0.1;

%----------------------------------------------------------------------
t = zeros(length(FREQUENCY),2*sampling_coeff*CYCLES+1);
for iii=1:length(FREQUENCY)
t(iii,:)=[0:TIME_STEP(iii):TIME_END(iii)]; %Vector containing time values
end

parfor l=1:length(FREQUENCY)
input_v(l,:)=input_ampl*sin(2*pi*FREQUENCY(l)*t(l,:)); % store sine as input


%% Calculation of the input integral
integr_v(l,:) = zeros(1,length(t(l,:)));

integr_v(l,:) = TIME_STEP(l)*cumtrapz(input_v(l,:));



[ m(l,:), i(l,:) ,q(l,:) ] = memristor( W0, D, Ron, Roff,u , input_v(l,:) , integr_v(l,:), t(l,:), TIME_STEP(l) );
[ c(l,:),q_memcap(l,:),i_memcap(l,:) ] = memcap( C_init, C_max, C_min, kappa, input_v(l,:) , integr_v(l,:), t(l,:), TIME_STEP(l));

integr_c(l,:) = TIME_STEP(l)*cumtrapz(c(l,:));

Ratio23(l) = (max(m(l,:))- min(m(l,:)))/(max(c(l,:))- min(c(l,:)));
Delta_Memcap_v_freq(l)= (max(c(l,:))- min(c(l,:)));
Delta_Memri_v_freq(l) = (max(m(l,:))-min(m(l,:)));

Ratio_Memcap_v_freq(l)= max(c(l,:))/min(c(l,:));
Ratio_Memri_v_freq(l) = max(m(l,:))/min(m(l,:));
end

%%Plotting

for l=1:length(FREQUENCY)
            str(l,:)=sprintf('%1.2e Hz', FREQUENCY(l));
end

%V-I PLOT
figure('Name','Current against voltage')
hold all
for l=1:length(FREQUENCY)
    plot(input_v(l,:),i(l,:)+i_memcap(l,:))
end
hold off
grid
legend(str)
legend('location','SouthEast')
xlabel('Voltage')
ylabel('Current')

figure('Name','Area Over C(t) against f')
plot(FREQUENCY,integr_c(:,end)/CYCLES)
grid
xlabel('Frequency (Hz)')
ylabel('Area')


%Against Time plots
% figure('Name','Capacitance against time plot')
% plotyy(t,m, t,c)
% grid
% legend(str)
% title('Memristance, Capacitance against time plot')
% xlabel('Time')
% ylabel('Memristance')
% 

figure('Name','Capacitance against time plot')
hold all
for l=1:length(FREQUENCY)
    plot(t(l,:),c(l,:))
end
hold off
grid
legend(str)
legend('location','SouthEast')
title('Capacitance against time plot')
xlabel('Time')
ylabel('Memcapacitance')

figure('Name','Ratio of maximum memristance over memcapacitance against frequency')
stem(FREQUENCY, Ratio23)
xlabel('Frequency')
ylabel('|\Delta M/ \Delta C|')
grid

figure('Name','Delta of memcapacitance against frequency')
plotyy(FREQUENCY, Delta_Memcap_v_freq,FREQUENCY, Delta_Memri_v_freq)
xlabel('Frequency')
ylabel('|\Delta C|')
grid

figure('Name','Ratio of memcapacitance against frequency')
plotyy(FREQUENCY, Ratio_Memcap_v_freq,FREQUENCY, Ratio_Memri_v_freq)
xlabel('Frequency')
ylabel('|\Delta C|')
grid