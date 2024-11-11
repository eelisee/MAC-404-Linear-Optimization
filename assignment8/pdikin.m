% ======= pdikin.m ======
function [x_opt, z_opt] = pdikin(A, b, c, x0, beta, epsilon, T)
    % Eingabe:
    % A, b, c - Matrizen und Vektor der LP in Normalform (Ax = b, x >= 0)
    % x0 - Startpunkt
    % beta - Dämpfungsparameter
    % epsilon - Abbruchkriterium für den Fehler
    % T - maximale Anzahl der Iterationen
    x = x0;
    n = length(c);
    I = eye(n);
    
    for k = 1:T
        % Skalierungsmatrix und skalierte Versionen von A und c
        Xk = diag(x);
        Ak = A * Xk;
        ck = Xk * c;
        
        % Berechne den dualen Vektor yk als Lösung von Ak * Ak' * yk = Ak * ck
        yk = (Ak * Ak') \ (Ak * ck);
        
        % Berechne den Residualvektor rk = ck - Ak' * yk
        rk = ck - Ak' * yk;
        
        % Überprüfe auf Unbeschränktheit
        if all(rk >= 0)
            x_opt = [];
            z_opt = Inf;
            return;
        end
        
        % Berechne die Schrittweite alpha
        neg_idx = rk < 0;
        alpha = min(-beta ./ rk(neg_idx));
        
        % Aktualisiere den Punkt x
        x = x + alpha * Xk * rk;
        
        % Überprüfe das Abbruchkriterium
        if norm(alpha * Xk * rk) < epsilon
            x_opt = x;
            z_opt = c' * x;
            return;
        end
    end
    
    % Maximale Anzahl an Iterationen erreicht
    x_opt = x;
    z_opt = c' * x;
end