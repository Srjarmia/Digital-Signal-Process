clear all;
clc;

f1 = 10e6;
f2 = 12e6;
f3 = 14e6;

fs = 50e6;
ts = 1/fs;

numpts = 100;
t_start = 0;
t_end = (numpts-1)*ts;

t = t_start:ts:t_end;
Origin_x = cos(2*pi*f1*t) + cos(2*pi*f2*t) + cos(2*pi*f3*t);

Nyquist_rate = 5;

c_t = t(1): ts / Nyquist_rate :t(length(t));
nts = (0:length(Origin_x)-1)*ts;

perfectConv=0;
ConvW=5;
Conv_x = [];
for i = 1:length(c_t)
    if perfectConv == 1
        Conv_x = [Conv_x; sum((Origin_x .* sinc((c_t(i)-nts)/ts)))];
    else
        [Y, midX]=min(abs(c_t(i) - nts));
        conv_id=max(midX-floor(ConvW/2),1):min(midX+floor(ConvW/2),length(Origin_x));
        Conv_x = [Conv_x; sum(Origin_x(conv_id) .* sinc((c_t(i)-nts(conv_id))/ts))] ;
    end
end

Zerohold_x = zeros(1,length(c_t));
for i = 1:length(t)-1
    Zerohold_x(i*Nyquist_rate-(Nyquist_rate-1):i*Nyquist_rate) = Origin_x(i);
end

Onehold_x = zeros(1, length(c_t));
for i = 1:length(t)-1
    Onehold_x(i*Nyquist_rate-(Nyquist_rate-1):i*Nyquist_rate) = linspace(Origin_x(i), Origin_x(i+1),  Nyquist_rate);
ende

figure(1)
plot(t, Origin_x,'o')
figure(2)
plot(c_t, Conv_x)
figure(3)
plot(c_t, Zerohold_x)
figure(4)
plot(c_t, Onehold_x,'o')