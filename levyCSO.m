  %https://www.mathworks.com/matlabcentral/fileexchange/29809-cuckoo-search--cs--algorithm
function [z] = levyCSO(n,m,beta)
            beta=3/2;
            sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);      
            u=randn(n,m)*sigma;
            v=randn(n,m);
            z=u./abs(v).^(1/beta);
       
end