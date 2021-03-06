L = 100;%[20,50,100,250,500];
Edim = [2:1:10];
EdimX = [2:1:10];
EdimY = [1:1:5];
tau = 1;%[1:1:5];
lags = 1:1:20;

plotdata = zeros(length(L),length(Edim),length(tau));
plotdataEdims = zeros(length(EdimX),length(EdimY),2);

for lstep = 1:length(L),
    fprintf('============= L = %i ==\n',L(lstep));

    X = zeros(L(lstep),1);
    Y = X;
    X(1) = 0.4;
    Y(1) = 0.2;
    rx = 3.8;%3.1;%
    ry = 3.5;%3.9;%
    Bxy = 0.01;%0.2;%
    Byx = 0.2;%0.002;%

    for fstep = 1:(length(X)-1),
        X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
        Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
    end;

    for estepX = 1:length(EdimX),
        for estepY = 1:length(EdimY),
            plotdataEdims(estepX,estepY,1) = CCM(Y,X,EdimX(estepX),EdimY(estepY));
            plotdataEdims(estepX,estepY,2) = CCM(X,Y,EdimX(estepX),EdimY(estepY));
        end;
    end;

    diffMat = plotdataEdims(:,:,1)-plotdataEdims(:,:,2);
    plotdata(lstep,:,1) = diag(diffMat);
    plot(diag(diffMat),'.');
    imagesc(diffMat);
    title('\Delta v E_X, E_Y');
    xlabel('E_X');
    ylabel('E_Y');
    colorbar();
    diffMat

end;

plot(plotdata(3,:),'.');
title('\Delta vs E');
xlabel('E');
ylabel('\Delta')
grid on;

plot(Edim,plotdata(1,:),'.',Edim,plotdata(2,:),'o',...
     Edim,plotdata(3,:),'x',Edim,plotdata(4,:),'v',Edim,plotdata(3,:),'^');
title('\Delta vs E');
xlabel('E');
ylabel('\Delta')
grid on;
legend('L = 20','L = 50','L = 100','L = 250','L = 500');
