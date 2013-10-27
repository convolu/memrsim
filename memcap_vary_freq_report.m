clearvars
close all

SEVERE =1;
VARIOUS_WIND = 1;
AGAINST_FREQ_SECTION =1;

CYCLES = 2;
sampling_coeff=10000;
% if (SEVERE==1)
%     FREQUENCY=0.15; %Severe
% else
%     FREQUENCY=10;   %Mild 
% end

if (AGAINST_FREQ_SECTION == 1)
    FREQUENCY = [0.1, 0.5, 1, 5, 10, 20, 50, 100, 500];
else
    FREQUENCY = [1, 10, 100, 500 ];
end

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

% if (VARIOUS_WIND==1)    
%     fn_handles = {@(x) window_fn_NO_WINDOW();
%         @(x) window_fn_Prodro(x,0.5,40);
%         @(x) window_fn_Prodro(x,1,2);
%         @(x) window_fn_Prodro(x,8,1);
%         @(x) window_fn_Strukov(x);
%         @(x) window_fn_Joglekar(x,2)};
%     
% else
%     fn_handles = {;
%         @(x) window_fn_Prodro(x,0.5,1);
%         @(x) window_fn_Prodro(x,0.5,10);
%         @(x) window_fn_Prodro(x,0.5,40);
%         @(x) window_fn_Prodro(x,1,1);
%         @(x) window_fn_Prodro(x,5,1)
%         @(x) window_fn_Prodro(x,10,1)};
% end

fn_handles = @(x) window_fn_NO_WINDOW();

% if (SEVERE==1)
%     input_ampl = 5; %Severe
% else
%     input_ampl = 15; %Mild
% end

input_ampl = 2 ;

%----------------------------------------------------------------------
tspan = zeros(length(FREQUENCY),2*sampling_coeff*CYCLES+1);

D = zeros(length(FREQUENCY),length(tspan(1,:)));


parfor iii=1:length(FREQUENCY)
    tspan(iii,:)=[0:TIME_STEP(iii):TIME_END(iii)]; %Vector containing time values
    
    input_v (iii,:) = input_ampl*sin(2*pi*FREQUENCY(iii)*tspan(iii,:)); % store sine as input
    
    input_fn = @(t) input_sine( t, input_ampl , FREQUENCY(iii) ) ;
    
%     D = zeros(length(FREQUENCY),length(tspan(iii,:)));
    
    window_fn = fn_handles;
    ode = @(t,D) window_dD_dt(t,D,delta_D, D_min,kappa, input_fn , window_fn );
    options=odeset('RelTol',1e-8,'AbsTol',1e-9,'Stats','on');
    %Try 23s,23t or 23tb
    [~,D(iii,:)]=ode23s(ode,tspan(iii,:),D0 , options);
    
    Q(iii,:) = input_v(iii,:) ./ D(iii,:);
    
    I(iii,:) = diff(Q(iii,:)) ./ diff (tspan(iii,:));
    
    C(iii,:) = 1 ./ D(iii,:);
    
    y(iii,:) = (D(iii,:)- D_min)/delta_D;

end

%% Plotting

str_leg = freq2legend(FREQUENCY);

figure('Name', 'Current against voltage') 
hold all
for ii = 1:length(FREQUENCY)
    plot(input_v(ii,1:end-1), I(ii,:) , get_line_spec( ii ),'Linewidth',2.0)
end
ylabel('Current - I (A)')
xlabel('Input Voltage - V (V)')
legend(str_leg)
leg_handle=legend(str_leg);
set(leg_handle,'location','NorthEast')
set(leg_handle,'FontSize',10);
axis tight;
grid


figure('Name', 'State variable against time') 
hold all
for ii = 1:length(FREQUENCY)
    plot(tspan(ii,:), y(ii,:),get_line_spec( ii ))
end
ylabel('State Variable y')
xlabel('Time - t (s)')
leg_handle=legend(str_leg);
set(leg_handle,'location','NorthEast')
set(leg_handle,'FontSize',7);
line(tspan,ones(1,length(tspan)),'Color', 'k', 'LineStyle','--')
axis tight

% figure('Name', 'Inverse Capacitance against time') 
% hold all
% for ii = 1:length(FREQUENCY)
%     plot(tspan, D(ii,:),get_line_spec( ii ))
% end
% ylabel('Inverse Capacitance - D (1/C)')
% xlabel('Time - t (s)')
% legend(str_leg)
% legend('location','SouthEast')
% grid;
% 
% figure('Name', 'Capacitance against time') 
% hold all
% for ii = 1:length(FREQUENCY)
%     plot(tspan, C(ii,:),get_line_spec( ii ))
% end
% ylabel('Capacitance - C (C)')
% xlabel('Time - t (s)')
% legend(str_leg)
% legend('location','SouthEast')
% grid;

% figure('Name', 'I,Q against time') 
% hold all
% for ii = 1:length(FREQUENCY)
%     [AX,H1,H2]=plotyy(tspan(ii,1:(end-1)), I(ii,:),tspan(ii,1:(end-1)), Q(ii,1:(end-1)));
% end
% set(get(AX(1),'Ylabel'),'String','Current - I') 
% set(get(AX(2),'Ylabel'),'String','Charge - Q') 
% xlabel('Time - t (s)')
% legend(str_leg)
% legend('location','SouthEast')
% grid;

figure('Name', 'Charge against Voltage') 
hold all
for ii = 1:length(FREQUENCY)
    plot(input_v(ii,:), Q(ii,:) , get_line_spec( ii ), 'Linewidth',2.0);
end
ylabel('Charge - Q')
xlabel('Input Voltage - V (V)')
legend(str_leg)
leg_handle=legend(str_leg);
set(leg_handle,'location','NorthWest')
set(leg_handle,'FontSize',10);
grid;


if (AGAINST_FREQ_SECTION==1)
    for ii=1:length(FREQUENCY)
        temp1(ii) =  max(D(ii,:));
        temp2(ii) = min(D(ii,:));
    end
    
    predicted = min_memcapa(C_init, C_max, C_min, kappa,input_ampl,FREQUENCY);
    
    
    figure('Name', 'Delta_D')
    hold all
    % plot(FREQUENCY, temp1,get_line_spec(1));
    plot(FREQUENCY, temp1,'LineStyle','-', 'LineWidth',3.0);
    plot(FREQUENCY, 1./predicted, 'LineStyle' ,'-.' ,  'LineWidth',3.0);
    line(FREQUENCY,D0*ones(1,length(FREQUENCY)),'Color', 'k', 'LineStyle','--');
    leg_handle = legend('Simulated', 'Predicted', 'D_0');
    set(leg_handle,'FontSize',10);
    ylabel('D_{max}')
    xlabel('Frequency (Hz)')
    grid
end

