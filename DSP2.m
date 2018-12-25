clear all
clc

f = 10^7;
ts = 1 / (2*10^9);
t = 0 : ts : 3e-6;
y = exp(-0.1*f*t).*cos(2*pi*f*t.*exp(-0.1*f*t));

Q = 4;
q = 2^Q;

levels = min(y) : (max(y) - min(y))/(q-1) : max(y);

%2진화
for i = 1:length(t)
    [d,I] = min(abs(y(i) - levels));
    bitstream((i - 1) * Q + 1 : i * Q) = de2bi(I - 1, Q);
end

everElist = [];
for Pb = 0:0.001:0.1
    %에러화
    errbitstream = bitstream;
    for i = 1:length(bitstream)
        if rand < Pb
            errbitstream(i) = - bitstream(i) + 1;
        end
    end

    %십진화
    des = [];
    for i = 1:length(errbitstream)/Q
        k = errbitstream(i * Q - (Q-1) : i * Q);
        m = bi2de(k);
        des = [des, m + 1];
    end
    
    averE = sum(abs(y - levels(des)))/length(t);
    everElist = [everElist, averE];
end

Pb = 0:0.01:0.;
plot(Pb, everElist);

