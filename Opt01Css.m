function S = Opt07Css(Fnk,xMin,xMax,IteN,PopSize,Dim)
xPop = rand(PopSize,Dim);
yPop = zeros(PopSize,1);
for m = 1 : PopSize
    xPop(m,:) = xMin + ( xMax - xMin ) .* xPop(m,:);
    yPop(m) = Fnk(xPop(m,:));
end
vPop = zeros(PopSize,Dim);
[yPop, Sra] = sort(yPop);
xPop = xPop(Sra,:);
aki = 0.9;
akf = 0.1;
vki = 0.9;
vkf = 0.1;
epsi = 1e-6;
xBests = zeros(IteN,Dim);
yBests = zeros(IteN,1);
for Ite = 1 : IteN
    ak = aki + (akf-aki)*(Ite-1)/(IteN-1);
    vk = vki + (vkf-vki)*(Ite-1)/(IteN-1);
    fit = (linspace(1,0.5,PopSize)').^2;
    yuk = (fit-fit(PopSize))/(fit(1)-fit(PopSize));
    rr = zeros(PopSize);
    for i = 1 : PopSize
        for j = i+1 : PopSize
            rr(i,j) = norm(xPop(i,:)-xPop(j,:)) / ...
                ( norm(0.5*(xPop(i,:)+xPop(j,:))-xPop(1,:)) + epsi );
            rr(j,i) = rr(i,j);
        end
    end
    radius = 0.01*max(rr(:));
    pp = zeros(PopSize);
    for i = 1 : PopSize
        for j = 1 : PopSize
            if i ~= j
                if fit(j) > fit(i)
                    pp(i,j) = 1;
                elseif (fit(i)-fit(1))/(fit(j)-fit(i)) > rand
                    pp(i,j) = 1;
                end
            end
        end
    end
    aPop = zeros(PopSize,Dim);
    for j = 1 : PopSize
        for i = 1 : PopSize
            if pp(i,j) == 1
                if rr(i,j) < radius
                    Gec = yuk(i)*rr(i,j)/radius^3;
                else
                    Gec = yuk(i)/rr(i,j)^2;
                end
                aPop(j,:) = aPop(j,:) + Gec*(xPop(i,:)-xPop(j,:));
            end
        end
    end
    for m = 1 : PopSize
        vGec = vk*vPop(m,:).*rand(1,Dim) + ak*aPop(m,:).*rand(1,Dim);
        xGec = xPop(m,:) + vGec;
        xGec = min(max(xGec,xMin),xMax);
        yGec = Fnk(xGec);
        if yGec < yPop(m)
            yPop(m) = yGec;
            xPop(m,:) = xGec;
            vPop(m,:) = vGec;
        end
    end
    [yPop, Sra] = sort(yPop);
    xPop = xPop(Sra,:);
    vPop = vPop(Sra,:);
    xBest = xPop(1,:);
    yBest = yPop(1);
    xBests(Ite,:) = xBest;
    yBests(Ite) = yBest;
    
end
S = struct('x',xBests,'y',yBests,'xBest',xBest,'yBest',yBest);
end