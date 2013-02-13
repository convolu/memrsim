clearvars;
close all;

TIME_END=4;     %In secs
% FREQUENCY=[ 100, 800, 1e3, 1e4];  %frequency of the sinusoidal input in Hz

FREQUENCY=[1, 10, 30, 50, 80, 100, 150, 200, 300, 350, 400,800,1000];  %frequency of the sinusoidal input in Hz


TIME_STEP=1/(2*6*max(FREQUENCY)); 

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
t=[0:TIME_STEP:TIME_END]; %Vector containing time values


parfor l=1:length(FREQUENCY)
input_v(l,:)=input_ampl*sin(2*pi*FREQUENCY(l)*t); % store sine as input


%% Calculation of the input integral
integr_v(l,:) = zeros(1,length(t));

integr_v(l,:) = TIME_STEP*cumtrapz(input_v(l,:));



[ m(l,:), i(l,:) ,q(l,:) ] = memristor( W0, D, Ron, Roff,u , input_v(l,:) , integr_v(l,:), t, TIME_STEP );
[ c(l,:),q_memcap(l,:),i_memcap(l,:) ] = memcap( C_init, C_max, C_min, kappa, input_v(l,:) , integr_v(l,:), t, TIME_STEP);

Ratio_t(l,:)= m(l,:)./c(l,:);
Ratio(l) = max(Ratio_t(l,:));
Ratio23(l) = (max(m(l,:))- min(m(l,:)))/(max(c(l,:))- min(c(l,:)));
Memcap_v_freq(l)= (max(c(l,:))- min(c(l,:)));
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

%Against Time plots
figure('Name','Capacitance against time plot')
plotyy(t,m, t,c)
grid
legend(str)
title('Memristance, Capacitance against time plot')
xlabel('Time')
ylabel('Memristance')

figure('Name','Ratio of maximum memristance over memcapacitance against frequency')
stem(FREQUENCY, Ratio23)
xlabel('Frequency')
ylabel('|\Delta M/ \Delta C|')
grid

figure('Name','Ratio of maximum memristance over memcapacitance against frequency')
stem(FREQUENCY, Memcap_v_freq)
xlabel('Frequency')
ylabel('|\Delta C|')
grid