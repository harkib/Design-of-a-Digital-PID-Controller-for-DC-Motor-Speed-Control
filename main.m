%% MSE 481 - Project 2
close all;
clear;

%% Part 1: Creating a sampled-data model of the plant
% Part 1a: obtain continuous Laplace transform for the DC motor as a symbolic model

J = 0.01; % kg.m^2
b = 0.1; % N.m.s
K = 0.01; % V/rad.sec
R = 1; % ohm 
L = 0.5; % H
T = .05; % s

numerator = K;
denominator = [J*L, J*R+b*L, b*R + K^2];
sysc = tf(numerator ,denominator );

% Part 1b: Convert the obtained Laplace transform to the discrete z-domain
sysd = c2d(sysc,T,'zoh');

%% Part 2: Design of a digital PID Controller
% Part 2a: Obtain the closed-loop response of the system
cl_sysd = feedback(sysd,1);

% Part 2a: Plot the discrete step response of the closed-loop system
X = linspace(0,10,10/T + 1);
X = transpose(X);
Y = step(cl_sysd,10);

figure
stairs(X,Y)
title('Discrete step response of the closed-loop system - No controller')
xlabel('Time (s)') 
ylabel('Rotational speed (rad/s)') 

% Part 2a: Analyze the performance of the response of the system in terms of steady-state error and transient response
step_info = stepinfo(cl_sysd);
disp('Discrete step response of the closed-loop system - No controller')
disp(['Steady State Error: ',num2str(1 - step_info.SettlingMax)])
disp(['Transient Response: ',num2str(step_info.RiseTime)])

% Part 2b: Convert the Laplace PID controller to z-domain PID controller
Kp = 100;
Ki = 200;
Kd = 10;

numerator = [Kd,Kp,Ki];
denominator = [1,0];
PIDc = tf(numerator ,denominator);
PIDd = c2d(PIDc,T,'Tustin');

% Part 2b: Plot the response of Closed loop system
cl_PIDd = feedback(sysd*PIDd,1);
X = linspace(0,10,10/T + 1);
X = transpose(X);
Y = step(cl_PIDd,10);

figure
stairs(X,Y)
title('Discrete step response of the closed-loop system')
xlabel('Time (s)') 
ylabel('Rotational speed (rad/s)')

% Part 2b: Is there any value for Ts showing that the system is stable?
Ts = [0.01, 0.008, 0.005, 0.002, 0.001];

for T = Ts
    
    sysd = c2d(sysc,T,'zoh');
    PIDd = c2d(PIDc,T,'Tustin');
    cl_PIDd = feedback(sysd*PIDd,1);
    X = linspace(0,10,10/T + 1);
    X = transpose(X);
    Y = step(cl_PIDd,10);

    figure
    stairs(X,Y)
    title(append('Discrete step response of the closed-loop system T = ', num2str(T),'s'))
    xlabel('Time (s)') 
    ylabel('Rotational speed (rad/s)')
end

%% Part 3: Stability analysis of a Digital Controller
Ts = [.05, 0.01, 0.008, 0.005, 0.002, 0.001];

for T = Ts
    
    sysd = c2d(sysc,T,'zoh');
    PIDd = c2d(PIDc,T,'Tustin');
    cl_PIDd = feedback(sysd*PIDd,1);

    figure
    rlocus(cl_PIDd)
    title(append('Root Locus of the closed-loop system T = ', num2str(T),'s'))
end


