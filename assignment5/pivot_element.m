function [z, s] = pivot_element(T)
    [m, n] = size(T); % m: Anzahl der Zeilen, n: Anzahl der Spalten
    % Pivot-Spalte wählen: die erste negative Komponente in der letzten Zeile
    s = find(T(m, 1:n-1) < 0, 1);
    
    if isempty(s)
        z = 0;  % Kein Pivot-Element gefunden, Optimallösung erreicht
        s = 0;
        return;
    end
    
    % Pivot-Zeile wählen: Kleinste positive Ratio
    ratios = inf(m-1, 1);
    for i = 1:m-1
        if T(i, s) > 0
            ratios(i) = T(i, n) / T(i, s);
        end
    end
    
    % Bestimme Zeile mit minimalem Verhältnis (Lexikographisch)
    [min_ratio, z] = min(ratios);
    if min_ratio == inf
        z = 0;  % Unbeschränktes Problem
    end
end