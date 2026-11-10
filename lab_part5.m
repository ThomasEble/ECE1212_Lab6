%% ECE 1212 / Data Converter Lab — Part 5
% Dynamic metrics on the ideal ADC
clear; close all; clc;
rng(1);                 % reproducible random numbers
N    = 10;              % resolution
Vref = 1.0;             % full-scale (V)
LSB  = Vref/2^N;        % V

if ~usejava('desktop')
    set(0, 'DefaultFigureVisible', 'off');
end

M    = 4096;           % record length
Jin  = 127;            % odd number of cycles
fs   = 100e6;          % 100 MS/s (any value; only used for the axis)
A    = 0.495*Vref;     % about -0.09 dBFS (to leave margin against clipping)

[vin, fin] = gen_sine(M, Jin, A, Vref, fs);
code = ideal_adc(vin, N, Vref);
m    = dyn_metrics(code, Jin, A, Vref);

f = (0:M/2)*fs/M/1e6;

fprintf('Ideal ADC: SNR=%.2f SINAD=%.2f SFDR=%.2f THD=%.2f ENOB=%.3f\n', ...
        m.SNR, m.SINAD, m.SFDR, m.THD, m.ENOB);
fprintf('Theory SINAD = %.2f dB, noise floor ~ %.1f dBc/bin\n', ...
        6.02*N+1.76 + 20*log10(2*A/Vref), -m.SNR - 10*log10(M/2));
