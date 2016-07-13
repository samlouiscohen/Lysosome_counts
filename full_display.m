function full_display( labeled_img, img )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
figure;
imshow(img)
hold on
for k = 1:numel(labeled_img)
    c = labeled_img(k).Centroid;
    text(c(1), c(2), sprintf('%d', k), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle','color','b');
end
hold off





end

