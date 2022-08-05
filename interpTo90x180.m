function [out] =interpTo90x180(lon,lat,o2,method)
% this function can interpolate irregular CMIP5 models to
% [out]=interpTo360x180(lon,lat,o2,method)
% regular 1 degree x 1 degree grid
% lon and lat are model coordinate if 2D, must equal the size
% of o2, o2 could be 3D or 2D, the last dimensions are the
% same as specified in lon and lat
% method can be 'nearest' or 'FT'
% Detailed explanation goes here
% out is struct containing X, Y and interperlated matrix (m)
% out.x out.y, out.m


%% method 1
if strcmp(method,'FT')

    %    [X,Y] = meshgrid(0:2:360,-90:2:90);
        [X,Y] = meshgrid(1:2:359,-89:2:89);
    %   [X,Y] = meshgrid(0.5:1:359.5,-89.5:1:89.5);
    %    [X,Y] = meshgrid(0.5:2:359.5,-89.5:2:89.5);
    out.x=X;out.y=Y;

    % squeeze o2 to get real dimensions
    o2=squeeze(o2);

    if ndims(o2) == 3
        %    temp=squeeze(o2(1,ind,:,:));
        %elseif ndims(o2) == 3
        %    temp=squeeze(o2(ind,:,:));
    else
        temp=squeeze(o2(:,:));
    end

    if size(lat,2)==1 | size(lat,1) == 1

        [X1,Y1] = meshgrid(wrapTo360(lon),lat);

        FT =scatteredInterpolant(X1(:), Y1(:), temp(:));

        out.m=FT(X,Y);
    else

        FT = scatteredInterpolant(wrapTo360(lon(:)),lat(:),temp(:));

        %index=find(isfinite(FT)==1);
        %mean=nansum(FT(index)*model.lat{ii}(index))/nansum(model.lat{ii}(index));

        out.m=FT(X,Y);
    end

    %get the mean of FT by accounting for latitude-dependence
end

%% method 2
if strcmp(method,'nearest')

    X=0.5:1:359.5; Y=-89.5:1:89.5;
    %X = 1:2:359; Y = -89:2:89; 
    out.x=X;out.y=Y;

     if ndims(o2) == 4
         temp=squeeze(o2(1,ind,:,:));
    elseif ndims(o2) == 3
        temp=squeeze(o2(ind,:,:));
    else
        temp=squeeze(o2(:,:));
    end

    for i=1:length(X)
        for j=1:length(Y)

            dist=abs(X(i)-wrapTo360(lon)) + abs(Y(j)-lat);

            dist_min=min(min(dist));

            [ix, jx]=find(dist==dist_min);

            out.m(j,i)=temp(min(ix),min(jx));

            %whos ix jx x;
            %temp(i,j) =x;
       end
   end
end

