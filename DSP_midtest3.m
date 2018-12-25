N = 12;
highestPow = floor(log2(N));
bin = zeros(1, highestPow+1);

rem = N;
while rem > 0
    power = floor(log2(rem));
    bin((highestPow+1)-power) = 1;
    rem = rem - 2^power;
end
bin