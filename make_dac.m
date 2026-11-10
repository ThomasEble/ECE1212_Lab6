function dac = make_dac(N, Vref, p)
% MAKE_DAC  Create ONE DAC instance. p (struct, all fields optional):
%   p.sigma_u    : relative std-dev of a UNIT element (e.g. 0.01 = 1 %)
%   p.gain_err   : fractional gain error (e.g. -0.01 = -1 %)
%   p.offset_lsb : offset in LSB
if nargin < 3, p = struct(); end
def = struct('sigma_u',0,'gain_err',0,'offset_lsb',0);
f = fieldnames(def);
for i = 1:numel(f), if ~isfield(p,f{i}), p.(f{i}) = def.(f{i}); end, end

k = 0:N-1;                                   % bit index, 0 = LSB
% Bit k is built from 2^k unit elements -> its relative error is sigma_u/sqrt(2^k)
eps_k   = p.sigma_u * randn(1,N) ./ sqrt(2.^k);
dac.N   = ...  
dac.Vref = ...  
dac.LSB = ...
dac.w   = ...     % actual bit weights (V), LSB first
dac.gain   = ...
dac.offset = ...
end
