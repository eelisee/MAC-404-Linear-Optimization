
function [EndTab, x_opt, opt_zfw] = simplex(A, b, c, B)
    % Erzeuge Starttableau mit gegebener Basis
    T = start_tab(A, b, c, B);
    [m, n] = size(T);  % Bestimme die Größe des Tableaus

    while true
        % Bestimme das Pivot-Element
        [z, s] = pivot_element(T);
        
        % Keine Pivot-Spalte gefunden => optimales Tableau
        if s == 0
            EndTab = T;
            x_opt = zeros(n-1, 1);
            x_opt(B) = T(1:m-1, n);
            opt_zfw = -T(m, n);  % Zielfunktionswert ist in der letzten Zeile
            return;
        end
        
        % Unbeschränktes Problem
        if z == 0
            EndTab = T;
            x_opt = [];
            opt_zfw = Inf;  % Unbeschränkt
            return;
        end
        
        % Pivot-Operation durchführen
        [T, B] = pivot_op(z, s, T, B);
    end
end
