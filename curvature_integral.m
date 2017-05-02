function f = curvature_integral(x, xr, yr, tx, ty, D1, D2, S)

[xci, yci] = position(xr, yr, tx, ty, x);

f = abs(curvature(xci, yci, D1, D2)) * S;