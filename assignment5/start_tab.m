function TB = start_tab(A, b, c, B)
    % Stellt zu einer gegebenen Matrix A sowie Vektoren b und c das
    % Simplex-Starttableau zur Basis B auf

    % Dimension der Matrix A bestimmen
    [m, n] = size(A);

    % Preallocation des Tableaus
    TB = zeros(m + 1, n + 1);

    % Kosten zur Basis B bestimmen
    c_B = zeros(m, 1);

    % Matrix zur Basis B berechnen
    T_B = zeros(m, m);

    for j = 1:m
        T_B(:, j) = A(:, B(j));   % Auswahl der Basis-Spalten
        c_B(j) = c(B(j));         % Auswahl der entsprechenden Kosten
    end

    % Berechnung der inversen Basis-Matrix
    tmp = T_B \ A;  % tmp ist B^{-1} * A

    % Auffüllen der ersten m Zeilen mit B^{-1} * A
    TB(1:m, 1:n) = tmp;

    % Berechnung der letzten Zeile des Tableaus (Zielfunktionskoeffizienten)
    % Korrigierte Berechnung
    TB(m + 1, 1:n) = - (c' * (T_B \ eye(m))) + c_B' * (T_B \ b);

    % Berechnung der letzten Spalte (rechte Seite b)
    tmp_b = T_B \ b;  % tmp_b ist B^{-1} * b
    TB(:, n + 1) = [tmp_b; c_B' * tmp_b];
end