% ========== pivot_element.m =================
function [z,s] = pivot_element(T)
% Bestimmt in einem Simplex-Tableau T Pivot-Zeile und -Spalte, bzw. erkennt,
% ob diese nicht waehlbar ist. In diesem Fall wird [0,0] (weder Spalte noch
% Zeile waehlbar, bzw. [0,s] (Spalte, aber keine Zeile waehlbar) zurueck
% gegeben
% Groesse des Tableaus bestimmen
[p, q] = size(T);
% Pivot-Spalte suchen
% Bestimmt minimales Element und dessen Position
[mini, s] = min(T(p,1:q-1));
if mini >= 0
% existieren keine negativen Koeffizienten, also keine Pivotspalte
s = 0;
z = 0;
else
% Pivot-Spalte s wurde bereits bestimmt, bestimme nun die Pivot-Zeile
% Initialisieren
min_quotient = Inf;
z = 0;
for i = 1:p-1
if T(i,s) > 0
% Wenn der betreffende Eintrag groesser 0 ist, wird der
% zugehoerige Quotient gebildet
quotient = T(i,q)/T(i,s);
if quotient < min_quotient
% Wenn der gefundene Quotient kleiner als der kleinste bisher
% gefundene ist, wird dieser ueberschrieben und sich die neue
% Zeile gemerkt
min_quotient = quotient;
z = i;
end
end
end
% Wurde die Schleife komplett durchlaufen, ohne dass ein Element
% groesser Null gefunden wurde, so bleibt z auf dem Anfangswert 0, es
% wird also [0,s] zurückgegeben
% Ansonsten werden Pivot-Zeile und -Spalte [z, s] zurückgegeben
end