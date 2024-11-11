% (LP0)

A =[2	4	1	1	0;
3	6	4	0	1];
b = [8; 6;];
c = [1; 1; 1; 0; 0];

B_0 = [4 5];

[EndTab_0,x_opt_0,z_opt_0]=simplex(A,b,c,B_0)

B_2 = [2 4];

[EndTab_2,x_opt_2,z_opt_2]=simplex(A,b,c,B_2)

% (LP1)

A_LP1 = [-2 1 1 0; -1 10 0 1];
b_LP1 = [4; 135];
c_LP1 = [1; 2; 0; 0];

B_LP1 = [3 4];

[EndTab_LP1,x_opt_LP1,z_opt_LP1] = simplex(A_LP1,b_LP1,c_LP1,B_LP1)


% (LP2)

A_LP2 = [1 -1 1 0; -1 1 0 1];
b_LP2 = [-1; -1];
c_LP2 = [0; 1; 0; 0];
B_LP2 = [3 4]

[EndTab_LP2,x_opt_LP2,z_opt_LP2] = simplex(A_LP2,b_LP2,c_LP2,B_LP2)

%(LP3)

A_LP3 = [3 1 3 1 0 0 ; 3 1 4 0 1 0; 1 2 7 0 0 1];
b_LP3 = [1; 1;1];
c_LP3 = [1; 1; 1; 0; 0; 0];

B_LP3 = [4 5 6] ;

[EndTab_LP3,x_opt_LP3,z_opt_LP3] = simplex(A_LP3,b_LP3,c_LP3,B_LP3)


% (Klee Minty)

% n = 2
n = 2;
[A, b, c, B] = setup_klee_minty(n);
[EndTab, x_opt, opt_zfw] = simplex(A, b, c, B);

disp('EndTab für n = 2');
disp(EndTab);
disp('x_opt für n = 2');
disp(x_opt);
disp('opt_zfw für n = 2');
disp(opt_zfw);


% n = 5
n = 5;
[A, b, c, B] = setup_klee_minty(n);
[EndTab, x_opt, opt_zfw] = simplex(A, b, c, B);

disp('EndTab für n = 5');
disp(EndTab);
disp('x_opt für n = 5');
disp(x_opt);
disp('opt_zfw für n = 5');
disp(opt_zfw);


% Bemerkung
disp('weitere Auswertung und Erklärung der Zusammenhänge in der schriftlichen Abgabe.')


% (Aufgabe 4)

A = [0 1 1 0; 5 4 0 1];  % Matrix A
b = [4; 20];              % Vektor b
c = [1; 1; 0; 0];         % Vektor c
x0 = [1; 1; 3; 11];       % Startpunkt x0
beta = 1/2;               % Dämpfungsparameter
epsilon = 1e-5;           % Fehlertoleranz
N = 10000;                % Maximale Iterationszahl

[x_opt, z_opt] = pdikin(A, b, c, x0, beta, epsilon, N);

disp('Optimale Lösung (x_opt):');
disp(x_opt);
disp('Optimaler Zielfunktionswert (z_opt):');
disp(z_opt);