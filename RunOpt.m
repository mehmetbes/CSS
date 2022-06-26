close all
clear, clc
% format compact
% addpath('../BmFnks')
RunN =30;
IteN = 1000;
Dim=30
PopSize =40
%Select for Algorithm (Opt)
%CSS=1, CSS-LS=2, CSS-Levy=3, CSS-Hbrid=4
Opt = 3;
Fnc = 1;
[Fnk,FnkAd,xMin,xMax,Fnc,Dim] = ElectFnc(Fnc,Dim);
[OptAlg,OptAd] = ElectOpt(Opt);
fprintf('%s\n%s\n',OptAd,FnkAd)
fprintf('     RunN = %d\n',RunN)
fprintf('     IteN = %d\n',IteN)
fprintf('  PopSize = %d\n',PopSize)
fprintf('Dimension = %d\n\n',Dim)
xR = zeros(RunN,Dim);
yR = zeros(RunN,1);
Z = cell(1,RunN);
for run = 1 : RunN
    tic
    Z{run} = OptAlg(Fnk,xMin,xMax,IteN,PopSize,Dim);
    Z{run}.Sure = toc;
    fprintf('%d.Run\n',run)
    fprintf('Toplam Süre = %g sn\n',Z{run}.Sure)
    fprintf('Best Output = %e\n\n',Z{run}.yBest)
    xR(run,:) = Z{run}.xBest;
    yR(run) = Z{run}.yBest;
end
[yRWorst,iRWorst] = max(yR);
[yRBest,iRBest] = min(yR);
xRBest = xR(iRBest,:);
yROrt = mean(yR);
yRStd = std(yR,1);
fprintf('  Ort Output = %12e\n',yROrt)
fprintf('  Std Output = %12e\n',yRStd)
fprintf('Worst Output = %12e ( Run = %d )\n',yRWorst,iRWorst)
fprintf(' Best Output = %12e ( Run = %d )\n',yRBest,iRBest)