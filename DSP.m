clear all
clc

Q = 4;
q = 2^Q;

f = 10^7;
ts = 1 / (2*10^9);
t = 0 : ts : 3e-6;
y = exp(-0.1*f*t).*cos(2*pi*f*t.*exp(-0.1*f*t));

plot(t,y*(q/2)+(q/2))
hold on

f = 10^7;
ts = 1 / (2*10^7);
t = 0 : ts : 3e-6;
y = exp(-0.1*f*t).*cos(2*pi*f*t.*exp(-0.1*f*t));

levels = min(y) : (max(y) - min(y))/(q-1) : max(y);

b = 0:(q - 1);
ylab = [];
 for i = 1:length(b)
     lab = dec2bin(b(i),4);
     ylab = [ylab; lab];
 end
 
%2진화
for i = 1:length(t)
    [d,I] = min(abs(y(i) - levels));
    bitstream((i - 1) * Q + 1 : i * Q) = de2bi(I - 1, Q);
end

everElist = [];
for Pb = 0:0.0001:0.5
    %에러화
    for i = 1:length(bitstream)
        if rand < Pb
            bitstream(i) = abs(bitstream(i) - 1);
        end
    end

    %십진화
    des = [];
    for i = 1:length(bitstream)/Q
        k = bitstream(i * Q - (Q-1) : i * Q);
        m = bi2de(k);
        des = [des, m + 1];
    end
    
    averE = sum(abs(y - levels(des)))/length(t);
    everElist = [everElist, averE];
    
    h = plot(t,des,'o');
    grid on
    title('signal encoding and bit error')
    xlabel('time')
    ylabel('Levels')
    count = num2str(Pb);
    error = num2str(averE);
    c1 = text(t(5),(q-2),{'Pb=', count},'FontSize',14);
    c2 = text(t(15),(q-2),{'error=', error},'FontSize',14);
	legend('encoding Signal','Location','southeast')
    set(gca, 'YTickLabel',{ylab},'YTick', b);
    
    pause(0.01);
    if Pb < 1
        delete(h);
        delete(c1);
        delete(c2);
    end
end

figure(2)
Pb = 0:0.0001:0.5;
plot(Pb, everElist);