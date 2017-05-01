clear 

p = randn(1,3)*10+randn*5;
ps = polyint(p);
pd = polyder(p);
pd2 = polyder(pd);
x = linspace(0, 1, 500);
y = polyval(p, x);
dydx = polyval(pd, x);
dy2dx2 = polyval(pd2, x);
sydx = polyval(ps, x);

xi = linspace(0, 1, 3);
yi = polyval(p, xi);
l = calcPolyLagrange(xi);

F = double(subs(l, x));
D = double(subs(diff(l), xi));
D2 = double(subs(diff(diff(l)), xi));
S = double(subs(int(l), xi));

% Length
dsdx = sqrt(1 + dydx.^2);
s = cumtrapz(x, dsdx);
dydx_li = yi * D;
dsdx_li = sqrt(1 + dydx_li.^2);
s_li = dsdx_li * S;

s_err = (s(end) - s_li(end))/s(end);

% Curvature
dy2dx2_li = yi * D2;
k = dy2dx2./(1+dydx.^2).^1.5;
k = sqrt(abs(k));
k_li = dy2dx2_li./(1+dydx_li.^2).^1.5;
k_li = sqrt(abs(k_li));
sk = cumtrapz(x, k);
sk_li = k_li * S;

k_err = (sk(end) - sk_li(end))/sk(end);

subplot(321)
plot(x, y, x, yi * F, xi, yi, 'o')
xlabel('x')
ylabel('y')
legend('Exact','Lagrange Approx','Collocation Points')

subplot(322)
plot(x, dydx, xi, dydx_li, 'o')
legend('Exact','Lagrange Approx')
xlabel('x')
ylabel('dydx')

subplot(323)
plot(x, dsdx, x, dsdx_li * F, xi, dsdx_li, 'o')
xlabel('x')
ylabel('dsdx')
legend('Exact','Lagrange Approximation','Collocation Points')

subplot(324)
plot(x, s, xi, s_li, 'o')
text(0.02, 0.9,['Error: ' num2str(s_err*100, '%2.4f'), '%'], 'Units', 'normalized')
legend('Exact','Lagrange Approx')
xlabel('x')
ylabel('s')

subplot(325)
plot(x, k, x, k_li * F, xi, k_li, 'o')
xlabel('x')
ylabel('Curvature')
legend('Exact','Lagrange Approximation','Collocation Points')

subplot(326)
plot(x, sk, xi, sk_li, 'o')
text(0.02, 0.9,['Error: ' num2str(k_err*100, '%2.4f'), '%'], 'Units', 'normalized')
legend('Exact','Lagrange Approx')
xlabel('x')
ylabel('Integral of Curvature')
