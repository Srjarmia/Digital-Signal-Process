clear all;
clc;

[y, fs] = audioread('Roly_Poly.wav');
y_r = y(:,2);
y_l = y(:,1);

t_Start = 0;
t_End = 176;
Volume = 1;     % 음악의 볼륨을 r(r<=1)배로 감소
play_speed = 1;  % 음악을 r(0<r)배 빠르기로 재생
reverse_play = 1; % 0 이면 정방향 재생 1 이면 역방향 재생

start_cut = floor(t_Start*fs+1);
end_cut = floor(t_End*fs+1);
t_cut = start_cut:end_cut;

y_cut_r = y_r(t_cut)*Volume; % 볼륨 조절 포인트
y_cut_l = y_l(t_cut)*Volume; % 볼륨 조절 포인트

if reverse_play ~= 0         % 역재생 여부 선택 포인트
    t_reverse = length(y_cut_r):-1:1;
    y_cut_r = y_cut_r(t_reverse);
    y_cut_l = y_cut_l(t_reverse);
end

y_cut = [y_cut_r, y_cut_l];
sound(y_cut, fs*play_speed)   % 속도 조절 포인트