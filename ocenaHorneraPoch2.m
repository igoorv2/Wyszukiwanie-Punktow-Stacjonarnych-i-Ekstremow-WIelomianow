function y2 = ocenaHorneraPoch2(wsp, x)
    stopien = length(wsp)-1;
    b = wsp(1:end-1) .* (stopien:-1:1);
    m = length(b)-1;                      
    c = b(1:end-1) .* (m:-1:1);
    y2 = ocenaHornera(c, x);
end
