% ======== setup_klee_minty.m ==========

function [A, b, c, B] = setup_klee_minty(n)
% SETUP_KLEE_MINTY Erstellt die Klee-Minty-Instanz für das Simplex-Algorithmus.
%   [A, b, c, B] = setup_klee_minty(n) erstellt die Koeffizientenmatrix A,
%   den rechten Seitenvektor b, den Zielfunktionsvektor c und den Basisvektor B
%   für Klee-Minty Optimierungsproblem der Dimension n.
%
%   Eingabe:
%       n - Dimension des Klee-Minty-Würfels
%
%   Ausgabe:
%       A - Koeffizientenmatrix der Nebenbedingungen
%       b - Vektor der rechten Seite der Nebenbedingungen
%       c - Zielfunktionsvektor
%       B - Start-Basisvektor

    A = zeros(n, n);
    b = zeros(n, 1);
    c = zeros(n, 1);
    
    for j = 1:n
        c(j) = 10^(n - j); % Koeffizienten 10^(n-j) für jedes x_j
    end
    
    for i = 1:n
        for j = 1:i
            if j == i
                A(i, j) = 1;         % Standarddefinition des Klee Minty Problems, in dem coeff(xi) = 1
            else
                A(i, j) = 10^(i - j); % 10^(i-j) für die vorhergehenden x_j
            end
        end
        b(i) = 100^(i - 1);
    end
    B = 1:n;
end