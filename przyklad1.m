%p(x)=x^3
clear; clc; format long
wsp   = [1, 0, 0, 0];  % p(x) = x^3
x0    = 1.0;           
tol   = 0;
maxIt = 100;

[xStat, p1, p2, cls, xHist] = znajdzPunktStacjonarny(wsp, x0, tol, maxIt);

xx  = linspace(-1.5, 1.5, 600);
yy  = arrayfun(@(z) ocenaHornera(wsp, z),   xx);
dy  = arrayfun(@(z) ocenaHorneraPoch1(wsp, z), xx);
d2y = arrayfun(@(z) ocenaHorneraPoch2(wsp, z), xx);

figure('Units','normalized','Position',[0.05 0.05 0.9 0.8]);

ax1 = axes('Position',[0.07 0.3 0.6 0.65]);
plot(ax1, xx, yy, 'b-', 'LineWidth',2); hold(ax1,'on');
xlabel(ax1,'x','FontSize',12,'FontWeight','bold');
ylabel(ax1,'p(x)=x^3','FontSize',12,'FontWeight','bold');
title(ax1,'Newton + Horner na p(x)=x^3','FontSize',14,'FontWeight','bold');
grid(ax1,'on'); box(ax1,'on');
ylim(ax1,[-1,2]);

plot(ax1, x0, ocenaHornera(wsp,x0), 'ro','MarkerFaceColor','r');
plot(ax1, xStat, ocenaHornera(wsp,xStat), 'ks','MarkerFaceColor','k');
text(ax1, x0+0.05, ocenaHornera(wsp,x0)+0.05, 'x_0','Color','r');
text(ax1, xStat+0.05, ocenaHornera(wsp,xStat)+0.05, 'x^*','Color','k');

t = linspace(-1.5,1.5,200);
for k = 1:length(xHist)-1
    xk  = xHist(k);
    yk  = ocenaHornera(wsp, xk);
    d1k = ocenaHorneraPoch1(wsp, xk);
    ytan = yk + d1k*(t - xk);
    plot(ax1, t, ytan, '--','Color',[0.85,0.33,0.10]);
    xn = xHist(k+1);
    plot(ax1, xn, 0, 'bo','MarkerFaceColor','b');
end
hold(ax1,'off');

% (b) p'(x) i p''(x)
ax2 = axes('Position',[0.7 0.55 0.25 0.35]);
plot(ax2, xx, dy, 'g-','LineWidth',1.6); hold(ax2,'on');
yyaxis(ax2,'right');
plot(ax2, xx, d2y, 'm-','LineWidth',1.6);
hold(ax2,'off');
xlabel(ax2,'x','FontSize',11,'FontWeight','bold');
yyaxis(ax2,'left');  ylabel('p''(x)=3x^2','Color','g');
yyaxis(ax2,'right'); ylabel('p''''(x)=6x','Color','m');
title(ax2,'p'' & p''''','FontSize',12,'FontWeight','bold');
grid(ax2,'on'); box(ax2,'on');

ax3 = axes('Position',[0.7 0.1 0.25 0.35]);
err = abs(xHist - xStat);
semilogy(0:length(err)-1, err,'-o','LineWidth',1.6,'MarkerFaceColor',[0.85,0.33,0.10]);
grid(ax3,'on');
xlabel(ax3,'iteracja k','FontSize',11,'FontWeight','bold');
ylabel(ax3,'|x_k-x^*|','FontSize',11,'FontWeight','bold');
title(ax3,'Zbieżność Newtona','FontSize',12,'FontWeight','bold');
