function k = curvature(x, y, D1, D2)

k = ((x * D1) .* (y * D2) - (y * D1) .* (x * D2)) ./ ...
    ((x * D1).^2 + (y * D1).^2).^(3/2);
