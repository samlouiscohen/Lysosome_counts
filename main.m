%Hardcoded directory and image format for now
sdirectory = 'lyso_pics';%'testImgs';


img_files = dir([sdirectory '/*.jpg']);

full_set_values(1000) = struct('Area',[],'x',[],'y',[]);
count = 1;

%Loop through each image in the user-supplied folder
for i=1:length(img_files)
    
    %Grab the file name
    filename = [sdirectory '/' img_files(i).name];
    %Load its image
    img = imread(filename);
    %Inverse it for these specific ones (we want black as background)
%     img = imcomplement(img);
    
    
    %Function to do a generic cleaning of the image
    cleaned_img = clean_img(img);
%     show(cleaned_img,'cleaned_img');
    
    %Function to collect information & store it in the struct-array
    % Set of values is for a given image ->to be added to total
    [labeled_img, set_of_values, num] = collect_data(cleaned_img);

    full_set_values(count:count+num-1) = set_of_values(1:num);
    %Update count for next iteration
    count = count+num;
    
    %Function to display each image with its labels /Use overlay features
%     full_display(labeled_img, img);
    
    %Something to calculate cell areas, ect. like I already have
    %Should all be one program, prompts user for input of file locations
    %and runs from there
    
end












%Side notes and code:

%Box marking
    % figure
    % hold on
    % imshow(clean)
    % for object = 1 : length(pink_data)
    %     bb = pink_data(object).BoundingBox;
    %     rectangle('Position',bb,'EdgeColor','b','LineWidth',2)
    % end
    % hold off
    
%Overlay tools
    %bwperim, imoverlay


