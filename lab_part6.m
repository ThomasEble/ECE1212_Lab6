%% ECE 1212 / Data Converter Lab — Part 6
% DAC dynamic performance
clear; close all; clc;
rng(1);                 % reproducible random numbers
N    = 10;              % resolution
Vref = 1.0;             % full-scale (V)
LSB  = Vref/2^N;        % V

if ~usejava('desktop')
    set(0, 'DefaultFigureVisible', 'off');
end

M = 4096; Jin = 127; fs = 100e6;
n = (0:M-1).';
A_code = 0.495*2^N;                                   % LSB units
code   = round(2^(N-1) + A_code*sin(2*pi*Jin*n/M));   % ideal digital input
A      = A_code*LSB;                                  % volts

% (a) ideal DAC
v  = ideal_dac(code, N, Vref);
mA = dyn_metrics(v, Jin, A, Vref);

fprintf('Ideal:       SNR=%.1f SINAD=%.1f SFDR=%.1f dBc ENOB=%.2f\n', mA.SNR, mA.SINAD, mA.SFDR, mA.ENOB);



