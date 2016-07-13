function [ img_data, set_of_values, num ] = collect_data( img )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% values(100) = struct('Area',[],'coord',[]);
set_of_values(100) = struct('Area',[],'x',[],'y',[]);

[img_labels, num] = bwlabel(img);

img_data = regionprops(img_labels,'Area','Centroid','BoundingBox');


for i=1:num
    lyso_pos = img_data(i).Centroid;
    
    set_of_values(i).x = lyso_pos(1);
    set_of_values(i).y = lyso_pos(2);
    set_of_values(i).Area = img_data(i).Area;

end


%Total area of a given img
% total_lysosome_area = sum(cat(1,lysosome_data.Area));

end

