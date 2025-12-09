%% Przykład 2 : p(x) = x^4 + 2x^2 + 1
clear; clc; format long

wsp     = [1, 0, 2, 0, 1];
x0      = 1.0;
tol     = 1e-12;
maxIter = 50;
tol2    = 1e-2;

[x_stat, p1, p2, cls, xHist] = znajdzPunktStacjonarny(wsp, x0, tol, maxIter);

fprintf('\n=== Przykład 2: p(x)=x^4 + 2x^2 + 1 ===\n');
fprintf(' x0           = % .6f\n', x0);
fprintf(' x_stat       = % .12e\n', x_stat);
fprintf(' p''(x_stat)  = % .12e\n', p1);
fprintf(' p''''(x_stat) = % .12e\n', p2);
fprintf(' Klasyfikacja = %s\n', cls);

xx  = linspace(x0-3, x0+3, 600);
yy  = arrayfun(@(z) ocenaHornera(wsp, z),    xx);
dy  = arrayfun(@(z) ocenaHorneraPoch1(wsp, z), xx);
d2y = arrayfun(@(z) ocenaHorneraPoch2(wsp, z), xx);

figure('Units','normalized','Position',[0.05 0.05 0.9 0.8]);

ax1 = axes('Position',[0.07 0.30 0.60 0.65]);
plot(ax1, xx, yy, 'b-', 'LineWidth',2); hold(ax1,'on');
xlabel(ax1,'x','FontSize',12,'FontWeight','bold');
ylabel(ax1,'p(x)','FontSize',12,'FontWeight','bold');
title(ax1,'Newton + Horner: p(x)=x^4+2x^2+1','FontSize',14,'FontWeight','bold');
grid(ax1,'on'); box(ax1,'on');
ylim(ax1,[min(yy), max(yy)]);

plot(ax1, x0, ocenaHornera(wsp,x0), 'ro','MarkerFaceColor','r','MarkerSize',8);
text(ax1, x0+0.1, ocenaHornera(wsp,x0)+0.1, 'x_0','Color','r','FontSize',11);
plot(ax1, x_stat, ocenaHornera(wsp,x_stat), 'ks','MarkerFaceColor','k','MarkerSize',8);
text(ax1, x_stat+0.1, ocenaHornera(wsp,x_stat)+0.1, 'x^*','Color','k','FontSize',11);

t = linspace(x0-3, x0+3, 200);
for k = 1:length(xHist)-1
    xk  = xHist(k);
    yk  = ocenaHornera(wsp, xk);
    d1k = ocenaHorneraPoch1(wsp, xk);
    ytan = yk + d1k*(t - xk);
    plot(ax1, t, ytan, '--','Color',[0.85,0.33,0.10],'LineWidth',1);
    xn = xHist(k+1);
    plot(ax1, xn, 0, 'bo','MarkerFaceColor','b','MarkerSize',6);
end
hold(ax1,'off');

ax2 = axes('Position',[0.70 0.55 0.25 0.35]);
plot(ax2, xx, dy, 'g-','LineWidth',1.6); hold(ax2,'on');
yyaxis(ax2,'right');
plot(ax2, xx, d2y, 'm-','LineWidth',1.6);
hold(ax2,'off');
xlabel(ax2,'x','FontSize',11,'FontWeight','bold');
yyaxis(ax2,'left');  ylabel('p''(x)','Color','g','FontSize',11);
yyaxis(ax2,'right'); ylabel('p''''(x)','Color','m','FontSize',11);
title(ax2,'p'' & p''''','FontSize',12,'FontWeight','bold');
grid(ax2,'on'); box(ax2,'on');

ax3 = axes('Position',[0.70 0.10 0.25 0.35]);
err = abs(xHist - x_stat);
semilogy(0:length(err)-1, err,'-o','LineWidth',1.6,'MarkerSize',8,...
         'MarkerFaceColor',[0.85,0.33,0.10],'Color',[0.85,0.33,0.10]);
grid(ax3,'on');
xlabel(ax3,'iteracja k','FontSize',11,'FontWeight','bold');
ylabel(ax3,'|x_k - x^*|','FontSize',11,'FontWeight','bold');
title(ax3,'Zbieżność Newtona (błąd)','FontSize',12,'FontWeight','bold');
