clear 

NX = 3;
R = 1;
theta = linspace(0, pi/2, NX);

w_road = 0.2; % width of road
s_road = R * theta;
x_road = R * sin(theta);
x_road_left = (R + w_road/2)*sin(theta);
x_road_right = (R - w_road/2)*sin(theta);
y_road = R * cos(theta);
y_road_left = (R + w_road/2)*cos(theta);
y_road_right = (R - w_road/2)*cos(theta);

L = calcPolyLagrange(s_road);

D1 = double(subs(diff(L), s_road));
D2 = double(subs(diff(diff(L)), s_road));
S = double(subs(int(L), s_road(end)));

dx_road_ds = x_road * D1;
dy_road_ds = y_road * D1;
magnitude = sqrt(dx_road_ds.^2 + dy_road_ds.^2);
T_road = [
    dx_road_ds./magnitude
    dy_road_ds./magnitude
    ];
 
% Curvature
k_road = ((x_road * D1) .* (y_road * D2) - (y_road * D1) .* (x_road * D2)) ./ ...
    ((x_road * D1).^2 + (y_road * D1).^2).^(3/2);

objFun = @(x) abs(curvature(x_road, y_road, T_road, x, D1, D2)) * S;
x0 = zeros(1, NX); % Initial guess is the car at center of road

[x_car, y_car] = position(x_road, y_road, T_road, x0);
k_car = curvature(x_road, y_road, T_road, x0, D1, D2);

A = [];
b = [];
Aeq = [];
beq = [];
lb = -w_road/2*ones(1, NX);
ub = w_road/2*ones(1, NX);
nonlcon = [];

options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point');

xOpt = fmincon(objFun, x0, A, b, Aeq, beq, lb, ub, nonlcon, options);

[x_car_opt, y_car_opt] = position(x_road, y_road, T_road, xOpt);
k_car_opt = curvature(x_road, y_road, T_road, xOpt, D1, D2);

figure(1)
plot(x_road, y_road, 'k--', ...
     x_road_left, y_road_left, 'k', ...
     x_road_right, y_road_right, 'k', ...
     x_car, y_car, x_car_opt, y_car_opt)
axis square
legend({'Road Center','Road Left','Road Right','Car Initial Guess','Car Optimized'})

figure(2)
plot(s_road, k_road, s_road, k_car, s_road, k_car_opt)
xlabel('sRoad (m)')
ylabel('c (1/m)')
legend({'Road','Car Initial Guess','Car Optimized'})