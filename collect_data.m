function [ img_data, set_of_values, num ] = collect_data( img, folderNum )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

show(img,'Collect data on:');

% values(100) = struct('Area',[],'coord',[]);
set_of_values(1000) = struct('Area',[],'x',[],'y',[],'folder_num',[]);

[img_labels, num] = bwlabel(img);

img_data = regionprops(img_labels,'Area','Centroid','BoundingBox');

%Get rid of bouding box surrounding frame
img_data = img_data(2:end);
num = num-1;

for i=1:num
    lyso_pos = img_data(i).Centroid;
    
    set_of_values(i).x = lyso_pos(1);
    set_of_values(i).y = lyso_pos(2);
    set_of_values(i).Area = img_data(i).Area;
    set_of_values(i).folder_num = folderNum;

end



%Labeling so I can assess accuracy

hold on
show(img,'Labeled to assess accuracy')
for object = 1 : length(img_data)
    bb = img_data(object).BoundingBox;
    rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
end
hold off






%Run area comparisions






















%Total area of a given img
% total_lysosome_area = sum(cat(1,lysosome_data.Area));

end

