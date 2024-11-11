function [EndTab, x_opt, opt_zfw] = simplex(A,b,c,B)
% Bestimmen des Start-Tableaus
EndTab = start_tab(A,b,c,B);
% Initialisierung der weiteren Rueckgabewerte
opt_zfw = -inf;
x_opt=[];
pivot_rule = @pivot_element;    % Pivotregel festlegen
[Z,S] = pivot_rule(EndTab); % Pivotelement suchen
% Solange eine Pivot-Spalte gefunden werden kann, wird der Algorithmus
% fortgesetzt
while (S~=0)
    if (Z==0)
        % Wenn eine Pivot-Spalte, aber keine Zeile gewaehlt werden konnte,
        % ist das Problem unbeschraenkt
        disp('unbounded!')
        x_opt = [];
        opt_zfw = inf;
        S = 0;
    else
        % Wenn eine Pivotzeile gefunden wurde, fuehre eine Pivot-Operation
        % durch und bestimme das naechste Pivot-Element
        [EndTab, B] = pivot_op(Z,S,EndTab,B);
        [Z,S] = pivot_rule(EndTab);
    end
end
% Konstruieren der Loesung x_opt (falls nicht vorher schon festgestellt
% wurde, dass das Problem unbeschraenkt ist)
if opt_zfw ~= inf
    % x_opt mit Nullen initialisieren
    x_opt = zeros(1,length(c));
    % Werte der Basisvariablen eintragen
    for i=1:length(B)
        x_opt(B(i)) = EndTab(i,end);
    end
    % Wenn x_opt eine negative Komponente hat, war das Problem unzulaessig
    if sum(x_opt<0) > 0
        x_opt = [];
        opt_zfw = [];
   
    else
        opt_zfw = EndTab(end,end);
    end
end
end % function