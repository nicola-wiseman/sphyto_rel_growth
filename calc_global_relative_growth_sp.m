%% Calculate global relative growth rate for small phytoplankton
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
PAR_avg = cell2mat(out(17));
x = cell2mat(out(18));
y = cell2mat(out(19));
clear out
load('woa_grid.mat','grid','M3d')

popx=360;
popy=180;
nx=360;
ny=180;
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
fig.YTickLabel = {'90\circS','45\circS','0\circ','45\circN','90\circN'};
fig.XTick = [0, 90, 180, 270, 360];
fig.XTickLabel = {};
fig.XGrid = 'on';
fig.YGrid = 'on';
fig.GridLineStyle = '--';
fig.GridAlpha = 0.5;
fig.Color = [0.9 0.9 0.9];

writematrix(sp_lim,'data/CESM_1.98_smallphyto_rel_growth.csv')


%% for actual growth rate calculations
% Tref = 30.0;
% Q_10 = 1.7;
% T0_kelv = 273.15;
% popx=360;
% popy=180;
% nx=360;
% ny=180;
% u_ref = 5.0; %maximum c-spec. growth rate
% espTinv = 3.17e-8;
% espC = 1.00e-8;
% 
% Tfunc = Q_10.^(((TEMP+T0_kelv)-(Tref+T0_kelv))/10);
% u_temp = u_ref.*Tfunc;
% 
% thetaC = sp_Chl./(sp_C + epsC);
% light_lim = 1-exp((1-alphaPI*thetaC*PAR_avg)/(u_temp*espTinv));
% 
% u_max = u_temp.*light_lim;
% 
% %u_rel = u_max.*sp_lim;