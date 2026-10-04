data = readtable('theta_beta_M.csv');

M1 = unique(data.M1);

n = numel(M1);
Max = zeros(n,2);
Sonic = zeros(n,2);
colors = [linspace(1,0,n)', zeros(n,1), zeros(n,1)];

figure; hold on;
for i = 1:n
    idx = data.M1 == M1(i);
    beta_i  = data.Beta(idx);
    theta_i = data.Theta(idx);
    M2_i    = data.M2(idx);
    [maxTheta, maxIdx] = max(theta_i);
    Max(i, :) = [maxTheta, beta_i(maxIdx)];
    if numel(beta_i) < 2
        Sonic(i,:) = [0, 90];
        continue
    end
    sonicTheta = interp1(M2_i, theta_i, 1, 'linear');
    sonicBeta  = interp1(M2_i, beta_i, 1, 'linear');
    Sonic(i, :) = [sonicTheta, sonicBeta];
    plot(data.Theta(idx), data.Beta(idx), 'Color', colors(i,:), 'LineWidth', 1.5, 'DisplayName', sprintf('M = %.1f', M1(i)));
end
plot(Max(:,1), Max(:,2), 'b--', 'LineWidth', 2, 'DisplayName', '\theta_{max}');
plot(Sonic(:,1), Sonic(:,2), 'g-.', 'LineWidth', 2, 'DisplayName', 'M_2 = 1 (sonic)');
xlabel('\theta (deg)');
ylabel('\beta (deg)');
title('\theta-\beta-M Diagram');
legend('show', 'Location', 'eastoutside');
grid on;
hold off;