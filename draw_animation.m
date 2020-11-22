function draw_animation(fig,y,CFG)
    figure(fig);

    x = y(1);
    th1 = y(2);
    th2 = y(3);

    %Dimensions
    car_widht = 2;
    car_height = 1;
    wheel_radius = .2;
    mass_radius = .3;
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

    %Ploting
    plot([-20 20], [0 0], 'k', 'LineWidth', 2)
    hold on
    rectangle('Position', [x-car_widht/2, car_height/2, car_widht, car_height], 'Curvature', .1, 'FaceColor', [1 0.1 1])
    rectangle('Position', [w1x,w1y,wheel_radius,wheel_radius], 'Curvature', 1, 'FaceColor', [0 0 0])
    rectangle('Position', [w2x,w2y,wheel_radius,wheel_radius], 'Curvature', 1, 'FaceColor', [0 0 0])

    plot([x p1x],[y_car p1y],'k','LineWidth',2)
    rectangle('Position',[p1x-mass_radius/2,p1y-mass_radius/2,mass_radius,mass_radius],'Curvature',1,'FaceColor',[.1 0.1 1])

    plot([p1x p2x],[p1y p2y],'k','LineWidth',2)
    rectangle('Position',[p2x-mass_radius/2,p2y-mass_radius/2,mass_radius,mass_radius],'Curvature',1,'FaceColor',[.1 0.1 1])

    xlim([-20 20]);
    y_factor = 1.2*(l1+l2); 
    ylim([-y_factor y_factor]);
    
    % box off
    drawnow
    hold off
end