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

noiseBins = true(size(P));
noiseBins([1, Jin + 1]) = false;
noiseBins(hb + 1) = false;

Ptot   = sum(P);
spur   = P;  spur(Jin+1) = 0;
m.SNR   = 10 * log10(Ps / sum(P(noiseBins)));
m.SINAD = 10 * log10(Ps / (Ptot - Ps));
m.THD    = 10 * log10(Ph / Ps);
m.SFDR   = 10 * log10(Ps / max(spur));
m.ENOB   = (m.SINAD - 1.76) / 6.02;
m.harm_bins = hb;
end
