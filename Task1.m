%% MSE 481 - Project 2
%% Part 1a

J = 0.01; % kg.m^2
b = 0.1; % N.m.s
K = 0.01; % V/rad.sec
R = 1; % ohm 
L = 0.5; % H

numerator = K;
denominator = [J*L, J*R+b*L, b*R + K^2];
sys = tf(numerator ,denominator );
