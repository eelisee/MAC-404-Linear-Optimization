
% Testbeispiel 1
A = [2 4 1 1 0; 3 6 4 0 1];
b = [8; 6];
c = [1 1 1 0 0];
B1 = [4 5];  % Startbasis 1
B2 = [2 4];  % Startbasis 2

% Lösung mit Basis B1
[EndTab1, x_opt1, opt_zfw1] = simplex(A, b, c, B1);
disp('Ergebnis mit Basis B1:');
disp('Endtableau:'), disp(EndTab1);
disp('Optimale Lösung:'), disp(x_opt1);
disp('Optimaler Zielfunktionswert:'), disp(opt_zfw1);

% Lösung mit Basis B2
[EndTab2, x_opt2, opt_zfw2] = simplex(A, b, c, B2);
disp('Ergebnis mit Basis B2:');
disp('Endtableau:'), disp(EndTab2);
disp('Optimale Lösung:'), disp(x_opt2);
disp('Optimaler Zielfunktionswert:'), disp(opt_zfw2);
