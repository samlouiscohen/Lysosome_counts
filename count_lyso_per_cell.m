function [ cell_data ] = count_lyso_per_cell( clean_lyso_img, clean_cellmask_img, img_full )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

cell_data(100) = struct('Area',[],'Centroid',[],'BoundingBox',[],'numLyso',[]);

%Process on cellmask

stats = regionprops(clean_cellmask_img);    % Find statistics of dots (centroid, area, bounding box)
redCentroids = reshape([stats(:).Centroid], 2, []).';   % Put centroids in format for pdist2

%Procedure for lysosomes

stats2 = regionprops(clean_lyso_img);
blackCentroids = reshape([stats2(:).Centroid], 2, []).';

distMatrix = pdist2(redCentroids, blackCentroids);
radius = 38;                   % found from stats.BoundingBox
connectedDots = distMatrix < radius;


%Use sum(connectedDots,2) to sum across each row- giving you number of black dots in
%each red dot

answer = sum(connectedDots,2);

num_cells = length(stats);

for i=1:num_cells
    cell_data(i).Area = stats(i).Area;
    cell_data(i).Centroid = stats(i).Centroid;
    cell_data(i).BoundingBox = stats(i).BoundingBox;
    cell_data(i).numLyso = answer(i);
end

figure;
imshow(img_full)
hold on
for k = 1:num_cells
    c = cell_data(k).Centroid;
    text(c(1), c(2), sprintf('%d', cell_data(k).numLyso), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle','color','y');
end
hold off



























end

