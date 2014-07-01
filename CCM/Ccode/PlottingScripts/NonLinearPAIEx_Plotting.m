load 'NonLinearPAIEx_DataRead_OutTemp.mat';

DiffYXXYYYX = CdataYYX-CdataXXY;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

subplot(2,2,1);
Cstep = 2;
cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,DiffYXXYYYX(:,:,Cstep));
set(gca,'YDir','normal');
hold on;
hCont = contour(Bv,Av,DiffYXXYYYX(:,:,Cstep),...
          [0 0],'r','LineWidth',2);

caxis([-0.01 -0.001]);
cbar = colorbar();
set(cbar,'Visible','off');

hXLabel = xlabel('B');
hYLabel = ylabel('A');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title(sprintf('C = %.2f;',Cv(Cstep)));
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);


for iter = 2:4,
    subplot(2,2,iter);
    Cstep = Cstep + 3;
    
    cmap = colormap(flipud(gray));
    hImage = imagesc(Bv,Av,DiffYXXYYYX(:,:,Cstep));
    set(gca,'YDir','normal');
    hold on;
    
    hCont = contour(Bv,Av,DiffYXXYYYX(:,:,Cstep),...
              [0 0],'r','LineWidth',2);
    
    if(iter ==2), 
        cbar = colorbar(); 
        hCLabel = title(cbar,'\Delta\prime');
    else
        cbar = colorbar();
        set(cbar,'Visible','off');
    end;
    caxis([-0.01 -0.001]);
    hXLabel = xlabel('B');
    hYLabel = ylabel('A');
    
    set([hXLabel, hYLabel],'FontName','Times');
    set([hXLabel, hYLabel],'FontSize', 10);

    hSubtitle = title(sprintf('C = %.2f;',Cv(Cstep)));
    set(hSubtitle,'FontName','Times');
    set(hSubtitle,'FontSize', 10);

end;

hold off;
print -depsc2 ../PlotOutTempDir/NonLinearPAIEx.eps
close;


