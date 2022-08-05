%% Plot nutrient limitation
close all;clearvars
filein = 'data/gdev1210_nut_lim_180x360.mat';
load(filein,'out')
out = struct2cell(out);
diatFe = cell2mat(out(1));
diatN = cell2mat(out(2));
diatP = cell2mat(out(3));
diatSi = cell2mat(out(4));
diatPar = cell2mat(out(5));
diatC = cell2mat(out(6));
TEMP = cell2mat(out(16));
PAR_avg = cell2mat(out(17));
x = cell2mat(out(18));
y = cell2mat(out(19));
clear out

load('data/woa_grid.mat','grid','M3d')

popx=360;
popy=180;
nx=360;
ny=180;

diat_lim = nan(180,360);
for i = 1:popy
    for j = 1:popx
        if (diatN(i,j) < diatFe(i,j)) && (diatN(i,j) < diatSi(i,j)) && (diatN(i,j) < diatP(i,j))
            diat_lim(i,j) = diatN(i,j);
        end
        % Fe limiting?
        if (diatFe(i,j) < diatN(i,j)) && (diatFe(i,j) < diatSi(i,j)) && (diatFe(i,j) < diatP(i,j))
            diat_lim(i,j)=diatFe(i,j);
        end
        % Si limiting?
        if (diatSi(i,j) < diatFe(i,j)) && (diatSi(i,j) < diatN(i,j)) && (diatSi(i,j) < diatP(i,j))
            diat_lim(i,j)=diatSi(i,j);
        end
        % P limiting?
        if (diatP(i,j) < diatN(i,j)) && (diatP(i,j) < diatFe(i,j)) && (diatP(i,j) < diatSi(i,j))
            diat_lim(i,j) = diatP(i,j);
        end         
    end
end

nanmask = M3d(:,:,1);
nanmask(nanmask == 0) = NaN;
diat_lim(:,:) = diat_lim(:,:).*nanmask;

figure(2)
set(gcf,'Position',[500 100 1000 500],'Color','white')
pcolor(x,y,diat_lim(:,:)); shading flat; colormap('turbo'); caxis([0 1]); colorbar
hold on
[~,c] = contour(grid.XT,grid.YT,M3d(:,:,1),[1 1],'k');
c.LineWidth = 2;
fig = gca;
fig.FontSize = 12;
fig.FontWeight = 'bold';
fig.TickDir = 'out';
fig.TickLength = [0.01 0.01];
fig.Layer = 'top';
fig.YTick = [-89.5, -45, 0, 45, 89.5];
fig.YTickLabel = {'90\circS','45\circS','0\circ','45\circN','90\circN'};
fig.XTick = [0, 90, 180, 270, 360];
fig.XTickLabel = {};
fig.XGrid = 'on';
fig.YGrid = 'on';
fig.GridLineStyle = '--';
fig.GridAlpha = 0.5;
fig.Color = [0.9 0.9 0.9];

writematrix(diat_lim,'data/CESM_1.98_diatom_rel_growth.csv')
