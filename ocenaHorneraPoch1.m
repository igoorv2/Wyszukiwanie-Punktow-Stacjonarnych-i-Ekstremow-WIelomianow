function y1 = ocenaHorneraPoch1(wsp, x)
    stopien = length(wsp)-1;          
    b = wsp(1:end-1) .* (stopien:-1:1);
    y1 = ocenaHornera(b, x);
end
