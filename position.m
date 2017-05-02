function [x, y] = position(xr, yr, tx, ty, dy)

x = xr - tx.*dy;
y = yr + ty.*dy;