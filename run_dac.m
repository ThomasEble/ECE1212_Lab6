function v = run_dac(dac, code)
% RUN_DAC  Output voltage of DAC instance for a vector of input codes.
code = code(:);
bits = mod(floor(code ./ 2.^(0:dac.N-1)), 2);       % M-by-N, LSB first
v    = dac.gain * (bits * dac.w(:)) + dac.offset;
end
