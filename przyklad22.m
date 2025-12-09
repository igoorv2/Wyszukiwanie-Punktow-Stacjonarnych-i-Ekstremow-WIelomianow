clear; clc; format long

wsp       = [1, 0, 2, 0, 1];
tol       = 1e-12;
maxIter   = 100;
x0_list   = [-10, -5, -3, -2, -1, 0, 1, 2, 3, 5, 10];

N0 = numel(x0_list);
iteracje = zeros(1, N0);

for i = 1:N0
  x0 = x0_list(i);
  [~, ~, ~, ~, xHist] = znajdzPunktStacjonarny(wsp, x0, tol, maxIter);
  iteracje(i) = numel(xHist) - 1;
end

figure('Units','normalized','Position',[0.3 0.4 0.5 0.4]);
plot(x0_list, iteracje, 's-', 'LineWidth',2, 'MarkerSize',8, ...
     'MarkerFaceColor',[0.85 0.33 0.10], 'Color',[0.85 0.33 0.10]);
grid on;

xlabel('punkt startowy x_0','FontSize',12,'FontWeight','bold');
ylabel('liczba iteracji Newtona','FontSize',12,'FontWeight','bold');
title({'Przykład 2: liczba kroków Newtona', ...
       'dla p(x)=x^4 + 2x^2 +1 w zależności od x_0'}, ...
       'FontSize',14,'FontWeight','bold');
