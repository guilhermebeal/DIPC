clc
close all
clear all

run design

%% Config da Simulacao
tt = 50; % s
T = 1e-3;
Ts = 1e-4;
pos0 = 0;
ang1 = 180*(pi/180);
ang2 = 180*(pi/180);
x0 = [ pos0 ; ang1 ; ang2 ; 0 ; 0 ; 0];

%% Ensaio do Sistema

[t,x,y,u,r,E] = run_sim( tt , T , Ts , x0 );

full_data = [t x y u r E];
run save_data

% t -> vetor de tempo
% x -> estados do sistema
% y -> sinal dos sensores do sistema
% u -> sinal de controle do sistema
% r -> sinal de referencia do controle
% E -> energia meca¢nica do sistema

%% Animacao
Ta = 20*T; % animation sampling period

CFG = [m0 m1 m2 l1 l2];

[plots,dims] = init_animation(1,t(1),x(1,:),CFG);

disp('Press any key to start the animation')
while 1
    press_key = waitforbuttonpress;
    if press_key == 1
        break
    end
end

for k=1:length(t)
    if mod(t(k),Ta)==0
        update_animation(t(k),x(k,:),CFG,plots,dims);
    end
end
disp('Animation complete')

%% Plotagem

figure('units','normalized','outerposition',[0 0 1 1])
subplot(4,1,1)
plot(t,r(:,1),'r--')
hold on
plot(t,x(:,1),'b')
xlabel('t (s)')
ylabel('Posição Carro (m)')
grid on
subplot(4,1,2)
plot(t,wrapTo180((180/pi)*x(:,2)),'b')
grid on
ylabel('Ângulo Pêndulo 1 (°)')
subplot(4,1,3)
plot(t,wrapTo180((180/pi)*x(:,3)),'b')
grid on
ylabel('Ângulo Pêndulo 2 (°)')
subplot(4,1,4)
plot(t,u,'b')
grid on
ylabel('Sinal de Controle (N)')

Ed =2*(m1+m2)*g*l1+2*m2*g*l2;
figure('units','normalized','outerposition',[0 0 1 1])
plot(t,0*t+Ed,'r--')
hold on
plot(t,E,'b')
grid on
ylabel('Energia Total (J)')
xlabel('t (s)')