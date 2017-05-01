function k = curvature(x_road, y_road, T_road, d, D1, D2)

[x, y] = position(x_road, y_road, T_road, d);

k = ((x * D1) .* (y * D2) - (y * D1) .* (x * D2)) ./ ...
    ((x * D1).^2 + (y * D1).^2).^(3/2);
