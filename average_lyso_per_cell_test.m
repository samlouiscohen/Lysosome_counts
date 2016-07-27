%Grab the count of lysosomes

lyso_img = imread('testImgs/sample1/2_lyso.jpg');
lysosome_clean = clean_lyso(lyso_img);
[lyso_data, lyso_values, num_lyso] = collect_data(lysosome_clean, 'hi');

% figure
% hold on
% show(img,'original')
% for object = 1 : length(lyso_data)
%     bb = lyso_data(object).BoundingBox;
%     rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
% end
% hold off



%Grab a single cell size (If possible, otherwise use a hardcoded value)
single_cell_size = 11463; %From "testPics/sample2/4.jpg"

%Calculate the area of the cellmask- trickiest part

    %Maybe count darker spots as overlaps so double area on these?
    %Area is calculated by multiplying local intensity by percieved area
    
    
img = imread('testImgs/sample1/4_cellmask.jpg');
show(img,'orig');
bw = im2bw(img,0.1);
show(bw,'black&white');

bw2 = bwdist(bw) <= 2;
show(bw2,'joined');

bw3 = bwareaopen(bw2,500);
show(bw3,'small gone');
% bw3 = imclearborder(bw3);
% show(bw3,'boarder no more');


[labeled,num] = bwlabel(bw3);
cellmask_data = regionprops(labeled,'Area','Centroid','BoundingBox');


% B = bwboundaries(bw3);
% 
% imshow(img); hold on
% for k = 1 : length(B)
%     b = B{k};
%     c = cellmask_data(k).Centroid;
%     plot(b(:,2),b(:,1),'g','linewidth',2);
%     text(c(1),c(2),num2str(k),'backgroundcolor','g');
% end



total_cellmask_area = sum(cat(1, cellmask_data.Area)); 
  

num_cells = total_cellmask_area / single_cell_size;


num_lyso_per_cell = num_lyso / num_cells;
   
    
% figure
% hold on
% imshow(img)
% for object = 1 : length(cellmask_data)
%     bb = cellmask_data(object).BoundingBox;
%     rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
% end
% hold off


    
    
    
%Divide calculated area by lysosome count

%Return answer for the given frame