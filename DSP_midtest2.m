N = 12;
highestPow = floor(log2(N));
bin = zeros(1, highestPow+1);

rem = N;
while rem > 0
    power = floor(log2((1/rem)*exp(0.6931)));
    bin(power+(highestPow+1)) = 1;
    rem = rem - 2^-power;
end
bin