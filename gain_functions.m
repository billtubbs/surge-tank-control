% Investigating possible gain functions for gain scheduling of
% surge tank control systems.

% Assume range of CV is 0-100:
y = linspace(0, 100, 101);

% Quadratic
a = -0.1;
b = -0.00076;
K1 = a + b .* (y - 50).^2;

figure(1);clf
plot(y, K1)
grid on
text(30, -1.4, "$K = a + b * (y - 50)^2$", 'Interpreter', 'latex')
p = get(gcf, 'Position');
set(gcf, 'Position', [p(1:2) 420 315]);

% Exponential
a = -0.1;
b = -4.9;
c = 5;
K2 = a + b .* (exp(-y ./ c) + exp((y - 100) ./ c));

figure(2);clf
plot(y, K2)
grid on
text(30, -1.4, "$K = a + b * (\exp{\frac{-y}{c}} + \exp{\frac{y - 100}{c}})$", 'Interpreter', 'latex')
p = get(gcf, 'Position');
set(gcf, 'Position', [p(1:2) 420 315]);