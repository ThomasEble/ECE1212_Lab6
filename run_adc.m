function code = run_adc(adc, vin)
% RUN_ADC  Quantize vin (volts) with ADC instance. Returns codes 0 ... 2^N-1.
v = vin(:) - adc.Vref/2;                         % re. mid-scale
v = v + adc.k2*v.^2 + adc.k3*v.^3;               % front-end nonlinearity
v = adc.gain*v + adc.Vref/2 + adc.offset;        % gain and offset
v = v + adc.noise*randn(size(v));                % thermal noise
code = discretize(v, [-inf; adc.T; inf]) - 1;    % compare against thresholds
end
