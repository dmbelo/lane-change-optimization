function l = calcPolyLagrange(xv)

x = sym('x');

for i = 1:length(xv)
    tmp = 1;
    for j = 1:length(xv)
        if i ~= j
            tmp = (x - xv(j))/(xv(i) - xv(j)) * tmp;
        end
    end
    l(i,:) = tmp;
end
