
% This file read file output_vector.txt and plot
% all signals in time and frequency domain.


close all;
clear all;

disp('Read and display file');

%---------------- snr----------------------------
%open file
fid = fopen('output_vec1.txt');
tline = fgetl(fid);
disp (tline);
j = 1;

%read file
while ischar(tline)
%    disp(tline)
    tline = fgetl(fid);
    
    if tline == -1
        break;
    end
    

    t = strread (tline, '%s');
    
    a = t{1}; %curly brackets, it is cell
    b = t{2};
    c = t{3};
    d = t{4}; 
    
    a = str2double(a); %my_signed2num(a);
    b = str2double(b); %my_signed2num(b);
    c = str2double(c); %my_signed2num(c);
    d = str2double(d); %my_signed2num(d);
    
       
    test_aa(j)    = a;
    test_bb(j)    = b;
    test_cc(j)    = c;
    test_dd(j)    = d;
    j = j + 1;
end
test_dd = test_dd (50: 4000+50-1);

%-------------------------------------
%profile on;

%open file
fid = fopen('output_vec.txt');
tline = fgetl(fid);
disp (tline);
j = 1;

%read file
while ischar(tline)
%    disp(tline)
    tline = fgetl(fid);
    
    if tline == -1
        break;
    end
    

    t = strread (tline, '%s');
    
    a = t{1}; %curly brackets, it is cell
    b = t{2};
    c = t{3};
    d = t{4}; 
    
    a = str2double(a); %my_signed2num(a);
    b = str2double(b); %my_signed2num(b);
    c = str2double(c); %my_signed2num(c);
    d = str2double(d); %my_signed2num(d);
    
       
    test_a(j)    = a;
    test_b(j)    = b;
    test_c(j)    = c;
    test_d(j)    = d;
    j = j + 1;
end




figure (2);

%remove first samples, because the are usually NaN
test_a = test_a (50: 4000+50-1);
test_b = test_b (50: 4000+50-1);
test_c = test_c (50: 4000+50-1);
test_d = test_d (50: 4000+50-1);

%sampling frequency
fs   =  100e6;
time = 5e-3; 

%frequency and time axis
t     = 0:time/length(test_a):time - time/length(test_a);
freqo = -fs/2:fs/length(test_a):fs/2-1;


   

%plot
subplot (2, 4, 1);
    plot (t, test_a);
    title ('A');

subplot (2, 4, 2);
    plot (freqo, 20*log10(fftshift(abs(fft(test_a)))));
    title ('fft A');
    
    
subplot (2, 4, 3);
    plot (t, (test_b));
    title ('B');

subplot (2, 4, 4);
    plot (freqo, 20*log10(fftshift(abs(fft(test_b)))));
    title ('fft B');
    
    
subplot (2, 4, 5);
    plot (t, test_c);
    title ('C');

subplot (2, 4, 6);
    plot (freqo, 20*log10(fftshift(abs(fft(test_c)))));
    title ('fft C');
    
    
subplot (2, 4, 7);
    plot (t, test_d);
    title ('D');

subplot (2, 4, 8);
    plot (freqo, 20*log10(fftshift(abs(fft(test_d)))));
    title ('fft D');


    figure(3)
    plot (t, test_d, 'r');
    hold on
    plot (t, test_a*5000,'g');
    hold on 
    plot (t, test_c, 'y');
    hold off

  
    
    title ('D');
  
    figure (4)
    plot (t, test_a);
    title ('A');
      figure (5)
     plot (t, test_b);
     title ('B');
      figure (6)
     plot (t, test_c);
     title ('C');
      figure (7)
     plot (t, test_d);
     title ('D');
    

      figure (40)
    plot (t, test_dd);
    title ('AA');
 %   profile viewer

    snr = 10*log10(sum(test_dd.^2) ./ sum((test_dd-test_d).^2))
  
    