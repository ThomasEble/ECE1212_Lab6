function adc = make_adc(N, Vref, p)
% MAKE_ADC  Create ONE ADC instance. p fields (all optional):
%   p.sigma_R    : relative std-dev of each ladder resistor (e.g. 0.02)
%   p.gain_err   : fractional gain error (about mid-scale)
%   p.offset_lsb : input-referred offset (LSB)
%   p.noise_lsb  : input-referred rms thermal noise (LSB)
%   p.k2, p.k3     : front-end nonlinearity  v -> v + k2*v^2 + k3*v^3  (v re. mid-scale, V)
if nargin < 3, p = struct(); end
def = struct('sigma_R',0,'gain_err',0,'offset_lsb',0,'noise_lsb',0,'k2',0,'k3',0);
f = fieldnames(def);

for i = 1:numel(f)
    if ~isfield(p,f{i}), p.(f{i}) = def.(f{i}); end
end

M = 2^N;
R = 1 + p.sigma_R*randn(M,1);                   % ladder resistors

adc.T = Vref * cumsum(R(1:end -1)) / sum(R);       % thresholds T(1)...T(M-1), ideal = k*LSB
adc.N = N;
adc.Vref = Vref;
adc.LSB = Vref / M;
adc.gain = 1 + p.gain_err;
adc.offset = p.offset_lsb * adc.LSB;
adc.noise  = p.noise_lsb * adc.LSB;
adc.k2 = p.k2;
adc.k3 = p.k3;
end
