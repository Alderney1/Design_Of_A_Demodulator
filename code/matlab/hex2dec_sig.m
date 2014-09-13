function [ a ] = hex2dec_sig( in_str )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

in_str = hex2dec (in_str);

if in_str >= 2^31
    in_str = in_str - 2^32;
end

a = in_str;
     

end
