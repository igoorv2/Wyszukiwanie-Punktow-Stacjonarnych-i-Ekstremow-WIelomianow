clear; clc; format long

wsp{1} = [1, 0, 0, 0];            x0(1) =  1.0;  col{1} = [0.0, 0.45, 0.74];
wsp{2} = [1, 0, 2, 0, 1];         x0(2) =  1.0;  col{2} = [0.85, 0.33, 0.10];
wsp{3} = [-1, 0, 3, 0, -2, 0, 1]; x0(3) =  1.0;  col{3} = [0.47, 0.67, 0.19];

tol     = 1e-12;
maxIter = 200;

figure('Units','normalized','Position',[0.05 0.05 0.9 0.85]);
t = tiledlayout(3,2,'TileSpacing','compact','Padding','compact');
sgtitle(t, 'Porównanie 3 wielomianów i zbieżność Newtona', ...
        'FontSize',18,'FontWeight','bold');

for i = 1:3
    [x_stat, p1, p2, cls, xHist] = znajdzPunktStacjonarny(...
                                  wsp{i}, x0(i), tol, maxIter);

    ax1 = nexttile;
    xx = linspace(x0(i)-3, x0(i)+3, 600);
    yy = arrayfun(@(z) ocenaHornera(wsp{i}, z), xx);

    area(ax1, xx, yy, ...
         'FaceColor', col{i}, 'FaceAlpha', .2, 'EdgeAlpha', 0);
    hold(ax1,'on');
      plot(ax1, xx, yy, 'LineWidth',2, 'Color',col{i});
      yy_stat = ocenaHornera(wsp{i}, x_stat);
      plot(ax1, x_stat, yy_stat, 'o', ...
           'MarkerSize',10,'MarkerEdgeColor','k', ...
           'MarkerFaceColor',col{i});
      text(ax1, x_stat, yy_stat*1.05, ...
           sprintf(' x^* = %.4f', x_stat), ...
           'FontSize',10,'FontWeight','bold','Color',col{i});
    hold(ax1,'off');

    ax1.FontSize   = 12;
    ax1.FontWeight = 'bold';
    xlabel(ax1,'x','FontSize',12);
    ylabel(ax1,'p_i(x)','FontSize',12);
    title(ax1, sprintf('p_{%d}(x), %s', i, cls), ...
          'FontSize',14,'FontWeight','bold','Color',col{i});
    grid(ax1,'on'); box(ax1,'on');

    ax2 = nexttile;
    plot(ax2, 0:length(xHist)-1, xHist, '-o', ...
         'LineWidth',2, 'MarkerSize',8, ...
         'Color',col{i}, 'MarkerFaceColor','w');
    ax2.XGrid = 'on'; ax2.YGrid = 'on';
    ax2.FontSize   = 12;
    ax2.FontWeight = 'bold';
    xlabel(ax2,'iteracja k','FontSize',12);
    ylabel(ax2,'x_k','FontSize',12);
    title(ax2,'Zbieżność Newtona','FontSize',14,'FontWeight','bold');
    axis(ax2,[0 length(xHist)-1 min(xHist)-0.1 max(xHist)+0.1]);
end
