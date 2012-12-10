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
D_max = 1/C_min;
D_min = 1/C_max;

D0 = 1/C_init;


delta_D = D_max - D_min;


t=[0:TIME_STEP:TIME_END]; %Vector containing time values


input_v=input_ampl*sin(2*pi*FREQUENCY*t); % store sine as input

%% Calculation of the input integral
integr_v=zeros(1,length(t));
for j=1:length(t)
    integr_v(j)=TIME_STEP*trapz(input_v(1:j));
end
%% Calculation of the output charge value

c=zeros(1,length(t));
 for m=1:length(t)
    c(m)=1/sqrt(D0^2+2*delta_D*kappa*integr_v(m));  
 end
 
 q = input_v.*c;
 
 %% Calculation of the output current
integr_q=zeros(1,length(t));
for j=1:length(t)
    integr_q(j)=TIME_STEP*trapz(q(1:j));
end
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
plot(t,q)
grid
title('Charge against time plot')
xlabel('Time')
ylabel('Charge')
%OUTPUT Charge waveform
subplot(3,1,3)
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
ylabel('Charge')
