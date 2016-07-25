function [ clean_img ] = clean_fullcell( RGB_img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


I = RGB_img(:,:,1);


%Take structuring element of a disk of size 10, for the morphological transformations
%Attempt to subtract the background from the image: top hat is the
%subtraction of the open image from the original


%Morphological transformation to subtract background noise from the image
%Tophat is the subtraction of an opened image from the original. Remove all
%images smaller than the structuring element of 10
I1 = imtophat(I, strel('disk', 10));

%Increases contrast
I2 = imadjust(I1);

%Assume we have background and foreground and assess thresh as such 
level = graythresh(I2);

%Convert to binary image based on graythreshold
BW = im2bw(I2,level);
BW = bwareaopen(BW,8);
%Complement because we want image to be black and background white
C = ~BW;
%Use distance tranform to find nearest nonzero values from every pixel
D = -bwdist(C);

%Assign Minus infinity values to the values of C inside of the D image
%   Modify the image so that the background pixels and the extended maxima
%   pixels are forced to be the only local minima in the image (So you could
%   hypothetically fill in water on the image

D(C) = -Inf;

%Gets 0 for all watershed lines and integers for each object (basins)
L = watershed(D);
%Takes the labels and converts to an RGB (Using hot colormap)
fin = label2rgb(L,'hot','w');

im = I;

%Superimpose ridgelines,L has all of them as 0 -> so mark these as 0(black)
im(L==0)=0;

clean_img = L;



% [pink_objs,num_pink] = bwlabel(L);
% pink_data = regionprops(pink_objs,'Area','Centroid','BoundingBox');
% %Remove full image label
% pink_data = pink_data(2:end);
% 
% 
% totalArea = sum(cat(1,pink_data.Area));
% 
% figure
% hold on
% imshow(RGB);
% for object = 1 : length(pink_data)
%     bb = pink_data(object).BoundingBox;
%     rectangle('Position',bb,'EdgeColor','y','LineWidth',2)
% end
% hold off



end

