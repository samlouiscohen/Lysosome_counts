function [ clean_img ] = clean_lyso( RGB_image )
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here


%http://www.mathworks.com/company/newsletters/articles/the-watershed-transform-strategies-for-image-segmentation.html

gray_img = rgb2gray(RGB_image);
tophat_filter = imtophat(gray_img, strel('disk', 10)); %Read into this

level = graythresh(tophat_filter);
BW = im2bw(tophat_filter,level);

bgn_remove = bwareaopen(BW,8); %remove background noise

D = -bwdist(~bgn_remove); %Read into this
D(~BW) = -Inf;
L = watershed(D);

clean_img = im2bw(L,0.001);








% [labeled,num] = bwlabel(L);
% 
% lyso_data = regionprops(labeled,'Area','Centroid','BoundingBox');
% 
% figure
% hold on
% imshow(RGB)
% for object = 1 : length(lyso_data)
%     bb = lyso_data(object).BoundingBox;
%     rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
% end
% hold off





end

