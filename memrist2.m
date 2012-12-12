clearvars;
close all;

TIME_END=30;     %In secs
TIME_STEP=0.005; %Sampling frequency in seconds
FREQUENCY=0.16;  %frequency of the sinusoidal input in Hz

W0 = 5*1e-9;
D = 10*1e-9;
Ron = 1e2;
Roff = 16*1e3;
u = 1e-14;
input_ampl = 0.1;

%----------------------------------------------------------------------
t=[0:TIME_STEP:TIME_END]; %Vector containing time values
input_v=input_ampl*sin(2*pi*FREQUENCY*t); % store sine as input


%% Calculation of the input integral
integr_v=TIME_STEP*cumtrapz(input_v(:));


[ m, i ,q ] = memristor( W0, D, Ron, Roff,u , input_v , integr_v, t, TIME_STEP );

%--------------------------------------------------------------------

%% Plotting

%--------------------------------------------------------------------

%INPUT voltage waveform
figure('Name','Against time plots')
subplot(3,1,1)
plot(t,input_v)
grid
xlabel('Time')
ylabel('Input Voltage')
%OUTPUT Charge waveform
subplot(3,1,2)
plot(t,i)
grid
title('Current against time plot')
xlabel('Time')
ylabel('Current')
%OUTPUT Charge waveform
subplot(3,1,3)
plot(t,m)
grid
title('Memristance against time plot')
xlabel('Time')
ylabel('Memristance')

%V-Q PLOT
figure('Name','Charge against voltage')
plot(input_v(1:length(q)),q)
grid
% legend(str1,str2)
% legend('location','SouthEast')
xlabel('Voltage')
ylabel('Charge')

%V-I PLOT
figure('Name','Current against voltage')
plot(input_v,i)
grid
% legend(str1,str2)
% legend('location','SouthEast')
xlabel('Voltage')
ylabel('Current')
