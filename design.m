%% Design

%% Constantes Construtivas
global g l1 l2 m0 m1 m2 b0 b1 b2 sat
g   = 9.81;   % gravidade
l1  = 2.5;    % comprimento do pêndulo 1
l2  = 2.5;    % comprimento do pêndulo 1
m0  = 10;     % massa do carro
m1  = 1;    % massa do pêndulo 1
m2  = 1;    % massa do pêndulo 2 
b0  = 0.1;   % atrito do carro
b1  = 0.1;   % atrito do pêndulo 1
b2  = 0.1;   % atrito do pêndulo 2

sat = 200;	% saturação de força de entrada

%% Parametros de Controle de Swingup
global sat_swing Ks Kp Kv key

sat_swing = 100;
Ks = 0.2;
Kp = 10;
Kv = 10;
key = 30*(pi/180);

%% Parametros de Controle de Estabilidade
global K a1 a2 a3 a4 a5 a6 a7 a8

syms t1 t2 dt1 dt2 z dz u

t = [ t1
	  t2 ];
dt = [ dt1
	   dt2 ];

a1 = m0+m1+m2;
a2 = l1*(m1+m2);
a3 = m2*l2;
a4 = (l1^2)*(m1+m2);
a5 = l1*l2*m2;
a6 = l2^2*m2;
a7 = g*(m1+m2)*l1;
a8 = g*l2*m2;

M = [ a1              a2*cos(t(1))        a3*cos(t(2))
      a2*cos(t(1))    a4                  a5*cos(t(1)-t(2))
      a3*cos(t(2))    a5*cos(t(1)-t(2))   a6                ];

C = [ b0  -a2*dt(1)*sin(t(1))       -a3*dt(2)*sin(t(2))
      0    b1                       a5*dt(2)*sin(t(1)-t(2))
      0   -a5*dt(1)*sin(t(1)-t(2))   b2                      ];
  
  
G = [ 0
      -a7*sin(t(1)) 
      -a8*sin(t(2))  ];

F = [ u
      0
      0 ]; 

q = [ z
	  t ];
dq = [ dz
	   dt ];

ddq = (M)\(F-C*dq-G);

x = [ z
	  t(1)
	  t(2)
	  dz
	  dt(1)
	  dt(2) ];

f = [ dq(1)
	  dq(2)
	  dq(3)
	  ddq(1)
	  ddq(2)
	  ddq(3) ];

A = double(subs(jacobian(f,x),[x;u],zeros(7,1)));
B = double(subs(jacobian(f,u),[x;u],zeros(7,1)));

K = place(A,B,-1.6*[1.01 1.02 1.03 1.04 1.05 1.06]);

clear t1 t2 dt1 dt2 z dz u