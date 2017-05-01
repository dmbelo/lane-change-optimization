function [x, y] = position(x_road, y_road, T_road, d)

% [x, y] = position(x_road, y_road, T_road, d)

x = x_road - T_road(2,:).*d;
y = y_road + T_road(1,:).*d;