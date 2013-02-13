clearvars
close all

C_init = 1e-7;   %In F
C_max = 10*1e-7;
C_min = 10*1e-10;
kappa = 10*1e6;

A = 0.1;

D_max = 1/C_min;
D_min = 1/C_max;
D0 = 1/C_init;
delta_D = D_max - D_min;

f = linspace(0,10,100);
DC = 1./sqrt(D0^2 - 2*delta_D*kappa*A./(pi*f)) - 1./sqrt(D0^2 + 2*delta_D*kappa*A./(pi*f));

plot(f,DC)
grid

f_crit = 2*delta_D*kappa*A/(pi*D0^2);
DC_tran = DC';