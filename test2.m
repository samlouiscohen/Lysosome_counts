lyso_filename = 'testPics/sample1/lyso.jpg';
RGB = imread(lyso_filename);
show(RGB,'Original');


I = rgb2gray(RGB);
I2 = imtophat(I, strel('disk', 10));

level = graythresh(I2);
BW = im2bw(I2,level);
show(BW,'BWdddddd');
BW = bwareaopen(BW,8);
show(BW,'BW2');

D = -bwdist(~BW);
show(D,'DDD');
D(~BW) = -Inf;
show(D)
L = watershed(D);
show(L,'fin');
L = im2bw(L,0.001);
show(L,'fin2');



[labeled,num] = bwlabel(L);

lyso_data = regionprops(labeled,'Area','Centroid','BoundingBox');

figure
hold on
imshow(RGB)
for object = 1 : length(lyso_data)
    bb = lyso_data(object).BoundingBox;
    rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
end
hold off







% 
% show(label2rgb(L,'jet','w'),'sumtin')
% 
% 
% L = watershed(imcomplement(I));
% show(L,'fin');
% 
% I2 = imcomplement(I);
% I3 = imhmin(I2,20); %20 is the height threshold for suppressing shallow minima
% L = watershed(I3);
% 
% show(L);
% fin = im2bw(L);
% show(fin,'fin');

% 
% figure
% hold on
% imshow(RGB)
% for object = 1 : length(lyso_data)
%     bb = lyso_data(object).BoundingBox;
%     rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
% end
% hold off
