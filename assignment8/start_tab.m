% ========== start_tab.m =================
function TB = start_tab(A,b,c,B)
% Stellt zu einer gegebenen Matrix A sowie Vektoren b und c das
% Simplex-Starttableau zur Basis B auf
% Dimension der Matrix A bestimmen
[m, n] = size(A);
% Preallocation
TB=zeros(m+1,n+1);
% Kosten zur Basis B bestimmen
c_B = zeros(m,1);
% Matrix zur Basis B berechnen
T_B = zeros(m,m);
for j = 1:m
	T_B(:,j) = A(:,B(j));
	c_B(j) = c(B(j));
end
% Bestimmen des Simplextableaus
tmp=T_B\A; 

TB(1:m,1:n)=tmp;
TB(m+1,1:n)=-(c' - c_B' * tmp);
tmp=T_B\b; 

TB(:,n+1)=[tmp; c_B' * tmp];
end
