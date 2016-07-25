lyso_filename = 'testPics/sample1/1_fullcell.jpg';
RGB = imread(lyso_filename);
% 
% show(RGB);
% 
% % R = im2bw(RGB(:,:,1));
% x = rgb2hsv(RGB);
% show(x,'EYEYEYEY');
% show(x(:,:,1),'r');
% z = x(:,:,2);
% show(z,'g');
% p = x(:,:,3);
% show(p,'b');

% hsvImage = rgb2hsv(RGB);         %# Convert the image to HSV space
% hPane = 360*hsvImage(:,:,1);     %# Get the hue plane scaled from 0 to 360
% sPlane = hsvImage(:,:,2);          %# Get the saturation plane
% nonRedIndex = (hPlane > 10) & ...  %# Select "non-red" pixels
%               (hPlane < 240);
% sPlane(nonRedIndex) = 0;           %# Set the selected pixel saturations to 0
% hsvImage(:,:,2) = sPlane;          %# Update the saturation plane
% show(hsvImage,'final1');
% rgbImage = hsv2rgb(hsvImage);      %# Convert the image back to RGB space
% 
% show(rgbImage,'final2');
I = RGB(:,:,1);
% show(I);
% figure
% imagesc(I(:,:,1));




%--------------------------------------------------------------------------


% I = rgb2gray(R);

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
show(BW,'C');
BW = bwareaopen(BW,8);
show(BW,'C2');
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
show(L,'L');
%Takes the labels and converts to an RGB (Using hot colormap)
fin = label2rgb(L,'hot','w');

show(fin,'fin');
im = I;

%Superimpose ridgelines,L has all of them as 0 -> so mark these as 0(black)
im(L==0)=0;


show(im,'im');
% 
% 
% 
% 
% 
% 
% 
% 
% %--------------------------------------------------------------------------




% 
% X = clean_lyso(RGB);
% show(X);

[pink_objs,num_pink] = bwlabel(L);



pink_data = regionprops(pink_objs,'Area','Centroid','BoundingBox');
%Remove full image label
pink_data = pink_data(2:end);


totalArea = sum(cat(1,pink_data.Area));

figure
hold on
imshow(RGB);
for object = 1 : length(pink_data)
    bb = pink_data(object).BoundingBox;
    rectangle('Position',bb,'EdgeColor','y','LineWidth',2)
end
hold off