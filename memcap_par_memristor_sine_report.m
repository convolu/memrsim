clearvars
close all

SEVERE =1;

CYCLES = 2;
sampling_coeff=10000;
if (SEVERE==1)
    FREQUENCY=2; %Severe
else
    FREQUENCY=10;   %Mild 
end

TIME_END= CYCLES./FREQUENCY;
TIME_STEP=1./(2*sampling_coeff*FREQUENCY);

%In F
% C_init = 9e-7;   %In F
% C_max = 10*1e-7;
% C_min = 10*1e-9;
% kappa = 10*1e6;

C_init = 21e-9;   %In F
C_max = 10*1e-7;
C_min = 10*1e-9;
kappa = 10*1e6;


D_max = 1/C_min;
D_min = 1/C_max;
D0 = 1/C_init;
delta_D = D_max - D_min;

W0 = 5*1e-9;
L = 10*1e-9;
Ron = 200;
Roff = 10000;
u = 3e-15;
M_init = 0.95*Roff;

fn_handles = {@(x) window_fn_Prodro(x,4,-1)};
fn_handles_memr = {@(x) window_fn_Prodro(x,10,1)};

if (SEVERE==1)
    input_ampl = 3; %Severe
else
    input_ampl = 5; %Mild
end
sprintf('%f should be larger than %f',D0^2/(2*delta_D*kappa), input_ampl/(pi*FREQUENCY))

%----------------------------------------------------------------------
tspan = zeros(length(FREQUENCY),2*sampling_coeff*CYCLES+1);

for iii=1:length(FREQUENCY)
tspan(iii,:)=[0:TIME_STEP(iii):TIME_END(iii)]; %Vector containing time values
end

input_v = input_ampl*sin(2*pi*FREQUENCY*tspan); % store sine as input

input_fn = @(t) input_sine( t, input_ampl , FREQUENCY ) ;

input_fn_c = @(t) input_sine( t, 5 , 1 ) ;
tspan_c = zeros(length(FREQUENCY),2*sampling_coeff*CYCLES+1);

for iii=1:length(FREQUENCY)
tspan_c(iii,:)=[0:1/(2*sampling_coeff*1):CYCLES./1]; %Vector containing time values
end

D = zeros(length(fn_handles),length(tspan));

M = zeros(length(fn_handles_memr),length(tspan));

for ii = 1:length(fn_handles)
    window_fn = fn_handles{ii};
    ode = @(t,D) window_dD_dt(t,D,delta_D, D_min,kappa, input_fn_c , window_fn );
    options=odeset('RelTol',1e-6,'AbsTol',1e-8,'Stats','on');
    %Try 23s,23t or 23tb
    [~,D(ii,:)]=ode23s(ode,tspan_c,D0 , options);
    
    Q(ii,:) = input_v ./ D(ii,:);
    
    I(ii,:) = diff(Q(ii,:)) ./ diff (tspan_c);
    
    C(ii,:) = 1 ./ D(ii,:);
    
    y(ii,:) = (D(ii,:)- D_min)/delta_D;
end

for ii = 1:length(fn_handles_memr)
    window_fn = fn_handles_memr{ii};
    ode2 = @(t,M) window_dM_dt(t,M,Ron,Roff,u,L,input_fn,window_fn );
    options=odeset('RelTol',1e-5,'AbsTol',1e-7,'Stats','on');
    %Try 23s,23t or 23tb
    [~,M(ii,:)]=ode23s(ode2,tspan, M_init , options);
    
    I_memr(ii,:) = input_v ./ M(ii,:);
    
    x(ii,:) = (M(ii,:)- Roff)/(Ron-Roff);
end

%% Plotting

str_leg = func2legend(fn_handles);
str_leg2 = func2legend(fn_handles_memr);

figure('Name', 'Current against voltage') 
hold all
for ii = 1:length(fn_handles)
    plot(input_v(1,1:end-1), I(ii,:)+I_memr(ii,(1:(end-1))) , get_line_spec( ii ))
