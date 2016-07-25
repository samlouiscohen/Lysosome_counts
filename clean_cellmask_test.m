

lyso_filename = 'testPics/sample1/cellmask.jpg';
RGB = imread(lyso_filename);

I = rgb2gray(RGB);
show(I);

BW = im2bw(I,0.4);
show(BW,'BW');
idx = abs(im(:,:,1)-im(:,:,2))<=tresh & abs(im(:,:,2)-im(:,:,3))<=thresh;

% 
% 
% %Take structuring element of a disk of size 10, for the morphological transformations
% %Attempt to subtract the background from the image: top hat is the
% %subtraction of the open image from the original
% 
% 
% %Morphological transformation to subtract background noise from the image
% %Tophat is the subtraction of an opened image from the original. Remove all
% %images smaller than the structuring element of 10
% I1 = imtophat(I, strel('disk', 10));
% show(I1,'I1');
% %Increases contrast
% I2 = imadjust(I1);
% show(I2,'I2');
% 
% %Assume we have background and foreground and assess thresh as such 
% level = graythresh(I2);
% 
% %Convert to binary image based on graythreshold
% BW = im2bw(I2,level);
% show(BW,'C');
% BW = bwareaopen(BW,8);
% show(BW,'C2');
% %Complement because we want image to be black and background white
% C = ~BW;
% %Use distance tranform to find nearest nonzero values from every pixel
% D = -bwdist(C);
% 
% %Assign Minus infinity values to the values of C inside of the D image
% %   Modify the image so that the background pixels and the extended maxima
% %   pixels are forced to be the only local minima in the image (So you could
% %   hypothetically fill in water on the image
% % 
% % D(C) = -Inf;
% % 
% % %Gets 0 for all watershed lines and integers for each object (basins)
% % L = watershed(D);
% % show(L,'L');
% % %Takes the labels and converts to an RGB (Using hot colormap)
% % fin = label2rgb(L,'hot','w');
% % 
% % show(fin,'fin');
% % im = I;
% % 
% % %Superimpose ridgelines,L has all of them as 0 -> so mark these as 0(black)
% % im(L==0)=0;
% % 
% % 
% % show(im,'im');
% % 
% % 
% % 
% % 
% % 
% % [labeled,num] = bwlabel(L);
% % 
% % dextrin_data = regionprops(labeled,'Area','Centroid','BoundingBox');
% % 
% % %Remove full image label
% % dextrin_data = dextrin_data(2:end);
% % 
% % figure
% % hold on
% % imshow(RGB)
% % for object = 1 : length(dextrin_data)
% %     bb = dextrin_data(object).BoundingBox;
% %     rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
% % end
% % hold off
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
