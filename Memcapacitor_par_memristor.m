clearvars;
close all;

TIME_END=30;     %In secs
TIME_STEP=0.05; %Sampling frequency in seconds
FREQUENCY=0.16;  %frequency of the sinusoidal input in Hz

W0 = 5*1e-9;
D = 10*1e-9;
Ron = 1e2;
Roff = 16*1e3;
u = 1e-14;

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



[ m, i ,q ] = memristor( W0, D, Ron, Roff,u , input_v , integr_v, t, TIME_STEP );
[ c,q_memcap,integr_q_memcap ] = memcap( C_init, C_max, C_min, kappa, input_v , integr_v, t, TIME_STEP);

%V-I PLOT
figure('Name','Current against voltage')
plot(input_v,integr_q_memcap+i)
grid
% legend(str1,str2)
% legend('location','SouthEast')
xlabel('Voltage')
ylabel('Current')


