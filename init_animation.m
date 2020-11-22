function [plots,dims] = init_animation(fig,t,y,CFG)
    figure(fig)
    %set(gcf,'Position',[34 164 1013 480]);
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);

    x = y(1);
    th1 = y(2);
    th2 = y(3);

    %Dimensions
    car_widht = 2;
    car_height = 0.3;
    wheel_radius = .2;
    mass_radius = .3;
    
    dims.car_widht = car_widht;
    dims.car_height = car_height;
    dims.wheel_radius = wheel_radius;
    dims.mass_radius = mass_radius;
    
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
    plots.p1 = plot([-20 20], [0 0], 'k', 'LineWidth', 2);
    hold on
    plots.rec1 = rectangle('Position', [x-car_widht/2, car_height/2, car_widht, car_height], 'Curvature', .1, 'FaceColor', [1 0.1 1]);
    plots.rec2 = rectangle('Position', [w1x,w1y,wheel_radius,wheel_radius], 'Curvature', 1, 'FaceColor', [0 0 0]);
    plots.rec3 = rectangle('Position', [w2x,w2y,wheel_radius,wheel_radius], 'Curvature', 1, 'FaceColor', [0 0 0]);

    plots.p2 = plot([x p1x],[y_car p1y],'k','LineWidth',2);
    plots.rec4 = rectangle('Position',[p1x-mass_radius/2,p1y-mass_radius/2,mass_radius,mass_radius],'Curvature',1,'FaceColor',[.1 0.1 1]);

    plots.p3 = plot([p1x p2x],[p1y p2y],'k','LineWidth',2);
    plots.rec5 = rectangle('Position',[p2x-mass_radius/2,p2y-mass_radius/2,mass_radius,mass_radius],'Curvature',1,'FaceColor',[.1 0.1 1]);
    
    plots.tt = title(['time [s] = ' num2str(t, '%3.2f')]);
    set(plots.tt,'FontName','Courier New');
    set(plots.tt,'FontSize',16);
    
    axis equal
    
    xlim([-20 20]);
    y_factor = 1.2*(l1+l2); 
    ylim([-y_factor y_factor]);
    
    % box off
    drawnow
    hold off
end