clearvars
close all

CYCLES = 2;
sampling_coeff=10000;
% FREQUENCY=0.13; %For severe
FREQUENCY=2; %For mild
TIME_END= CYCLES./FREQUENCY;
TIME_STEP=1./(2*sampling_coeff*FREQUENCY);

C_init = 1e-7;   %In F
C_max = 10*1e-7;
C_min = 10*1e-9;
kappa = 10*1e6;

D_max = 1/C_min;
D_min = 1/C_max;
D0 = 1/C_init;
delta_D = D_max - D_min;

fn_handles = {@(x) window_fn_NO_WINDOW();
      @(x) window_fn_Prodro(x,0.5,75);
    @(x) window_fn_Prodro(x,1,2);
    @(x) window_fn_Prodro(x,8,1);
    @(x) window_fn_Strukov(x);
    @(x) window_fn_Joglekar(x,1)};

% input_ampl = 53;

input_ampl = 5;

sprintf('%f should be larger than %f',D0^2/(2*delta_D*kappa), input_ampl/(pi*FREQUENCY))

%----------------------------------------------------------------------
tspan = zeros(length(FREQUENCY),2*sampling_coeff*CYCLES+1);

for iii=1:length(FREQUENCY)
tspan(iii,:)=[0:TIME_STEP(iii):TIME_END(iii)]; %Vector containing time values
end

input_v = input_ampl*sin(2*pi*FREQUENCY*tspan); % store sine as input

input_fn = @(t) input_sine( t, input_ampl , FREQUENCY ) ;

D = zeros(length(fn_handles),length(tspan));

parfor ii = 1:length(fn_handles)
    window_fn = fn_handles{ii};
    ode = @(t,D) window_dD_dt(t,D,delta_D, D_min,kappa, input_fn , window_fn );
    options=odeset('RelTol',1e-8,'AbsTol',1e-9,'Stats','on');
    %Try 23s,23t or 23tb
    [~,D(ii,:)]=ode23s(ode,tspan,D0 , options);
    
    Q(ii,:) = input_v ./ D(ii,:);
    
    I(ii,:) = diff(Q(ii,:)) ./ diff (tspan);
    
    C(ii,:) = 1 ./ D(ii,:);
end

%% Plotting
str_leg = { 'No Window';
    'Prodromakis j=0.5, p=75';
    'Prodromakis j=1, p=2';
    'Prodromakis j=8, p=1';
    'Strukov';
    'Joglekar p=1'};

figure('Name', 'Current against voltage') 
hold all
for ii = 1:length(fn_handles)
    plot(input_v(1,1:end-1), I(ii,:) , get_line_style( ii ))
end
ylabel('Current - I (A)')
xlabel('Input Voltage - V (V)')
legend(str_leg)
legend('location','SouthEast')
grid;

figure('Name', 'Charge against Voltage') 
hold all
for ii = 1:length(fn_handles)
    plot(input_v, abs(Q(ii,:)) , get_line_style( ii ))
end
ylabel('Charge - Q (C)')
xlabel('Input Voltage - V (V)')
legend(str_leg)
legend('location','SouthEast')
grid;

figure('Name', 'Inverse Capacitance against time') 
hold all
for ii = 1:length(fn_handles)
    plot(tspan, D(ii,:),get_line_style( ii ))
end
ylabel('Inverse Capacitance - D (1/C)')
xlabel('Time - t (s)')
legend(str_leg)
legend('location','SouthEast')
grid;

figure('Name', 'Capacitance against time') 
hold all
for ii = 1:length(fn_handles)
    plot(tspan, C(ii,:),get_line_style( ii ))
end
ylabel('Capacitance - C (C)')
xlabel('Time - t (s)')
legend(str_leg)
legend('location','SouthEast')
grid;

