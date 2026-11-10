function v = ideal_dac(code, N, Vref)
% IDEAL_DAC  Ideal binary-weighted DAC.
%   code : integer vector, 0 ... 2^N-1
%   v    : analog output in volts
LSB = ...
code = code(:);

% Method A: direct formula
vA = ...

% Method B: sum of binary-weighted bit contributions
w    = ...                  % MSB weight = Vref/2, ..., LSB weight = Vref/2^N
bits = ... % MSB first, M-by-N
vB   = ...

assert(max(abs(vA - vB)) < 1e-12, 'Methods disagree!');
v = vA;
end
