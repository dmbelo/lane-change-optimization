% clear 

p = randn(1,4)*10+randn*5;
ps = polyint(p);
pd = polyder(p);
x = linspace(0, 1, 500);
y = polyval(p, x);
dydx = polyval(pd, x);
sydx = polyval(ps, x);

xi = linspace(0, 1, 10);
yi = polyval(p, xi);
l = calcPolyLagrange(xi);

F = double(subs(l, x));
D = double(subs(diff(l), xi));
S = double(subs(int(l), xi));

dsdx = sqrt(1 + dydx.^2);
s = cumtrapz(x, dsdx);
dsdx_li = sqrt(1 + (yi * D).^2);
s_li = dsdx_li * S;


err = (s(end) - s_li(end))/s(end);

subplot(221)
plot(x, y, x, yi * F, xi, yi, 'o')
xlabel('x')
ylabel('y')
legend('Exact','Lagrange Approx','Collocation Points')

subplot(222)
plot(x, dydx, xi, yi * D, 'o')
legend('Exact','Lagrange Approx')
xlabel('x')
ylabel('dydx')

subplot(223)
plot(x, dsdx, x, dsdx_li * F, xi, dsdx_li, 'o')
xlabel('x')
ylabel('dsdx')
legend('Exact','Lagrange Approximation','Collocation Points')

subplot(224)
plot(x, s, xi, s_li, 'o')
text(0.02, 0.9,['Error: ' num2str(err*100, '%2.4f'), '%'], 'Units', 'normalized')
legend('Exact','Lagrange Approx')
xlabel('x')
ylabel('s')
