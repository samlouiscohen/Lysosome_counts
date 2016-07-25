function [ clean_img ] = clean_dextrin( RGB_img )
%UNTITLED2 Summary of this function goes here
%   Watershed algorithm is useful for detecting objects that are touching
%   oneanother
%{

Algorthim:
- Convert to a grayscale image and interperate it as a topological surface
    f(x,y) corresponds to the height
- Looks for catchment basins and ridgelines to determine seperation

:'bwdist' on binary image to compute the distance transform
    (Matrix of distance from every pixel to nearest nozero-valued pixel

: L = watershed' on this image. 'Watershed' produces a labeled matrix image
that has positive integer values at different regions and 0 at ridgelines

**The idea is to transform the image so that its catchment basins are the
objects you want to identify 

:B = bwdist(~im) compute the distance tranform on the images complement

:C=-B Negate image to have the catchment basins as white spots

:L = watershed(C)







%}

%Convert to grayscale image
I = rgb2gray(RGB_img);

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
% show(BW,'C');
BW = bwareaopen(BW,8);
% show(BW,'C2');
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
% show(L,'L');
%Takes the labels and converts to an RGB (Using hot colormap)
fin = label2rgb(L,'hot','w');

% show(fin,'fin');
im = I;

%Superimpose ridgelines,L has all of them as 0 -> so mark these as 0(black)
im(L==0)=0;


% show(im,'im');


clean_img = L;


% 
% [labeled,num] = bwlabel(L);
% 
% dextrin_data = regionprops(labeled,'Area','Centroid','BoundingBox');
% 
% %Remove full image label
% dextrin_data = dextrin_data(2:end);
% 
% figure
% hold on
% imshow(RGB)
% for object = 1 : length(dextrin_data)
%     bb = dextrin_data(object).BoundingBox;
%     rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
% end
% hold off
% 
% 
% 
% 
% 







end




















