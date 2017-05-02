% create_road

clear
R = 1;
n = 3;
theta = linspace(0, pi/2, n);
s = R * theta;
x = R * sin(theta);
y = R * cos(theta);

L = calcPolyLagrange(s);
D1 = double(subs(diff(L), s));
D2 = double(subs(diff(diff(L)), s));

dx_road_ds = x * D1;
dy_road_ds = y * D1;
magnitude = sqrt(dx_road_ds.^2 + dy_road_ds.^2);
T = [
    dx_road_ds./magnitude
    dy_road_ds./magnitude
    ];

k = ((x * D1) .* (y * D2) - (y * D1) .* (x * D2)) ./ ...
    ((x * D1).^2 + (y * D1).^2).^(3/2);

np = 100;
theta_p = linspace(0, pi/2, np);
sp = R * theta_p;
xp = R * sin(theta_p);
yp = R * cos(theta_p);

F = double(subs(L, sp));

dx_road_ds * F;
Tp = [
    dx_road_ds * F ./ (magnitude * F)
    dy_road_ds * F ./ (magnitude * F)
    ];

kp = k * F;

figure(1)
plot(x, y, 'o', xp, yp)
axis square

figure(2)
plot(s, k, sp, kp)

M = [sp' xp', yp', Tp(2,:)' Tp(1,:)' kp'];
csvwrite('quarter_circle.csv', M)
