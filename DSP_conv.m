x = [1 2 0 -1 0 3];
h = [1 -1 1];

conv(x,h)

x_n = length(x);
h_n = length(h);
y_n = x_n + h_n - 1;

y1 = zeros(1, y_n);
y2 = zeros(1, y_n);
y3 = zeros(1, y_n);

for i = 1:x_n
    for j = 1:h_n
        y1(i + j - 1) = y1(i + j - 1) + x(i) * h(j);
    end
end

y1

ytemp = zeros( x_n, x_n + h_n -1);
for i = 1:x_n
    ytemp(i, i : i+h_n-1) = x(i)*h;
end
y2 = sum(ytemp);

y2

for n = 0:y_n
    for i = 0:n
        if (i > x_n-1) || (n-i > h_n-1)
            continue
        else
            y3(n+1) = y3(n+1) + x(i+1) * h(n-i+1);
        end
    end
end

y3
