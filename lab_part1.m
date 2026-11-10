%% ECE 1212 / Data Converter Lab
% Ideal 10-bit DAC
clear; close all; clc;
rng(1);                 % reproducible random numbers
N    = 10;              % resolution
Vref = 1.0;             % full-scale (V)
LSB  = Vref/2^N;        % V

if ~usejava('desktop')
    set(0, 'DefaultFigureVisible', 'off');
end

c3 = (0:7).';   v3 = ideal_dac(c3, 3, Vref);
c  = (0:2^N-1).'; v = ideal_dac(c, N, Vref);
figure;
subplot(1,2,1); stairs(c3, v3, 'LineWidth',1.5); grid on;
xlabel('Input code'); ylabel('V_{out} (V)'); title('3-bit ideal DAC');
subplot(1,2,2); plot(c, v); grid on;
xlabel('Input code'); ylabel('V_{out} (V)'); title('10-bit ideal DAC');
save_lab_fig('part1_dac_tf');

fprintf('Part 1 checkpoints:\n');
fprintf('  code 0    -> %.6f V\n', v(1));
fprintf('  code 1    -> %.6f V\n', v(2));
fprintf('  code 512  -> %.6f V\n', v(513));
fprintf('  code 1023 -> %.6f V  (Vref-1LSB = %.6f)\n', v(end), Vref-LSB);
fprintf('  max(diff(v))/LSB - 1 = %.3e\n', max(diff(v))/LSB - 1);
