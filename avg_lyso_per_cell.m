function [ lyso_in_cell_data ] = avg_lyso_per_cell( clean_lyso_img, clean_cellmask_img )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here



[~, ~, num_lyso] = collect_data(clean_lyso_img, 'hi');


%Grab a single cell size (If possible, otherwise use a hardcoded value)
single_cell_size = 11463; %From "testPics/sample2/4.jpg"

%Calculate the area of the cellmask- trickiest part

    %Maybe count darker spots as overlaps so double area on these?
    %Area is calculated by multiplying local intensity by percieved area

labeled = logical(clean_cellmask_img);
cellmask_data = regionprops(labeled,'Area','Centroid','BoundingBox');

total_cellmask_area = sum(cat(1, cellmask_data.Area)); 
num_cells = total_cellmask_area / single_cell_size;
num_lyso_per_cell = num_lyso / num_cells;

lyso_in_cell_data = [total_cellmask_area, num_cells, num_lyso_per_cell];

end

