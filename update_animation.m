function update_animation(t,y,CFG,plots,dims)
    
    x = y(1);
    th1 = y(2);
    th2 = y(3);

    %Dimensions
    car_widht = dims.car_widht;
    car_height = dims.car_height;
    wheel_radius = dims.wheel_radius;
    mass_radius = dims.mass_radius;
    l1 = CFG(4);
    l2 = CFG(5);

    %Positions
    y_car = wheel_radius/2 + car_height/2;
    w1x = x - .9*car_widht/2;
    w1y = 0;
    w2x = x + .9*car_widht/2;
    w2y = 0;

    p1x = x + l1*sin(th1);
    p1y = y_car + l1*cos(th1);
    p2x = x + l1*sin(th1) + l2*sin(th2);
    p2y = y_car + l1*cos(th1) + l2*cos(th2);

    set(plots.tt,'String',['time [s] = ' num2str(t, '%3.2f')]);
    set(plots.rec1,'Position', [x-car_widht/2, car_height/2, car_widht, car_height]);
    set(plots.rec2,'Position', [w1x,w1y,wheel_radius,wheel_radius]);
    set(plots.rec3,'Position', [w2x,w2y,wheel_radius,wheel_radius]);

    set(plots.p2,'xdata',[x p1x],'ydata',[y_car p1y]);
    set(plots.rec4,'Position',[p1x-mass_radius/2,p1y-mass_radius/2,mass_radius,mass_radius]);

    set(plots.p3,'xdata',[p1x p2x],'ydata',[p1y p2y]);
    set(plots.rec5,'Position',[p2x-mass_radius/2,p2y-mass_radius/2,mass_radius,mass_radius]);

    pause(0.001);
end