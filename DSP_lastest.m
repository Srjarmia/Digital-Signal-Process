clear all;
clc;

[y, fs] = audioread('Roly_Poly.wav');
y_r = y(:,2);
y_l = y(:,1);

t_Start = 0;
t_End = 176;
Volume = 1;     % ������ ������ r(r<=1)��� ����
play_speed = 1;  % ������ r(0<r)�� ������� ���
reverse_play = 1; % 0 �̸� ������ ��� 1 �̸� ������ ���

start_cut = floor(t_Start*fs+1);
end_cut = floor(t_End*fs+1);
t_cut = start_cut:end_cut;

y_cut_r = y_r(t_cut)*Volume; % ���� ���� ����Ʈ
y_cut_l = y_l(t_cut)*Volume; % ���� ���� ����Ʈ

if reverse_play ~= 0         % ����� ���� ���� ����Ʈ
    t_reverse = length(y_cut_r):-1:1;
    y_cut_r = y_cut_r(t_reverse);
    y_cut_l = y_cut_l(t_reverse);
end

y_cut = [y_cut_r, y_cut_l];
sound(y_cut, fs*play_speed)   % �ӵ� ���� ����Ʈ