%% ECE 1212 / Data Converter Lab — Part 4
% ADC static non-idealities 
clear; close all; clc;
rng(1);                 % reproducible random numbers
N    = 10;              % resolution
Vref = 1.0;             % full-scale (V)
LSB  = Vref/2^N;        % V

if ~usejava('desktop')
    set(0, 'DefaultFigureVisible', 'off');
end

adc = make_adc(N, Vref);                              % ideal
x   = linspace(0,Vref-1e-6,5000).';
nMismatch = sum(run_adc(adc,x) ~= ideal_adc(x,N,Vref));
if nMismatch == 0
    fprintf('Part 4.1: run_adc matches ideal_adc on all %d points\n', numel(x));
else
    xc = (0.5:1:2^N-0.5).'*LSB;                       % bin centers
    assert(all(run_adc(adc,xc) == ideal_adc(xc,N,Vref)), ...
        'Model mismatch even at bin centers');
    fprintf('Part 4.1: assertion failed at %d / %d linspace points; bin centers match.\n', ...
            nMismatch, numel(x));
end
T = adc.T(:);  K = numel(T);
maxDNL = max(abs(diff(T)/((T(end)-T(1))/(K-1)) - 1));
maxINL = max(abs((T - T(1))/((T(end)-T(1))/(K-1)) - (0:K-1).'));
fprintf('Ideal ADC: maxDNL=%.1e maxINL=%.1e\n', maxDNL, maxINL);

p   = struct('offset_lsb', 2.5, 'gain_err', 0.005);   % +2.5 LSB, +0.5 %
adc = make_adc(N, Vref, p);
Teff = (adc.T - Vref/2 - adc.offset)/adc.gain + Vref/2;
K    = numel(Teff);
offset_lsb   = (Teff(1) - LSB)/LSB;
gain_err_pct = ((Teff(end)-Teff(1))/((K-1)*LSB) - 1)*100;
fprintf('Set: offset=+2.5 LSB, gain=+0.5%%\n');
fprintf('Measured (end-point on Teff): offset=%.3f LSB, gain_err=%.3f %%\n', ...
        offset_lsb, gain_err_pct);
fprintf('(Gain is applied about mid-scale, so the gain-error sign on T is inverted,\n');
fprintf(' and end-point offset is not equal to the offset_lsb knob.)\n');
