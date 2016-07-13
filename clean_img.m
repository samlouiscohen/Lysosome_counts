function [ cleaned_img ] = clean_img( img )
%More work will be done with better access to Lysosome/cell images
%   Convert to binary image, Remove background noise, Segment if just touching

bw = im2bw(img,50/255);

% Join 'close' particles if they represent a larger body
conn_comps = bwdist(bw) <= 2;

% Removing small useless particles as background noise (bwareaopen)
cleaned_img = bwareaopen(conn_comps,2);

end

