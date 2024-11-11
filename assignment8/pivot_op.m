% ========== pivot_operation.m =================
function [ T, B ] = pivot_op( z, s, T, B )
% Indextransformation Vorlesung -> Matlab
% Teilen der Pivotzeile durch das Pivotelement (PE) => elementare
% Zeilenumformung durch die PE = 1 wird
T(z,:) = T(z,:)./T(z,s);
% Von allen Zeilen (bis auf die Pivotzeile) wird ein Vielfaches der
% Pivotzeile abgezogen, so dass in der Pivotspalte ein Einheitsvektor
% entsteht
for i = 1:length(T(:,1))
if i ~= z
T(i,:) = T(i,:) - T(i,s)/T(z,s).*T(z,:);
end
end
% Basis aktualisieren (mit rücktransformierten Indizes)
B(z) = s;
end