

close all;
clear all;

disp('Read and display file');



fs =  10e6; %sample frequency

f_s = 3e3; %signal frequency

%"doba" means time
doba = 5e-3; 
t=0:1/fs:doba;

sig_nf = 0.05 * sin(2*pi*f_s*t);
%sig_nf = 0.001 * sin(2*pi*f_s*t);
%sig_nf = awgn(sig_nf,30,'measured'); % Add white Gaussian noise.

%fm modulovany
s_int = cumsum(sig_nf);
s_int = awgn(s_int,70,'measured');

%preved na IQ data
 i_d = 10000 * cos(s_int);
 q_d = 10000 * sin(s_int); 




i_d = round(i_d);
q_d = round(q_d);


figure (1);

subplot 221;
plot (i_d);

subplot 222;
plot (abs(fft(i_d)));

subplot 223;
plot (q_d);

subplot 224;
plot (abs(fft(q_d)));

 figure(2);
 plot(s_int);
 title('sint');
 
% figure(3);
% plot(sig_nf);
% title('sig_nf');


fid = fopen('input_vec.txt', 'w'); % file containing sim vectors
% normalize for 2’s complement
for i=1:length(i_d)
    %tmp = y(i);
    i_d = int32(i_d);
    q_d = int32(q_d);
    
    if(i_d (i) < 0)
        i_d (i) = floor(hex2dec('ffff') + i_d (i) + 1);
    else
        i_d (i) = floor(i_d (i));
    end

    
    if(q_d (i) < 0)
        q_d (i) = floor(hex2dec('ffff') + q_d (i) + 1);
    else
        q_d (i) = floor(q_d (i));
    end

    %fwrite(fid, a(i), 'integer*4');
    fprintf(fid, '%04x %04x\n', i_d(i), q_d(i));
end
fclose(fid);



    