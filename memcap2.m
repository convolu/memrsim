clearvars;
close all;

TIME_END=30;     %In secs
TIME_STEP=0.005; %Sampling frequency in seconds
FREQUENCY=0.16;  %frequency of the sinusoidal input in Hz

C_init = 1e-6;   %In F
C_max = 10*1e-6;
C_min = 10*1e-9;
kappa = 10*1e6;
input_ampl = 0.1;

%----------------------------------------------------------------------
t=[0:TIME_STEP:TIME_END]; %Vector containing time values
input_v=input_ampl*sin(2*pi*FREQUENCY*t); % store sine as input


%% Calculation of the input integral
integr_v=zeros(1,length(t));

integr_v=TIME_STEP*cumtrapz(input_v(:));

[ c,q,integr_q ] = memcap( C_init, C_max, C_min, kappa, input_v , integr_v, t, TIME_STEP);


%--------------------------------------------------------------------

%% Plotting

%--------------------------------------------------------------------

%INPUT voltage waveform
figure('Name','Against time plots')
subplot(4,1,1)
plot(t,input_v)
grid
xlabel('Time')
ylabel('Input Voltage')
%OUTPUT Charge waveform
subplot(4,1,2)
plot(t,q)
grid
title('Charge against time plot')
xlabel('Time')
ylabel('Charge')
%OUTPUT Charge waveform
subplot(4,1,3)
plot(t,integr_q)
grid
title('Current against time plot')
xlabel('Time')
ylabel('Current')
%OUTPUT Capacitance waveform
subplot(4,1,4)
plot(t,c)
grid
title('Capacitance against time plot')
xlabel('Time')
ylabel('Capacitance')

%V-Q PLOT
figure('Name','Charge against voltage')
plot(input_v,q)
grid
% legend(str1,str2)
% legend('location','SouthEast')
xlabel('Voltage')
ylabel('Charge')

%V-I PLOT
figure('Name','Current against voltage')
plot(input_v,integr_q)
grid
% legend(str1,str2)
% legend('location','SouthEast')
xlabel('Voltage')
ylabel('Current')
