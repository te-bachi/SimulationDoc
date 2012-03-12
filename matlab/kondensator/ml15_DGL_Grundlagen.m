%% Anfangswertprobleme: Grundlagen
% In diesem Skript werden die Grundlagen erkl�rt, wie man mit Matlab
% Anfangswertprobleme analysieren kann. 

%% Beispiel: Entladung eines Kondensators
% Ein Kondensator mit Kapazit�t C habe die Anfangsladung Q0 und werde �ber
% einen Widerstand R entladen. Die DGL lautet dQ/dt = - 1/RC * Q. 

% Konkrete Werte f�r die Parameter: 
R = 2;
C = 1;
Q0 = 3; 
tspan = [0 10]; % Anfangs- und Endzeitpunkt

%% 
% Wichtigster Baustein der Simulation ist die Funktion, die die DGL
% beschreibt. Die Signatur muss so sein, dass als Eingangsparameter |t| und
% |y| (hier die Ladung |q|) �bergeben werden und |dy/dt| (hier |dq/dt|)
% berechnet wird. Der Einfachheit halber benutzen wir hier eine anonyme
% Funktion: 

fun = @(t,q) - q /(R*C);   % anonyme Funktion der Parameter t und q
%% 
% L�sen der DGL und Plotten der L�sung: 
% Wenn |tspan| nur aus 2 Elementen besteht wird die L�sung 
% an den Zeitschritten der Integration zur�ckgeliefert:
[t q] = ode45(fun, tspan, Q0);
plot(t, q, 'bx-');
title('Entladung eines Kondensators'); 
xlabel('Zeit'), ylabel('Ladung');

%% Beispiel mit expliziter t-Abh�ngigkeit:
% dy/dt = -(t+1) * y, y(0) = 1

tspan = 0:0.05:2;  % L�sung wird an diesen Punkten angegeben.
[t y] = ode45(@(t,y) -(t+1)*y, tspan, 1);
plot(t, y);

%% Beispiel: Fadenpendel f�r gro�e Auslenkungen
% In diesem Beispiel wird ein Fadenpendel f�r beliebige Auslenkungen 
% untersucht. Das ist keine harmonische Schwingung mehr.
% Es geht um eine DGL zweiter Ordnung. Die Beschreibungsfunktion 
% passt nicht mehr gut in eine anonyme Funktion und wird in einer 
% m-Datei definiert (Im folgenden ist |g=9.81| die Erdbeschleunigung und 
% |l| die Fadenl�nge des Pendels). 
% Die urspr�ngliche DGL 2. Ordnung ist umformuliert in 2 Gleichungen
% 1.Ordnung. Daher ist |y| jetzt ein Spaltenvektor der L�nge 2.

type pendelfun

%% 
% Berechnung und Plotten der L�sung. Das Pendel soll bei |t=0| bei einer
% Auslenkung von |pi/2| ohne Anfangsgeschwindigkeit losgelassen werden.
% Das |y| im R�ckgabewert von |ode45| ist eine Matrix mit 2 Spalten. Die
% erste Spalte ist der Auslenkungswinkel des Pendels an den Zeitschritten.

yNull = [pi/2; 0];  % Anfangsbedingungen=Spaltenvektor
tspan = [0, 10];   % Simulation von t=0 bis t=10
[t y] = ode45(@pendelfun, tspan, yNull);
plot(t, y(:,1), 'bx-');
title('Fadenpendel, gro�e Auslenkung');
xlabel('Zeit'), ylabel('Winkel');
%% 
% Vergleich mit harmonischer N�herung, die durch 
% |phi(0) * cos(wt)| mit |w = sqrt(g/l)| beschrieben wird.
% Wie man sieht, gibt es gro�e Abweichungen. F�r diese Auslenkungen ist die
% harmonische N�herung nicht mehr sinnvoll.
w = sqrt(9.81);
yharm = yNull(1) * cos(w*t);
hold on;
plot(t, yharm, 'r');
legend('Numerische L�sung', 'Harmonische N�herung');
hold off;


%% Kontrolle der Fehler
% Die numerische L�sung der DGL kann im Detail
% konfiguriert werden mit einem Options-Argument. 
% Diese Optionen kann man mit der Funktion |odeset| bestimmen.
% Jetzt wird z.B. der absolute Fehler hochgesetzt:

opts = odeset('AbsTol', 0.05); 

