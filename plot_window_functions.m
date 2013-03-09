clearvars
close all


fn_handles = {@(x) window_fn_Prodro(x,0.5,1);
        @(x) window_fn_Prodro(x,0.5,10);
        @(x) window_fn_Prodro(x,0.5,40);
        @(x) window_fn_Prodro(x,1,1);
        @(x) window_fn_Prodro(x,10,1);
        @(x) window_fn_Prodro(x,15,1);
        @(x) window_fn_Strukov(x);
        @(x) window_fn_Joglekar(x,2)};
    
    xx=linspace(0,1,100);
   
    parfor ii=1:length(fn_handles)
        F(ii,:) = arrayfun(fn_handles{ii},xx);
    end

    legend_str = func2legend(fn_handles);
    figure
    hold all
    for ii=1:length(fn_handles)
        plot(xx,F(ii,:),get_line_style( ii ))
    end
    leg_handle=legend(legend_str);
    set(leg_handle,'FontSize',7);
    xlabel('x');
    ylabel('F(x)');
    
    