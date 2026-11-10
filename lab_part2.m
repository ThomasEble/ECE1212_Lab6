%% ECE 1212 / Data Converter Lab — Part 2
% Ideal 10-bit ADC
clear; close all; clc;
rng(1);                 % reproducible random numbers
N    = 10;              % resolution
Vref = 1.0;             % full-scale (V)
LSB  = Vref/2^N;        % V

if ~usejava('desktop')
    set(0, 'DefaultFigureVisible', 'off');
end

vin  = linspace(-0.05, 1.05, 20001).'*Vref;       % slight over-range on purpose
code = ideal_adc(vin, N, Vref);
vq   = (code + 0.5)*LSB;                          % reconstruction level = bin center

figure;
subplot(2,1,1); plot(vin, code); 
grid on; 
ylabel('Output code'); 
title('Ideal 10-bit ADC');

subplot(3,1,2); 
plot(vin, code); 
grid on;
title('Ideal Zoom: (steps)'); 
xlim([0.2 0.21]);
ylim([200 220])
ylabel('Code');

subplot(3,1,3); 
plot(vin, (vin - vq)/LSB); 
grid on;
xlabel('V_{in} (V)'); 
ylabel('Error (LSB)'); 
title('Quantization error (zoom)');
xlim([0.2 0.21]); 
ylim([-0.6 0.6]);
save_lab_fig('part2_adc_tf');


