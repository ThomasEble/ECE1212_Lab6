function s = static_dac(v, N, Vref)
% STATIC_DAC  End-point static metrics from the DAC output for ALL codes.  
v = v(:);  
K = numel(v);
LSB = Vref/2^N;
s.LSB_act      = (v(end) - v(1)) / (K-1);   
s.offset_lsb   = v(1) / LSB;
s.gain_err_pct = (s.LSB_act/LSB - 1) * 100;
s.DNL          = diff(v)/s.LSB_act - 1;   
s.INL          = (v - (v(1) + (0:K-1).'*s.LSB_act)) / s.LSB_act;
s.maxDNL       = max(abs(s.DNL));
s.maxINL       = max(abs(s.INL));
s.monotonic    = all(diff(v) > 0);
end
