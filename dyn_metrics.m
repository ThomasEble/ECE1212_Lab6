function m = dyn_metrics(x, Jin, A, Vref, nHarm)
% DYN_METRICS  SNR, SINAD, THD, SFDR, ENOB from a COHERENT record x (codes or volts).
%   Jin   : input bin     A : input amplitude (V)     nHarm : highest harmonic (default 9)
if nargin < 5, nHarm = 9; end
x = x(:);  M = numel(x);
x = x - mean(x);                                % remove DC
P = abs(fft(x)).^2;   P = P(1:M/2+1);           % bins 0 ... M/2 -> P(bin+1)
P(1) = 0;                                       % DC excluded
Ps = P(Jin+1);

hb = [];                                        % harmonic bins, folded into 0 ... M/2
for h = 2:nHarm
    b = mod(h*Jin, M);  if b > M/2, b = M - b; end
    hb(end+1) = b;                              %#ok<AGROW>
end
hb = unique(hb(hb ~= Jin & hb ~= 0));
Ph = sum(P(hb+1));

Ptot   = sum(P);
spur   = P;  spur(Jin+1) = 0;
m.SNR    = ...
m.SINAD  = ...
m.THD    = ...
m.SFDR   = ...
m.ENOB   = ...
m.harm_bins = ...
end