%% 
% Um andere als die Default-Optionen zu nehmen, muss man die Optionen
% als viertes Argument an den L�ser �bergeben. Hier vergleichen wir die 
% L�sungen f�r unterschiedliche Fehlertoleranzen:
tspan = [0 30]; 
[t y] = ode45(@pendelfun, tspan, yNull);  % Default: AbsTol = 10^(-6)
[t2 y2] = ode45(@pendelfun, tspan, yNull, opts);
plot(t, y(:,1), 'xb-');
hold on, plot(t2, y2(:,1), 'xr-'), hold off;
title('Fadenpendel f�r unterschiedliche Fehlertoleranzen');
xlabel('Zeit'), ylabel('Winkel');
legend('Kleine Fehlertoleranz', 'Gro�e Fehlertoleranz');

%%
% Wie man sieht, entstehen bei der Fehlertoleranz von |AbsTol=0.05|
% erhebliche Probleme: Aus Gr�nden der Energieerhaltung muss die maximale
% Amplitude bei jeder Periode |pi/2| sein, was f�r die rote L�sung nicht
% erf�llt ist. Die blaue L�sung (Fehlertoleranz auf Default Gr��e) zeigt
% diese Probleme nicht: die maximale Amplitude bleibt konstant �ber alle
% Perioden.
% Dass unterschiedliche Fehlertoleranzen auch zu unterschiedlichen
% Schrittweiten f�hren, sieht man auch am Histogramm der Schrittweiten:

figure;
subplot(2,1,1); 
hist(diff(t), 50); 
title('Schrittweiten bei kleiner Fehlertoleranz');
xlabel('Schrittweite'), ylabel('Anzahl');
subplot(2,1,2); 
hist(diff(t2), 50); 
title('Schrittweiten bei gro�er Fehlertoleranz');
xlabel('Schrittweite'), ylabel('Anzahl');

%% Fadenpendel f�r unterschiedliche Fadenl�ngen. 
% Bislang wurde die Fadenl�nge in der DGL-Beschreibungsfunktion
% hard-codiert. Was macht man, wenn man die Simulation f�r verschiedene
% Fadenl�ngen machen m�chte? Man benutzt eine DGL-Funktion, die zus�tzliche 
% Parameter enth�lt, hier die Fadenl�nge, und kann die Parameter dann ganz
% am Ende an den Solver �bergeben. Damit das funktioniert muss man
% allerdings auch die Solver Optionen als viertes Argument �bergeben,
% selbst wenn die Optionen nicht ver�ndert wurden.

type pendelfunFaden

%% 
% Simulationen mit verschiedenen Fadenl�ngen k�nnen 
% jetzt wie folgt durchgef�hrt werden: 
yNull = [pi/2; 0]; 
tspan = [0 10]; 
opts = odeset();  % Default Optionen
l = 0.5; % kurzer Faden 
[t1 y1] = ode45(@pendelfunFaden, tspan, yNull, opts, l); 
l=1.5; % langer Faden
[t2 y2] = ode45(@pendelfunFaden, tspan, yNull, opts, l); 
    
%%
figure;
plot(t1, y1(:,1));
hold on, plot(t2, y2(:,1), 'r'), hold off;
title('Fadenpendel');
xlabel('Zeit'), ylabel('Winkel');
legend('Kurzer Faden', 'Langer Faden');

%% Beispiel: ode45 bekommt Probleme
% |ode45| sollte immer der L�ser sein, den man zuerst ausprobiert. Es gibt
% allerdings Situationen, in der |ode45| Schwierigkeiten bekommt, den Fehler
% zu kontrollieren und daher sehr kleine Schrittweiten w�hlt. 
% Dieses Problem ist aus dem 'Textbook by Cleve Moler',
% http://www.mathworks.com/academia/
% (da kann man auch eine genauere Diskussion finden).

delta = 0.0001;
F = @(t,y) y^2 - y^3;
tic;
[t, y] = ode45(F,[0 2/delta],delta);
z = toc;
plot(t,y, 'x-');
title(sprintf('oder45: Anzahl Schritte: %i, Zeit = %.3f s', length(t), z));

%%
% Nach dem Sprung wird die Schrittweite winzig und die L�sung fluktuiert
% stark auf einer kleinen Skala (reinzoomen). Ein speziell f�r diese
% Probleme entwickelter Solver hat keine M�he: 
tic;
[t, y] = ode23s(F,[0 2/delta],delta); 
z = toc;
plot(t,y, 'x-');
title(sprintf('ode23s: Anzahl Schritte: %i, Zeit = %.3f s', length(t), z));
