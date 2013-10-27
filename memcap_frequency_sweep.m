clearvars;
close all;

TIME_END=30;     %In secs

FREQUENCY=[0.01, 0.10, 1, 10, 30, 50, 80, 100, 150, 200, 250, 300, 350, 400, 450:50:2000];  %frequency of the sinusoidal input in Hz

% FREQUENCY=[0.01, 0.10, 1, 10, 100, 1000];%frequency of the sinusoidal input in Hz


TIME_STEP=1/(2*6*max(FREQUENCY)); 


C_init = 1e-6;   %In F
C_max = 10*1e-6;
C_min = 10*1e-9;
kappa = 10*1e6;
input_ampl = 0.1;

%----------------------------------------------------------------------
t=[0:TIME_STEP:TIME_END]; %Vector containing time values

% matlabpool open local 4
parfor l=1:length(FREQUENCY);
    input_v(l,:)=input_ampl*sin(2*pi*FREQUENCY(l)*t); % store sine as input


%% Calculation of the input integral
    integr_v(l,:)=zeros(1,length(t));
    
    integr_v(l,:)=TIME_STEP*cumtrapz(input_v(l,:));

    [ c(l,:),q(l,:),integr_q(l,:) ] = memcap( C_init, C_max, C_min, kappa, input_v(l,:) , integr_v(l,:), t, TIME_STEP);
end



predicted = min_memcapa(C_init, C_max, C_min, kappa,input_ampl,FREQUENCY);

memcap_sim_min = zeros(1,length(FREQUENCY));
for i=1:length(FREQUENCY)
    memcap_sim_min(i)=  min(c(i,:));
end


% matlabpool close
%--------------------------------------------------------------------

%% Plotting

%--------------------------------------------------------------------

for l=1:length(FREQUENCY)
            str(l,:)=sprintf('%1.2e Hz', FREQUENCY(l));
end

if 1
%INPUT voltage waveform
figure('Name','Against time plots')
subplot(3,1,1)
plot(t,input_v(1,:), t,input_v(2,:), t,input_v(3,:), t,input_v(4,:), t,input_v(5,:),t,input_v(6,:))
grid
xlabel('Time')
ylabel('Input Voltage')
%OUTPUT Charge waveform
subplot(3,1,2)
plot(t,q(1,:), t,q(2,:), t,q(3,:), t,q(4,:), t,q(5,:), t,q(6,:))
grid
title('Charge against time plot')
xlabel('Time')
ylabel('Charge')
%OUTPUT Charge waveform
subplot(3,1,3)
plot(t,c(1,:), t,c(2,:), t,c(3,:), t,c(4,:), t,c(5,:), t,c(6,:))
grid
title('Capacitance against time plot')
xlabel('Time')
ylabel('Capacitance')
legend(str)

%V-Q PLOT
figure('Name','Charge against voltage')
plot(input_v(1,:),q(1,:), input_v(2,:),q(2,:), input_v(3,:),q(3,:), input_v(4,:),q(4,:), input_v(5,:),q(5,:), input_v(6,:),q(6,:))
grid
xlabel('Voltage')
ylabel('Charge')
legend(str)

%V-I PLOT
figure('Name','Current against voltage')
plot(input_v(1,:),integr_q(1,:), input_v(2,:),integr_q(2,:), input_v(3,:),integr_q(3,:), input_v(4,:),integr_q(4,:), input_v(5,:),integr_q(5,:), input_v(6,:),integr_q(6,:))
grid
xlabel('Voltage')
ylabel('Current')
legend(str)
end


figure('Name','Minimum Capacitance against frequency')
stem(FREQUENCY,[memcap_sim_min(1,:).', predicted(1,:).'])
xlabel('Frequency')
legend('simulated','predicted')
grid
