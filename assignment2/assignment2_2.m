function [x_opt, z_opt] = myenumeration(A, b, c)
    % Input: Matrix A (nx1), b (mx1), c (nx1) mit m <= n und Ax = b, x >=
    % 0.
    % Output: optimale Basislösung und ZF-Wert, falls das LP beschränkt ist
    % [x_opt, z_opt]
    
    %notwendige Definitionen
    [m, n] = size(A);

    % Berechnew alle m-elementigen Teilmengen B1,...BN von 1 bis n mit N =
    % (n m)
    N = nchoosek(n, m);
    teilmengen = nchoosek(1:n, m);
    
    % Setze k :=1 und z = -unendlich, x als leerer Vektor
    z_opt = -Inf;
    x_opt = [];

    % Initializiere Schleife über die Bk's
    for k = 1:N
        B_k = teilmengen(k, :); %nur für Definition der Spalten
        A_B_k = A(:, B_k); % zur Spaltenauswahl der aktuellen Spalte B_k
        
        if rank(A_B_k) == m
            % Löse das lineare Gleichungssystem B_k * u = b um x_B_k zu
            % erhalten
            x_B_k = A_B_k \ b;
            
            % Setze x_j generell 0, daher initialisieren als Nullvektor
            x = zeros(n, 1);
            
            x(B_k) = x_B_k; % Anpassung der Werte von x_j an (x_B_k)_j
            
            % x >= 0 testen, c^T*x > z automatisch mit der nächsten
            % Schleife getestet
            if all(x >= 0)  % jeder Eintrag getestet
                z = c' * x; %z = c^T *x setzen

                if z > z_opt % hier test auf c^T*x > z (altes z), erst dann c^T*x als neues z festgelegt
                    z_opt = z;
                    x_opt = x;
                end
            end
        end
    end
end


% Beispiel (a)
A_a = [40 24 1 0 0; 
       14 48 0 1 0; 
       0 60 0 0 1];
b_a = [480; 480; 480];
c_a = [10; 40; 0; 0; 0];
[x_opt_a, z_opt_a] = myenumeration(A_a, b_a, c_a);

disp('x_opt für Beispiel (a):');
disp(x_opt_a);
disp('z_opt für Beispiel (a):');
disp(z_opt_a);



% Beispiel (b)
A_b = [2 3 1 1 0 0 0; 
       4 1 2 0 1 0 0; 
       3 4 2 0 0 1 0; 
      -5 -4 -3 0 0 0 1];
b_b = [5; 11; 8; 0];
c_b = [5; 4; 3; 0; 0; 0; 0];

[x_opt_b, z_opt_b] = myenumeration(A_b, b_b, c_b);

disp('x_opt für Beispiel (b):');
disp(x_opt_b);
disp('z_opt für Beispiel (b):');
disp(z_opt_b);



%%% AUSGABE %%%%

assignment2_2
x_opt für Beispiel (a):
    6.8571
    8.0000
   13.7143
         0
         0

z_opt für Beispiel (a):
  388.5714

x_opt für Beispiel (b):
     2
     0
     1
     0
     1
     0
    13

z_opt für Beispiel (b):
    13