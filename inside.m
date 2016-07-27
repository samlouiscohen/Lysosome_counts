
cell_data(100) = struct('Area',[],'Centroid',[],'BoundingBox',[],'numLyso',[]);


% Get the statistics for redDots.jpg

img_full = imread('image_folder/folder_test/cellTest_full.png');
img = imread('image_folder/folder_test/cellBodyTest.jpg');   % You should really use a lossless image format like .png
gimg = rgb2gray(img);          % Convert to grayscale
bwimg = im2bw(gimg, .5);       % Convert to bw image (guessing at the threshold)
bwimg = ~bwimg;                % Invert the bw image so dots are white
stats = regionprops(bwimg);    % Find statistics of dots (centroid, area, bounding box)
redCentroids = reshape([stats(:).Centroid], 2, []).';   % Put centroids in format for pdist2

% Repeat the same basic procedure for blackDots.jpg
img2 = imread('image_folder/folder_test/cellTest.jpg');
bwimg2 = im2bw(img2, .5);      % blackDots.jpg is alread bw image
bwimg2 = ~bwimg2;
stats2 = regionprops(bwimg2);
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



