clear all;
clc;

[y, fs] = audioread('3_IMYours.wav');
n = 5;
y_r = y(:,1);

t_n = 1:length(y_r);
t = t_n/fs;

start_time = 30;
end_time = 40;

T_t = 1:n:(end_time-start_time)*fs;
Y_t = start_time*fs:n:end_time*fs-1;
cut_t = t(T_t);
cut_yr = y_r(Y_t);

plot(cut_t, cut_yr)
sound(cut_yr,fs/n)