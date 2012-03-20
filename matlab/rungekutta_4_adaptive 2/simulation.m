% Generated file by Simulation

% Cleanup

clc; clear all; close all;

% Everything global
global s v;

% Predefined constants
sim_start = 0.0;
sim_end = 5.0;
sim_t   = 0.0;

%% DEBUG
tmp_idx = 1;
tmp_y = zeros(2,1000);

% Init container values
s.value = 0.0;
v.value = 15.0;

sim_t0 = sim_start;
sim_y0 = [ s.value; v.value ];
sim_dy0 = simulation_dy(sim_t0, sim_y0);
sim_tolerance = 0.001;
sim_threshold = 0.001;
sim_pow = 1/5;

% DT
%sim_hmin=0.001;
sim_hmax=0.5;

sim_a = [
    1/5         3/40    44/45   19372/6561      9017/3168       35/384
    0           9/40    -56/15  -25360/2187     -355/33         0
    0           0       32/9    64448/6561      46732/5247      500/1113
    0           0       0       -212/729        49/176          125/192
    0           0       0       0               -5103/18656     -2187/6784
    0           0       0       0               0               11/84
    0           0       0       0               0               0
    ];

sim_b = [ 1/5, 3/10, 4/5, 8/9, 1, 1];

sim_c = [ 71/57600; 0; -71/16695; 71/1920; -17253/339200; 22/525; -1/40 ];

sim_t = sim_t0;
sim_y = sim_y0;
sim_k = zeros(length(sim_y0), 7);
sim_k(:,1) = sim_dy0;

% Initial-Schritt berechnen aus allen Anfangswerten
sim_h = 1 / (norm(sim_dy0 ./ max(abs(sim_y), sim_threshold), inf) / (0.8 * sim_tolerance^sim_pow));
sim_finish = false;
while ~sim_finish
    
    % Kleinstmöglicher Schritt
    sim_hmin = 16*eps(sim_t);
    
    % Schritt zwischen sim_hmin und sim_hmax
    sim_h    = min(sim_hmax, max(sim_hmin, sim_h)); 
    
    if (sim_t + sim_h) > sim_end
        sim_h = sim_end - sim_t;
        sim_finish = true;
    end;
    
    % Variable sim_t und sim_y werden nicht verändert
    % Nur sim_h kann erniedrigt werden
    sim_nofail = true;
    while true
        sim_ha = sim_h * sim_a;
        sim_hb = sim_h * sim_b;
        
        sim_k(:,2) = simulation_dy(sim_t + sim_hb(1), sim_y + sim_k * sim_ha(:,1));
        sim_k(:,3) = simulation_dy(sim_t + sim_hb(2), sim_y + sim_k * sim_ha(:,2));
        sim_k(:,4) = simulation_dy(sim_t + sim_hb(3), sim_y + sim_k * sim_ha(:,3));
        sim_k(:,5) = simulation_dy(sim_t + sim_hb(4), sim_y + sim_k * sim_ha(:,4));
        sim_k(:,6) = simulation_dy(sim_t + sim_hb(5), sim_y + sim_k * sim_ha(:,5));
        
        sim_tnew = sim_t + sim_hb(6);
        sim_ynew = sim_y + sim_k * sim_ha(:,6);
             
        sim_k(:,7) = simulation_dy(sim_tnew, sim_ynew);
        
        % Fehler zwischen 4. und 5. Ordnung ausrechnen
        sim_err = sim_h * norm((sim_k * sim_c) ./ max(max(abs(sim_y), abs(sim_ynew)), sim_threshold), inf);
        
        % Guter Schritt
        % falls minimale Schrittweite erreicht wurde
        % oder Fehler noch in der Toleranz liegen, brich ab
        if sim_h <= sim_hmin || sim_err <= sim_tolerance
            break;

        % Fehlerhafter Schritt
        % sim_h erniedrigen und die ganze Rechnung nochmals durchführen
        else
            sim_finish = false;
            if sim_nofail
                sim_nofail = false;
                sim_h = max(sim_hmin, sim_h * max(0.1, 0.8*(sim_tolerance/sim_err)^sim_pow));
            else
                sim_h = max(sim_hmin, 0.5 * sim_h);
            end;
        end;
    end;
    
    if sim_nofail
        sim_temp = 1.25*(sim_err/sim_tolerance)^sim_pow;
        if sim_temp > 0.2
          sim_h = sim_h / sim_temp;
        else
          sim_h = 5.0*sim_h;
        end;
    end;
    
    % Die neuen Werte sim_tnew, sim_ynew und sim_k entgültig speichern
    sim_t = sim_tnew;
    sim_y = sim_ynew;
    sim_k(:,1) = sim_k(:,7);
    
    %% DEBUG
    tmp_y(1, tmp_idx) = sim_tnew;
    tmp_y(2, tmp_idx) = sim_ynew(1,1);
    tmp_idx = tmp_idx + 1;
    
end;

%% DEBUG
tmp_res = tmp_y(:, 1:tmp_idx);
figure(1);
stem(tmp_res(1,:), tmp_res(2,:));
figure(2);
plot(tmp_res(1,:), tmp_res(2,:));

