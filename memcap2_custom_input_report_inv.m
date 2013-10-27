clearvars
close all

CYCLES = 2;

%Input Parameters
VOLTAGE_STEP = 0.3;
VOLTAGE_MAX = 1;
PULSE_LENGTH = 3e-6;
PULSE_PAUSE = 2e-6;
TIME_STEP = 0.5e-7;


C_init = 1.1696e-07;   %In F
C_max = 10*1e-7;
C_min = 10*1e-8;
kappa = 10*1e10;

D_max = 1/C_min;
D_min = 1/C_max;
D0 = 1/C_init;
delta_D = D_max - D_min;

% fn_handles = {@(x) window_fn_NO_WINDOW()};

 fn_handles ={@(x) window_fn_Prodro(x,0.5,-1);
        @(x) window_fn_Prodro(x,0.5,-5);
        @(x) window_fn_Prodro(x,0.5,-10);
        @(x) window_fn_Prodro(x,1,-1);
        @(x) window_fn_Prodro(x,5,-1);
        @(x) window_fn_Prodro(x,10,-1)};
    
    
 amp = input_custom_pulse_pre_amp_b( VOLTAGE_MAX, VOLTAGE_STEP );

%----------------------------------------------------------------------

[input_v, tspan ] = input_test_b( CYCLES, PULSE_PAUSE, PULSE_LENGTH, VOLTAGE_MAX, VOLTAGE_STEP, TIME_STEP ); % store sine as input

input_fn = @(t) input_custom_pulse(t,amp, PULSE_PAUSE, PULSE_LENGTH);

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
    
    y(ii,:) = (D(ii,:)- D_min)/delta_D;
%     y(ii,:) = -(D(ii,:)- D_max)/delta_D;
end

%% Plotting

str_leg = func2legend(fn_handles);

figure('Name', 'Current against voltage') 
hold all
for ii = 1:length(fn_handles)
    plot(input_v(1,1:end-1), I(ii,:) , get_line_spec( ii ))
end
ylabel('Current - I (A)')
xlabel('Input Voltage - V (V)')
legend(str_leg)
leg_handle=legend(str_leg);
set(leg_handle,'location','NorthEast')
set(leg_handle,'FontSize',7);
grid


figure('Name', 'State variable against time') 
hold all
for ii = 1:length(fn_handles)
    plot(tspan, y(ii,:),get_line_spec( ii ))
end
ylabel('State Variable y')
xlabel('Time - t (s)')
leg_handle=legend(str_leg);
set(leg_handle,'location','NorthEast')
set(leg_handle,'FontSize',7);
line(tspan,ones(1,length(tspan)),'Color', 'k', 'LineStyle','--')
axis tight

figure('Name', 'Capacitance against time') 
subplot(211)
hold all
ii=1;
[ax,hline1,hline2] = plotyy(tspan, C(ii,:),tspan, input_v);
set(get(ax(2), 'YLabel'), 'String', 'Input voltage')
set(hline1,'LineStyle', get_line_style( ii ), 'LineWidth',1.5)
set(hline2, 'DisplayName', 'Input Data')
for ii = 2:length(fn_handles)
    ax = plot(tspan, C(ii,:),get_line_spec( ii ), 'LineWidth',1.5);
end
ylabel('Capacitance - C (C)')
xlabel('Time - t (s)')
leg_handle=legend(str_leg);
set(leg_handle,'location','SouthEast')
set(leg_handle,'FontSize',7);
axis tight
hold off
subplot(212)




figure('Name', 'Capacitance against time') 
hold all
ii=1;
[ax,hline(1),hline(2)] = plotyy(CYCLES*tspan./tspan(end), C(ii,:),CYCLES*tspan./tspan(end), input_v);
set(get(ax(2), 'YLabel'), 'String', 'Input voltage')
set(hline(1),'Color', get_line_colour( 1 ), 'LineWidth',1.5)
set(hline(2), 'DisplayName', 'Input Data')
set(hline(2),'Color', 'b','LineStyle','-.', 'LineWidth',1.0)
for ii = 2:length(fn_handles)
    hline(2+ii) = line(CYCLES*tspan./tspan(end), C(ii,:), 'LineWidth',1.5);
    set(hline(2+ii), 'Color', get_line_colour(ii));
end
ylabel('Capacitance - C ')
xlabel('Normalised Time ')
leg_handle=legend(str_leg);
set(leg_handle,'location','SouthEast')
set(leg_handle,'FontSize',7);
axis tight