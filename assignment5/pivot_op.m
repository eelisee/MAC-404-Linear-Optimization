function [T_new, B_new] = pivot_op(z, s, T, B)
    [m, n] = size(T);
    T_new = T;
    
    % Pivotieren um das Element T(z, s)
    T_new(z, :) = T(z, :) / T(z, s);  % Pivot-Zeile durch Pivot-Element teilen
    for i = 1:m
        if i ~= z
            T_new(i, :) = T(i, :) - T(i, s) * T_new(z, :);
        end
    end
    
    % Aktualisierung der Basis
    B_new = B;
    B_new(z) = s;  % Ersetze alte Basisvariable mit der neuen
end