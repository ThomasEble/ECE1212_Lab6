function [vin, fin] = gen_sine(M, Jin, A, Vref, fs, sigma_t)
% GEN_SINE  Coherently sampled sine around mid-scale, optional aperture jitter.
%   M       : number of points (power of 2)         Jin : cycles in record (odd)
%   A       : amplitude (V)                          fs  : sampling rate (Hz)
%   sigma_t : rms aperture jitter (s), default 0
if nargin < 6, sigma_t = 0; end
n   = (0:M-1).';
fin = Jin/M*fs;
ph  = 2*pi*Jin*n/M + 2*pi*fin*sigma_t*randn(M,1);
vin = Vref/2 + A*sin(ph);
end
