clear 

% Load Road
road = csvread('quarter_circle.csv');
w = 0.2;
s = road(:,1);
xr = road(:,2);
yr = road(:,3);
tx = road(:,4);
ty = road(:,5);
kr = road(:,6);

% Setup arrays
s0 = s(1);
s1 = s(end);
Ni = 3;
si = linspace(s0, s1, Ni);
xri = interp1(s, xr, si);
yri = interp1(s, yr, si);
txi = interp1(s, tx, si);
tyi = interp1(s, ty, si);
kri = interp1(s, kr, si);

% Lagrangian interpolation setup
L = calcPolyLagrange(si);
F = double(subs(L, s'));
D1 = double(subs(diff(L), si));
D2 = double(subs(diff(diff(L)), si));
S = double(subs(int(L), s1));

% Initial Conditions
x0 = zeros(1, Ni);

% Optimization setup
A = [];
b = [];
Aeq = [];
beq = [];
lb = -w/2*ones(1, Ni);
ub = w/2*ones(1, Ni);
nonlcon = [];
objFun = @(x) curvature_integral(x, xri, yri, txi, tyi, D1, D2, S);

options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point');
xOpt = fmincon(objFun, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);

% Plot
% Road
xrr = xr + tx * w/2;
yrr = yr - ty * w/2;
xrl = xr - tx * w/2;
yrl = yr + ty * w/2;

% Initial condition
[xci0, yci0] = position(xri, yri, txi, tyi, x0);
xc0 = xci0 * F;
yc0 = yci0 * F;
% kci0 = curvature(xci0, yci0, D1, D2);
% Optimization
[xciOpt, yciOpt] = position(xri, yri, txi, tyi, xOpt);
xcOpt = xciOpt * F;
ycOpt = yciOpt * F;
% kciOpt = curvature(xciOpt, yciOpt, D1, D2);

plot(xrl, yrl, 'k', xrr, yrr, 'k', ...
    xc0, yc0, 'k--', xcOpt, ycOpt, 'b-', ...
    xci0, yci0, 'ko', xciOpt, yciOpt, 'b*')
axis square
legend('Road Left', 'Road Right', 'Car Initial', 'Car Optimized')