

close all;
clear all;

disp('Read and display file');




b = [-1.058247e-004, -3.036818e-003, -7.088693e-003, -1.214146e-002, -1.561728e-002, -1.465814e-002,            -7.587982e-003, 4.402833e-003, 1.670990e-002, 2.270099e-002, 1.690693e-002, -1.316640e-003, -2.563640e-002,         -4.376793e-002, -4.193050e-002, -1.116868e-002, 4.733457e-002, 1.207813e-001, 1.883636e-001, 2.288243e-001,    2.288243e-001, 1.883636e-001, 1.207813e-001, 4.733457e-002, -1.116868e-002, -4.193050e-002, -4.376793e-002,     -2.563640e-002, -1.316640e-003, 1.690693e-002, 2.270099e-002, 1.670990e-002, 4.402833e-003, -7.587982e-003,    -1.465814e-002, -1.561728e-002, -1.214146e-002, -7.088693e-003, -3.036818e-003, -1.058247e-004 ];

a = 1;

fs =  100e6;

f_b = 40e6;

doba = 1e-4; %0,5 ms
t=0:1/fs:doba;

sig = zeros (1, length(t));

 sig = 2 .* (0.5-rand(1, length(t)))/1e2;  %sirkopasmovy sum
% for i=1:10
% 
%     s = sin( (2*pi*fs/21*i) *t); 
%     
%     sig = sig + s;
% end
%sig = 1 .*  sin(2*pi*f_b*t); 
    
out  = filter (b, a, sig);

%sig = sig .* hamming (length(sig))';

freqo = -fs/2:fs/length(sig):fs/2-1;



figure (1);

subplot 221;
plot (t, sig);

subplot 222;
plot (freqo, 20*log10(fftshift(abs(fft(sig)))));

out = out (500: 8192+500-1);
t    = t (500: 8192+500-1);
freqo = -fs/2:fs/length(out):fs/2-1;

subplot 223;
plot (t, out);

subplot 224;
plot (t, 20*log10(fftshift(abs(fft(out)))));




20*log10(max(sig)/max(out))

