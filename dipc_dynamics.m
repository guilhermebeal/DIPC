function [ dx ] = dipc_dynamics( x , u )

dz = x(4);

t = [ x(2) 
      x(3) ];

dt = [ x(5) 
     x(6) ];

global g m0 m1 m2 l1 l2 b0 b1 b2
global a1 a2 a3 a4 a5 a6 a7 a8

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

dq = [ dz
     dt ];

ddq = M\(F-C*dq-G);

dx = [ dq(1)
    dq(2)
    dq(3)
    ddq(1)
    ddq(2)
    ddq(3) ];

end