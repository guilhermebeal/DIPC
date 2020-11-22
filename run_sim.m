function [t,x,y,u,r,E] = run_sim( tt , T , Ts , x0 )

global sat

Ns = round(tt/Ts);
N = round(tt/T);

u = zeros(1,N);
r = zeros(1,N);
y = zeros(3,N);
x = zeros(6,N);
t = T*(0:(N-1));
E = zeros(1,N);

xs = x0;
us = 0;
k = 0;

ts = Ts*(0:(Ns-1));
disp('Rodando Simulação')
for i=1:Ns

	% Sistema de Controle
    if rem( ts(i) , T ) == 0       
        k=k+1;   
        x(:,k) = xs;                   	% Vetor de estados
        y(:,k) = [x(1,k);x(2,k);x(3,k)]; % Sinal de saída   
        r(:,k) = setpoint( t(k) );      % Sinal de Referência

        [us,E(:,k)] = control( t(k) , y(:,k) , r(:,k) , x(:,k) );  % Lei de controle
        
        if us > sat
            us = sat;
        elseif us < -sat
            us = -sat;
        end 
        u(:,k) = us;
    end

    % Planta
    if i < Ns  
        dx = dipc_dynamics( xs , us ); 
        xs = Ts*dx + xs;     
    end

end

disp('Simulação Completa')

x=x';
y=y';
u=u';
r=r';
t=t';
E=E';

end