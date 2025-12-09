function [x_stat, p1, p2, klasyfikacja, xHist] = znajdzPunktStacjonarny(wsp, x0, tol, maxIter)
    x     = x0;
    xHist = x;
    tol2  = 1e-2;    

    for k = 1:maxIter
        p1 = ocenaHorneraPoch1(wsp, x);
        p2 = ocenaHorneraPoch2(wsp, x);

        if abs(p1) < tol
            break;      
        end
        if abs(p2) < tol2
            warning('Druga pochodna (w przybliżeniu) ≈ 0 – przerwanie.');
            break;     
        end

        x = x - p1/p2;
        xHist(end+1) = x;
    end

    x_stat = x;

    % teraz klasyfikacja na podstawie p2 i tol2
    if abs(p2) < tol2
        klasyfikacja = 'brak rozstrzygnięcia';
    elseif p2 > 0
        klasyfikacja = 'minimum';
    else
        klasyfikacja = 'maksimum';
    end
end

  