end
ylabel('Current - I (A)')
xlabel('Input Voltage - V (V)')
legend(str_leg)
leg_handle=legend(str_leg);
set(leg_handle,'location','NorthEast')
set(leg_handle,'FontSize',7);
grid

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


% figure('Name', 'State variable against time') 
% hold all
% for ii = 1:length(fn_handles)
%     plot(tspan, y(ii,:),get_line_spec( ii ))
% end
% ylabel('State Variable y')
% xlabel('Time - t (s)')
% leg_handle=legend(str_leg);
% set(leg_handle,'location','NorthEast')
% set(leg_handle,'FontSize',7);
% line(tspan,ones(1,length(tspan)),'Color', 'k', 'LineStyle','--')
% axis tight

% figure('Name', 'Inverse Capacitance against time') 
% hold all
% for ii = 1:length(fn_handles)
%     plot(tspan, D(ii,:),get_line_spec( ii ))
% end
% ylabel('Inverse Capacitance - D (1/C)')
% xlabel('Time - t (s)')
% legend(str_leg)
% legend('location','SouthEast')
% grid;
% 
figure('Name', 'Capacitance against time') 
hold all
[AX,H1,H2] = plotyy(tspan, input_v, tspan, C(:));
set(get(AX(1),'Ylabel'),'String','Input Voltage - (V)') 
set(get(AX(2),'Ylabel'),'String','Memcapacitance')
xlabel('Time - t (s)')
set(H1,'LineWidth', 2.0)
set(H2,'LineWidth', 2.0)
set(AX(2),'Ylim',[C_min-0.5e-7,C_max+0.5e-7])
line(tspan,C_min*ones(1,length(tspan)),'LineWidth', 2.0,'LineStyle','-.','Parent', AX(2));
line(tspan,C_max*ones(1,length(tspan)),'LineWidth', 2.0,'LineStyle','-.','Parent', AX(2));
leg_handle = legend(AX(2),str_leg);
set(leg_handle,'location','SouthEast')
set(leg_handle,'FontSize',10);
grid;

figure('Name', 'Memristance against time') 
hold all
[AX,H1,H2] = plotyy(tspan, input_v, tspan, M(:));
set(get(AX(1),'Ylabel'),'String','Input Voltage - (V)') 
set(get(AX(2),'Ylabel'),'String','Memristance')
set(AX(2),'Ylim',[Ron-100,Roff+100])
set(H1,'LineWidth', 2.0)
set(H2,'LineWidth', 2.0)
line(tspan,Ron*ones(1,length(tspan)),'LineWidth', 2.0,'LineStyle','-.','Parent', AX(2));
line(tspan,Roff*ones(1,length(tspan)),'LineWidth', 2.0,'LineStyle','-.','Parent', AX(2));
xlabel('Time - t (s)')
leg_handle = legend(AX(2),str_leg2);
set(leg_handle,'location','SouthEast')
set(leg_handle,'FontSize',10);
grid;



% figure('Name', 'Memristance against time') 
% hold all
% for ii = 1:length(fn_handles)
%     plot(tspan, M(ii,:),get_line_spec( ii ))
% end
% ylabel('Memristance - C (C)')
% xlabel('Time - t (s)')
% legend(str_leg)
% legend('location','SouthEast')
% grid;



% figure('Name', 'I,Q against time') 
% hold all
% for ii = 1:length(fn_handles)
%     [AX,H1,H2]=plotyy(tspan(1:(end-1)), I(ii,:),tspan(1:(end-1)), Q(ii,1:(end-1)));
% end
% set(get(AX(1),'Ylabel'),'String','Current - I') 
% set(get(AX(2),'Ylabel'),'String','Charge - Q') 
% xlabel('Time - t (s)')
% legend(str_leg)
% legend('location','SouthEast')
% grid;
% D_max - D_max_f(delta_D, kappa, input_ampl, D0, FREQUENCY)
