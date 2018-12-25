clear all
clc

load data.mat
ql = length(Qlevel);
qb = length(QBitStrm);

Q = log2(ql);
fs = 48*10^3;
ts = 1 / fs;
t = ts : ts : ts*(qb/Q);

levels = Qlevel;

bitstream = QBitStrm;

des = [];
for i = 1:length(bitstream)/Q
    k = bitstream(i * Q - (Q-1) : i * Q);
    m = bi2de(k);
    des = [des, m + 1];
end
    
plot(t, levels(des));