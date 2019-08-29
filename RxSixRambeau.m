function [bk] = RxSixRambeau(sl, p0, p1, Fse, Nb)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

rl_p0 = conv(sl, fliplr(p0)); % convolution par p0*(-t) filtre adapté de p0 
rl_p1 = conv(sl, fliplr(p1)); % convolution par p1*(-t) filtre adapté de p1
   
rln_p0 = rl_p0(Fse:Fse:end); % échantillonnage au ryhtme Ts de rl_p0
rln_p1 = rl_p1(Fse:Fse:end); % échantillonnage au ryhtme Ts de rl_p1

for i=1:1:Nb
    if rln_p1(i) <= rln_p0(i) 
        bk(i) = 0;
    else
        bk(i) = 1;   
    end
end

end

