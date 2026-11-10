%% ECE 1212 / Data Converter Lab — Part 3
% DAC static non-idealities
clear; close all; clc;
rng(1);                 % reproducible random numbers
N    = 10;              % resolution
Vref = 1.0;             % full-scale (V)
LSB  = Vref/2^N;        % V

if ~usejava('desktop')
    set(0, 'DefaultFigureVisible', 'off');
end

c   = (0:2^N-1).';
dac = make_dac(N, Vref);                % all defaults = ideal
s   = static_dac(run_dac(dac,c), N, Vref);
fprintf('Ideal: maxDNL=%.2e  maxINL=%.2e  offset=%.2e LSB  gain=%.2e %%\n', ...
        s.maxDNL, s.maxINL, s.offset_lsb, s.gain_err_pct);
assert(max(abs(run_dac(dac,c) - ideal_dac(c,N,Vref))) < 1e-12, ...
    'run_dac vs ideal_dac mismatch');

p = struct('offset_lsb', 3, 'gain_err', -0.01);
dac = make_dac(N, Vref, p);
v   = run_dac(dac, c);
s   = static_dac(v, N, Vref);

figure;
subplot(2,1,1); plot(c, v, c, ideal_dac(c,N,Vref), '--'); grid on;
legend('Actual','Ideal','Location','northwest'); ylabel('V_{out} (V)');
title(sprintf('maxINL = %.2e LSB,  maxDNL = %.2e LSB', s.maxINL, s.maxDNL));
subplot(2,1,2); plot(c, (v - ideal_dac(c,N,Vref))/LSB); grid on;
xlabel('Code'); ylabel('Error vs ideal (LSB)'); title('Total (absolute) error');
save_lab_fig('part3_offset_gain');
fprintf('offset = %.2f LSB, gain error = %.3f %%, maxINL = %.2e, maxDNL = %.2e\n', ...
        s.offset_lsb, s.gain_err_pct, s.maxINL, s.maxDNL);
