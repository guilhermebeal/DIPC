function [ u , E ] = control( t , y , r , x )

    global a1 a2 a3 a4 a5 a6 a7 a8 sat_swing Ks Kp Kv key K
    persistent flag_swing
    if t == 0
        flag_swing = true;
    end
    % Chaveamento
    if flag_swing && (cos(x(2)) > cos(key)) && (cos(x(3)) > cos(key))
        flag_swing = false;
    end

    if ~flag_swing && ( (cos(x(2)) <= 0) || (cos(x(3)) <= 0) )
         flag_swing = true;
    end

    Kz = [ Kp , Kv ];
    z = [ x(1); x(4) ];
    teta = [ x(2) ;x(3) ];
    dteta = [ x(5) ;x(6) ];
    M = [ a4                        a5*cos(teta(1)-teta(2))
          a5*cos(teta(1)-teta(2))   a6                      ]; 
    E = (1/2)*dteta'*M*dteta+ a7*(cos(teta(1))+1) + a8*(cos(teta(2))+1);
    Eo = 2*a7+2*a8;
    delta_E = E-Eo;

    if flag_swing
        A = a2*dteta(1)*cos(teta(1))+a3*dteta(2)*cos(teta(2));
        u = sat_swing*sat_fn(Ks*delta_E*A) - Kz*z;
    else
    x(2) = wrapToPi(x(2));
    x(3) = wrapToPi(x(3));
    u_barra = 0;
    x_barra = [ r ; 0 ; 0 ; 0 ; 0 ; 0 ];
    delta_x = x - x_barra;
    u = -K*delta_x - u_barra; 

    end
end