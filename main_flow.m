%Folder/image format: 
%   - x folders, each containing 4 images relating to one cell (
%   - 4 images in order: Full, Lysosomes, Dextrin, cellmask
%
%Tasks: 
%   - Store Lysosome data in array(both area and 2D coordinates)
%   - Calculate a ratio of areas between pink lysosomes and blue Dextrin
%   - Count the number of apparent lysosomes per cell
%--------------------------------------------------------------------------

%General storage & struct array markers
lyso_all_values(1000) = struct('Area',[],'x',[],'y',[],'folder_num',[]);
dex_all_values(1000) = struct('Area',[],'x',[],'y',[]);
cell_all_values(1000) = struct('Area',[],'x',[],'y',[],'numLyso',[]);
lyso_count = 1; dex_count = 1; cell_count = 1;

lysosome_dextrin_ratio(50) = struct('ratio',[],'folder_num',[]);

%Init some misc. variables
% lysoCount = 1;
lyso_dex_marker = 1;

numFolders = 6;
for x=1:numFolders



%               Loop here to go through sample`x`!
%Base directory (Start with one folder before running multiple)
image_folder_dir = ['testPics/sample' num2str(x)];

%List folder contents (all photos of particular cell)
image_files = dir([image_folder_dir '/*.jpg']); %Should convert to png


%Since we know its for, dont need to loop; instead just store the 4 images
cell_full_filename = [image_folder_dir '/' image_files(1).name];
lysosome_filename = [image_folder_dir '/' image_files(2).name];
dextrin_filename = [image_folder_dir '/' image_files(3).name];
cellmask_filename = [image_folder_dir '/' image_files(4).name];
%Read in here so no longer have to worry
cell_full_img = imread(cell_full_filename);
lysosome_img = imread(lysosome_filename);
dextrin_img = imread(dextrin_filename);
cellmask_img = imread(cellmask_filename);


%Clean up each photo

cell_full_clean = clean_fullcell(cell_full_img);
lysosome_clean = clean_lyso(lysosome_img);
dextrin_clean = clean_dextrin(dextrin_img);
% cellmask_clean = clean_cellmask(cell_body_img);


%Store the lysosome data in larger struct array
[lyso_data, lyso_values, lyso_num] = collect_data(lysosome_clean,x);
lyso_all_values(lyso_count:lyso_count+lyso_num-1) = lyso_values(1:lyso_num);
lyso_count = lyso_count + lyso_num;


%Get ratio of areas between -pink- lysosomes and dextrin
[pink_data,pink_values] = collect_data(cell_full_clean,x);
[dextrin_data,dextrin_values] = collect_data(dextrin_clean,x);

pink_area = sum(cat(1,pink_data.Area));
dextrin_area = sum(cat(1,dextrin_data.Area));

pd_ratio = pink_area/dextrin_area;

lysosome_dextrin_ratio(x).ratio = pd_ratio;
lysosome_dextrin_ratio(x).folder_num = x;




end















