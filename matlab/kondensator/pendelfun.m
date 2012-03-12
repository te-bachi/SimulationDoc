function dy = pendelfun(t, y)
%PENDELFUN DGL Funktion f�r ein mathematisches Pendel
% (keine harmonische N�herung)
% y = Vektor der L�nge 2. Erste Komponente ist der Winkel des Pendels zur
% Vertikalen, zweite Komponente ist die Ableitung des Winkels.

% Parameter werden hard-codiert
g = 9.81;
l = 1;

% Initialisierung des Ergebnisses als Spaltenvektor!
% (Spalten- und KEIN Zeilenvektor: WICHTIG)
dy = zeros(2,1); 

dy(1) = y(2);
dy(2) = - g/l * sin(y(1));

end
