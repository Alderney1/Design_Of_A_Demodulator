
% This file generate test vectors A nad B
% plot them in time and freqency domain
% and write them to file input_vec.txt.
% This file can be then read by VHDL during simulation.



close all;
clear all;

disp('Read and display file');


%profile on;

%sample frequency 100 MHz
fs =  100e6;

%frequency of a and b signal
f_a = 1e6;
f_b = 30e6;

%time
time = 1e-4; %0,5 ms

%time vector
t = 0:1/fs:time;


%a_d = 32000 .* (0.5-rand(1, length(t)));  %nois
b_d =            sinesweep (1, 50e6, time, fs, 1, 0, 0); % sweep sinus
%a_d = 32000 .*  cos(2*pi*f_a*t);
%b_d = 32000 .*  sin(2*pi*f_b*t); 

%a_d = zeros (1, length(t));

a_d = 2 .* (0.5-rand(1, length(t)))/1e2;  %nois
% for i=1:50
% 
%     s = sin( (2*pi*fs/101*i) *t); 
%     
%     a_d = a_d + s;
% end

%signal normalization to 16 bit vector
a_d = 20000/(max(a_d)) .* a_d;
b_d = 20000/(max(b_d)) .* b_d;

%signal round to integer
a_d = round(a_d);
b_d = round(b_d);


%frequency axis
freqo = -fs/2:fs/length(a_d):fs/2-1;

%plot signals
figure (1);

subplot 221;
plot (t, a_d);

subplot 222;
plot (freqo, 20*log10(fftshift(abs(fft(a_d)))));

subplot 223;
plot (t, b_d);

subplot 224;
plot (freqo, 20*log10(fftshift(abs(fft(b_d)))));

%convert to integer
a_d = int32(a_d);
b_d = int32(b_d);
    
%write signal to vector
fid = fopen('input_vec.txt', 'w'); % file containing sim vectors
% normalize for 2’s complement
for i=1:length(a_d)
    %tmp = y(i);
    
    a = a_d (i);
    b = b_d (i);
   
    if(a < 0)%signed unsigned conversion
        a = floor(65535 + a + 1);
    else
        a = floor(a);
    end

    
    if (b < 0)
        b = floor(65535 + b + 1);
    else
        b = floor(b);
    end

    %fwrite(fid, a(i), 'integer*4');
    fprintf(fid, '%04x %04x\n', a, b);
end
fclose(fid);


%profile viewer



