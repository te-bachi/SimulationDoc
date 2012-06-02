
clear all;
close all;
clc;

% Matrix initialisieren
% dim(A)=7x7 mit A(m,n)=0, A(4,4)=255
x = 4;
y = 4;
A = zeros(7, 7);
A(x, y) = 255;

% Diffusionskonstante
D = 0.1;

% Anfangs- und Endzeit
t_start = 0;
t_end = 50;
dt = 1;

% Laufzeit
t_count = ceil(t_end / dt);

for t = t_start:t_count
    % Matrix zeigen
    figure(1);
    image(A);
    A_sum = sum(sum(A));
    A_sum_str = num2str(A_sum, '%.2f');
    
    % Summe zeigen
    title(strcat('sum of A=', A_sum_str));
    
    % Querschnitt zeigen
    figure(2);
    plot(A(4,:));
    
    % Kurz warten
    pause(0.25);
    
    % Eigentliche Diffusion
    A = sim_diffusion(A, dt, D);
end;

% Auf Kommando-Zeile
A_sum = sum(sum(A));
A_sum_str = num2str(A_sum, '%.2f');
fprintf(1, 'sum of A = %s\n', A_sum_str);

% Vergleich Aktuelle vs. Greensche Funktion
actual = A(4,4);
green = exp(-(x^2 + y^2)/(4 * D * t_end)) / (4 * pi * D * t_end);
fprintf(1, 'actual %.2f = %.2f green\n', actual, green);

