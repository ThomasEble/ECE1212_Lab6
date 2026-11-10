function v = ideal_dac(code, N, Vref)
% IDEAL_DAC  Ideal binary-weighted DAC.
%   code : integer vector, 0 ... 2^N-1
%   v    : analog output in volts
LSB = Vref/(2^N);
code = code(:);

% Method A: direct formula
vA = code * LSB;

% Method B: sum of binary-weighted bit contributions
w    = Vref ./ 2.^(1:N).';
bits = mod(floor(code ./ 2.^(N-1:-1:0)), 2);
vB   = bits * w;

assert(max(abs(vA - vB)) < 1e-12, 'Methods disagree!');
v = vA;
end
