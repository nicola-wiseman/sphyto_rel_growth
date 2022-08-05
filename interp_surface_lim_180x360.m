%% Interp 180x360 lim data
close all;clearvars
addpath data/
filename = 'data/gdev1210.pop.h.0281_0300.nc';
fileout = 'data/gdev1210_nut_lim_180x360.mat';
tic

diat_Fe_lim = ncread(filename,'diat_Fe_lim');
diat_N_lim = ncread(filename,'diat_N_lim');
diat_P_lim = ncread(filename,'diat_P_lim');
diat_light_lim = ncread(filename,'diat_light_lim');
diat_SiO3_lim = ncread(filename,'diat_SiO3_lim');
diatC = ncread(filename,'diatC');
diaz_Fe_lim = ncread(filename,'diaz_Fe_lim');
diaz_P_lim = ncread(filename,'diaz_P_lim');
diaz_light_lim = ncread(filename,'diaz_light_lim');
diazC = ncread(filename,'diazC');
sp_Fe_lim = ncread(filename,'sp_Fe_lim');
sp_N_lim = ncread(filename,'sp_N_lim');
sp_P_lim = ncread(filename,'sp_P_lim');
sp_light_lim = ncread(filename,'sp_light_lim');
spC = ncread(filename,'spC');
TLAT = ncread(filename,'TLAT');
TLON = ncread(filename,'TLONG');
TEMP = ncread(filename,'TEMP');
TAREA = ncread(filename,'TAREA').*0.0001; % convert from cm2 to m2
PAR_avg = ncread(filename,'PAR_avg');
load woa_grid.mat

% small phyto
spN = sp_N_lim(:,:,1);
spN = interpTo90x180(TLON,TLAT,spN,'nearest');
spN.m(spN.m == 0) = NaN; % exclude inland seas
spN.m(M3d(:,:,1) == 0) = NaN; %exclude land

spFe = sp_Fe_lim(:,:,1);
spFe = interpTo90x180(TLON,TLAT,spFe,'nearest');
spFe.m(spN.m == 0) = NaN; % exclude inland seas
spFe.m(M3d(:,:,1) == 0) = NaN; %exclude land

spP = sp_P_lim(:,:,1);
spP = interpTo90x180(TLON,TLAT,spP,'nearest');
spP.m(spP.m == 0) = NaN; % exclude inland seas
spP.m(M3d(:,:,1) == 0) = NaN; %exclude land

spPar = sp_light_lim(:,:,1);
spPar = interpTo90x180(TLON,TLAT,spPar,'nearest');
spPar.m(spPar.m == 0) = NaN; % exclude inland seas
spPar.m(M3d(:,:,1) == 0) = NaN; %exclude land

spC = spC(:,:,1);
spC = interpTo90x180(TLON,TLAT,spC,'nearest');
spC.m(spPar.m == 0) = NaN; % exclude inland seas
spC.m(M3d(:,:,1) == 0) = NaN; %exclude land

% Diatoms
diatN = diat_N_lim(:,:,1);
diatN = interpTo90x180(TLON,TLAT,diatN,'nearest');
diatN.m(diatN.m == 0) = NaN; % exclude inland seas
diatN.m(M3d(:,:,1) == 0) = NaN; %exclude land

diatFe = diat_Fe_lim(:,:,1);
diatFe = interpTo90x180(TLON,TLAT,diatFe,'nearest');
diatFe.m(diatFe.m == 0) = NaN; % exclude inland seas
diatFe.m(M3d(:,:,1) == 0) = NaN; %exclude land

diatP = diat_P_lim(:,:,1);
diatP = interpTo90x180(TLON,TLAT,diatP,'nearest');
diatP.m(diatP.m == 0) = NaN; % exclude inland seas
diatP.m(M3d(:,:,1) == 0) = NaN; %exclude land

diatSi = diat_SiO3_lim(:,:,1);
diatSi = interpTo90x180(TLON,TLAT,diatSi,'nearest');
diatSi.m(diatSi.m == 0) = NaN; % exclude inland seas
diatSi.m(M3d(:,:,1) == 0) = NaN; %exclude land

diatPar = diat_light_lim(:,:,1);
diatPar = interpTo90x180(TLON,TLAT,diatPar,'nearest');
diatPar.m(diatPar.m == 0) = NaN; % exclude inland seas
diatPar.m(M3d(:,:,1) == 0) = NaN; %exclude land

diatC = diatC(:,:,1);
diatC = interpTo90x180(TLON,TLAT,diatC,'nearest');
diatC.m(diatC.m == 0) = NaN; % exclude inland seas
diatC.m(M3d(:,:,1) == 0) = NaN; %exclude land

% Diazotrophs
diazFe = diaz_Fe_lim(:,:,1);
diazFe = interpTo90x180(TLON,TLAT,diazFe,'nearest');
diazFe.m(diazFe.m == 0) = NaN; % exclude inland seas
diazFe.m(M3d(:,:,1) == 0) = NaN; %exclude land

diazP = diaz_P_lim(:,:,1);
diazP = interpTo90x180(TLON,TLAT,diazP,'nearest');
diazP.m(diazP.m == 0) = NaN; % exclude inland seas
diazP.m(M3d(:,:,1) == 0) = NaN; %exclude land

diazPar = diaz_light_lim(:,:,1);
diazPar = interpTo90x180(TLON,TLAT,diazPar,'nearest');
diazPar.m(diazPar.m == 0) = NaN; % exclude inland seas
diazPar.m(M3d(:,:,1) == 0) = NaN; %exclude land

diazC = diazC(:,:,1);
diazC = interpTo90x180(TLON,TLAT,diazC,'nearest');
diazC.m(diazC.m == 0) = NaN; % exclude inland seas
diazC.m(M3d(:,:,1) == 0) = NaN; %exclude land0

TEMP = TEMP(:,:,1);
TEMP = interpTo90x180(TLON,TLAT,TEMP,'nearest');
%TEMP.m(TEMP.m == 0) = NaN; % exclude inland seas
TEMP.m(M3d(:,:,1) == 0) = NaN; %exclude land0

PAR_avg = PAR_avg(:,:,1);
PAR_avg = interpTo90x180(TLON,TLAT,PAR_avg,'nearest');
PAR_avg.m(PAR_avg.m == 0) = NaN; % exclude inland seas
PAR_avg.m(M3d(:,:,1) == 0) = NaN; %exclude land0

out.diatFe = diatFe.m;
out.diatN = diatN.m;
out.diatP = diatP.m;
out.diatSi = diatSi.m;
out.diatPar = diatPar.m;
out.diatC = diatC.m;
out.diazFe = diazFe.m;
out.diazP = diazP.m;
out.diazPar = diazPar.m;
out.diazC = diazC.m;
out.spN = spN.m;
out.spFe = spFe.m;
out.spP = spP.m;
out.spPar = spPar.m;
out.spC = spC.m;
out.TEMP = TEMP.m;
out.PAR_avg = PAR_avg.m;
out.x = diatFe.x;
out.y = diatFe.y;

save(fileout,'out')
toc