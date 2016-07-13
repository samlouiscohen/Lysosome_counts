function show( img,title_name )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

figure;
switch nargin
    case 2
        imshow(img);title(title_name);
        
    case 1
        imshow(img);
    case 0
        disp('The SHOW function received 0 arguments.');
        



end

