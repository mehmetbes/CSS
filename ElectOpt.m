function [OptAlg,OptAd] = ElectOpt(Opt)
    switch Opt
        case 1, OptAlg = str2func('Opt01Css');
            OptAd = 'Charged System Search Algorithm';
        case 2, OptAlg = str2func('Opt02Css');
            OptAd = 'Charged System Search Algorithm-LS';
        case 3, OptAlg = str2func('Opt03Css');
            OptAd = 'Proposed Charged System Search Algorithm-Levy';
        case 4, OptAlg = str2func('Opt04Css');
            OptAd = 'Proposed Charged System Search Algorithm-Hybrid';
    end
end