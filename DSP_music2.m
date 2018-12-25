clear all;
clc;

[y, fs] = audioread('3_IMYours.wav');
n_underSample = 5;
y_r = y(:,1);

start_time = 30;
end_time = 35;

start_sample = floor(start_time*fs+1);
end_sample = floor(end_time*fs+1);
underSample_t = floor(start_sample:n_underSample:end_sample);

real_t = 0:n_underSample*(1/fs):end_time-start_time;
underSample_yr = y_r(underSample_t);

plot(real_t, underSample_yr)
% sound(underSample_yr, fs/n_underSample)

Nyquist_rate = 5;

t = real_t;

ts = t(2) - t(1);
c_t = t(1) : ts / Nyquist_rate : t(length(t));
nts = (0:length(underSample_yr)-1)*ts;

% perfectConv=0;
% ConvW=100;
% Conv_x = [];
% for i = 1:length(c_t)
%     if perfectConv == 1
%         Conv_x = [Conv_x; sum(underSample_yr' .* sinc((c_t(i)-nts)/ts))];
%     else
%         [Y, midX]=min(abs(c_t(i) - nts));
%         conv_id=max(midX-floor(ConvW/2),1):min(midX+floor(ConvW/2),length(underSample_yr));    
%         Conv_x = [Conv_x; sum(underSample_yr(conv_id)' .* sinc((c_t(i)-nts(conv_id))/ts))] ;
%     end
% end

Zerohold_x = zeros(1,length(c_t));
for i = 1:length(t)-1
    Zerohold_x(i*Nyquist_rate-(Nyquist_rate-1):i*Nyquist_rate) = underSample_yr(i);
end

Onehold_x = zeros(1, length(c_t));
for i = 1:length(t)-1
    recov_y = linspace(underSample_yr(i), underSample_yr(i+1),  Nyquist_rate+1);
    Onehold_x(i*Nyquist_rate-(Nyquist_rate-1):i*Nyquist_rate) = recov_y(1:length(recov_y)-1);
end
    
% figure(1)
% plot(t, underSample_yr)
% figure(2)
% plot(c_t, Conv_x)
figure(3)
plot(c_t, Zerohold_x)
figure(4)
plot(c_t, Onehold_x)