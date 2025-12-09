clear; clc; format long

wsp     = [1, 0, 0, 0];
tol     = 1e-12;
tol2    = 1e-2;
x0_list    = [-3,-2,0.5, 0, 0.5, 2,3];
maxIter_list = [1,3,5,10,20,50,100];

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
    iter(i,j)   = length(xHist)-1;
  end
end

fprintf('       ');
for j=1:NM, fprintf('  mI=%2d', maxIter_list(j)); end
fprintf('\n');

for i=1:N0
  fprintf('x0=%3.1f ', x0_list(i));
  for j=1:NM
    fprintf('   %-10s', wyniki(i,j));
  end
  fprintf('\n');
end

figure;
imagesc(1:NM, 1:N0, double(categorical(wyniki)));
colormap([0.4 0.7 1 ; 1 0.6 0; 0.7 0.7 0.7]); 
colorbar('Ticks',[1,2,3], 'TickLabels',{'maksimum','minimum','brak'});
set(gca,'XTick',1:NM,'XTickLabel',maxIter_list, ...
        'YTick',1:N0,'YTickLabel',x0_list);
xlabel('maxIter'); ylabel('x_0');
title('Klasyfikacja vs x_0 i maxIter');
