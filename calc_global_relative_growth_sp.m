%% Plot nutrient limitation
close all;clearvars
filein = 'data/gdev1210_nut_lim_180x360.mat';
load(filein,'out')
out = struct2cell(out);
spN = cell2mat(out(11));
spFe = cell2mat(out(12));
spP = cell2mat(out(13));
spPar = cell2mat(out(14));
spC = cell2mat(out(15));
TEMP = cell2mat(out(16));
x = cell2mat(out(17));
y = cell2mat(out(18));
clear out

load('woa_grid.mat','grid','M3d')

popx=360;
popy=180;
nx=360;
ny=180;
Nreplete=0.9;
deglim=0.5;

col0=255; % l&& missing data
col1=1;   % nitrogen
col11=2;  % strong nitrogen
col2=3;  % iron
col22=4; % strong iron
col3=5;  % phosphorus
col33=6; % strong phosphorus
col4=7;  % silicon
col44=8;% strong silicon
col6=9; % replete
col7=10; % sst (for diazotrophs)
sp_lim = nan(180,360);
for i = 1:popy
    for j = 1:popx
        %% small phyto
        % N limiting?
        if (spN(i,j) < spFe(i,j)) && (spN(i,j) < spP(i,j))
            sp_lim(i,j)=spN(i,j);
        end
        % Fe limiting?
        if (spFe(i,j) < spN(i,j)) && (spFe(i,j) < spP(i,j))
            sp_lim(i,j)=spFe(i,j);
        end
        % P limiting?
        if (spP(i,j) < spN(i,j)) && (spP(i,j) < spFe(i,j))
            sp_lim(i,j)=spP(i,j);
        end            
    end
end

nanmask = M3d(:,:,1);
nanmask(nanmask == 0) = NaN;
sp_lim(:,:) = sp_lim(:,:).*nanmask;

figure(2)
set(gcf,'Position',[500 100 1000 500],'Color','white')
pcolor(x,y,sp_lim(:,:)); shading flat; colormap('turbo'); caxis([0 1]); colorbar
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
%fig.YTickLabel = {'90\circS','45\circS','0\circ','45\circN','90\circN'};
fig.YTickLabel = {};
fig.XTick = [0, 90, 180, 270, 360];
fig.XTickLabel = {};
fig.XGrid = 'on';
fig.YGrid = 'on';
fig.GridLineStyle = '--';
fig.GridAlpha = 0.5;
fig.Color = [0.9 0.9 0.9];

writematrix(sp_lim,'data/CESM_1.21_smallphyto_rel_growth.csv')
