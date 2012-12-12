clearvars;
close all;

TIME_END=30;     %In secs

FREQUENCY=[1, 10, 30, 50, 80, 100, 150, 200, 300, 350, 400];  %frequency of the sinusoidal input in Hz

TIME_STEP=1/(2*6*max(FREQUENCY)); 


W0 = 5*1e-9;
D = 10*1e-9;
Ron = 1e2;
Roff = 16*1e3;
u = 1e-14;
input_ampl = 0.1;

%----------------------------------------------------------------------
t=[0:TIME_STEP:TIME_END]; %Vector containing time values

% matlabpool open local 4
parfor l=1:length(FREQUENCY);
    input_v(l,:)=input_ampl*sin(2*pi*FREQUENCY(l)*t); % store sine as input


%% Calculation of the input integral
    integr_v(l,:)=zeros(1,length(t));
    
    integr_v(l,:)=TIME_STEP*cumtrapz(input_v(l,:));

    [ m(l,:), i(l,:) ,q(l,:) ] = memristor( W0, D, Ron, Roff,u , input_v(l,:) , integr_v(l,:), t, TIME_STEP );
end



predicted = max_memri(W0, D, Ron, Roff,u,input_ampl, FREQUENCY);

memrist_sim_max = zeros(1,length(FREQUENCY));
for ii=1:length(FREQUENCY)
    memrist_sim_max(ii)=  max(m(ii,:));
end


% matlabpool close
%--------------------------------------------------------------------

%% Plotting

%--------------------------------------------------------------------

for l=1:length(FREQUENCY)
            str(l,:)=sprintf('%1.2e Hz', FREQUENCY(l));
end

if 0
%INPUT voltage waveform
figure('Name','Against time plots')
subplot(3,1,1)
plot(t,input_v(1,:), t,input_v(2,:), t,input_v(3,:), t,input_v(4,:), t,input_v(5,:),t,input_v(6,:))
grid
xlabel('Time')
ylabel('Input Voltage')
%OUTPUT Charge waveform
subplot(3,1,2)
plot(t,i(1,:), t,i(2,:), t,i(3,:), t,i(4,:), t,i(5,:), t,i(6,:))
grid
title('Charge against time plot')
xlabel('Time')
ylabel('Charge')
%OUTPUT Charge waveform
subplot(3,1,3)
plot(t,m(1,:), t,m(2,:), t,m(3,:), t,m(4,:), t,m(5,:), t,m(6,:))
grid
title('Memristance against time plot')
xlabel('Time')
ylabel('Memristance')
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
plot(input_v(1,:),i(1,:), input_v(2,:),i(2,:), input_v(3,:),i(3,:), input_v(4,:),i(4,:), input_v(5,:),i(5,:), input_v(6,:),i(6,:))
grid
xlabel('Voltage')
ylabel('Current')
legend(str)
end


figure('Name','Maximum Memristance against frequency')
stem(FREQUENCY,[memrist_sim_max(1,:).', predicted(1,:).'])
xlabel('Frequency')
legend('simulated','predicted')
grid
