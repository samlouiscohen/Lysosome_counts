






    %Grab the cell file name & load image
    cell_filename = 'image_folder/folder_test/cellBodyTest.jpg';
    cell_img = imread(cell_filename);
    cell_img = imcomplement(cell_img);
    %Clean the red image
%     cleaned_cell = clean_image(cell_img,(50/255),'N','N');
    cleaned_cell = im2bw(cell_img);
    show(cleaned_cell,'cleaned cell');
    %Collect & store cell data
    [cell_data, cell_values, cell_num] = collect_data(cleaned_cell);

    %Store struct array of cell centroids
    len_cell_data = length(cell_data);
    cell_centroids(len_cell_data) = struct('x',[],'y',[]);
    for i=1:len_cell_data
        cell_centroids(i).x = cell_data(i).Centroid(1);
        cell_centroids(i).y = cell_data(i).Centroid(2);
    end

    
    a = permute(cell_centroids,[2 1]);
    
%     hold on
%     show(cell_img,'Labeled to assess accuracy')
%     for object = 1 : length(cell_data)
%         bb = cell_data(object).BoundingBox;
%         rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
%     end
%     hold off



    %Grab the lyso file name & load image
    lyso_filename = 'image_folder/folder_test/cellTest.jpg';
    lyso_img = imread(lyso_filename);
    lyso_img = imcomplement(lyso_img);
    %Clean the red image
    cleaned_lyso = clean_image(lyso_img,(50/255),'N','N');
    show(cleaned_lyso,'cleaned lyso');
    %Collect & store lyso data
    [lyso_data, lyso_values, lyso_num] = collect_data(cleaned_lyso);
    
    %Store struct array of lysosome centroids
    len_lyso_data = length(lyso_data);
    lyso_centroids(len_lyso_data) = struct('x',[],'y',[]);
    for i=1:len_lyso_data
        lyso_centroids(i).x = lyso_data(i).Centroid(1);
        lyso_centroids(i).y = lyso_data(i).Centroid(2);
    end
     b = permute(lyso_centroids,[2 1]);

     
     
   %*******pdist2 on centroids of the circles and then use radii
  
   hello = pdist2(a,b);
   
   
%     hello = pdist2(lyso_data,cell_data);
%     
%     
%     
%     
%     
    
    
    
    
    
   
    
    
    
    
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
    
%     
%     hold on
%     show(lyso_img,'Labeled to assess accuracy')
%     for object = 1 : length(lyso_data)
%         bb = lyso_data(object).BoundingBox;
%         rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
%     end
%     hold off
%     
%     
%     
%     %Find lysosomes in EACH cell (either average or exact)
%     
%     
%     
%     
%     
%     
%     
%     
%     
%     
%     
%     
    
    
    
    
    
    