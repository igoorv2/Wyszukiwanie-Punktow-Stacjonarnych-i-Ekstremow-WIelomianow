function y = ocenaHornera(wsp, x)    
    n = length(wsp);
    y = wsp(1);
    for i = 2:n
        y = y.*x + wsp(i);
  end
end
