clear; clc; format long

wsp     = [-1, 0, 3, 0, -2, 0, 1];
tol     = 1e-12;
tol2    = 1e-2;
x0_list    = [-3,-2, -1, -0.5, 0, 0.5, 1, 2, 3];
maxIter_list = [1, 2, 3, 4, 5, 10,15,20,25,30,40,50,];

N0 = numel(x0_list);
NM = numel(maxIter_list);

wyniki = strings(N0, NM);
iter   = zeros(N0, NM);

for i = 1:N0
    x0 = x0_list(i);
    for j = 1:NM
        maxIt = maxIter_list(j);
        [xStat, ~, ~, cls, xHist] = ...
            znajdzPunktStacjonarny(wsp, x0, tol, maxIt);
        wyniki(i,j) = cls;
        iter(i,j)   = numel(xHist)-1;
    end
end

fprintf('\n         maxIter →\n');
fprintf(' x0 \\ maxIt');
for j = 1:NM, fprintf('   %3d', maxIter_list(j)); end
fprintf('\n------------------------------------------------\n');
for i = 1:N0
    fprintf('%5.2f     ', x0_list(i));
    for j = 1:NM
        fprintf('%12s', wyniki(i,j));
    end
    fprintf('\n');
end

[X0, MI] = ndgrid(x0_list, maxIter_list);

Cnum = zeros(size(X0));
for i = 1:N0
  for j = 1:NM
    switch wyniki(i,j)
      case "minimum"
        Cnum(i,j) = 1;
      case "maksimum"
        Cnum(i,j) = 2;
      case "brak rozstrzygnięcia"
        Cnum(i,j) = 3;
    end
  end
end

figure;
scatter( MI(:), X0(:), 100, Cnum(:), 's', 'filled' );
colormap([ 0 1 0;
          .7 .7 .7;
          1 0 0]);
c = colorbar;
c.Ticks      = [1,2,3];
c.TickLabels = {'minimum','maksimum','brak'};
xlabel('maxIter','FontWeight','bold');
ylabel('x_0','FontWeight','bold');
title('Klasyfikacja Newtona – scatter vs x_0 i maxIter','FontSize',14);
grid on;






