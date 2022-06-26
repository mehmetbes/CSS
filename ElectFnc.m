function [Fnk,FnkAd,xMin,xMax,Fnc,Dim] = ElectFnc(Fnc,Dim)
Fnk = str2func(['Fnk' num2str(Fnc,'%02d')]);
        FnkAd = 'Sphere Function (F1)';
        xMax = 100*ones(1,Dim);
        xMin = -xMax;
Dim = size(xMin,2);
end