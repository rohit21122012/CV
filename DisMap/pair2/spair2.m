clc;
clear all;
close all;

im1 = round(255*rand(200,200));

disp = 5*ones(200,200);
disp(51:150,51:150) = 10;

im2 = zeros(200,200);
for i = 1:200
    for j = 1:200
        if j-disp(i,j) > 0
            im2(i,j) = im1(i,j-disp(i,j)); 
        end
    end
end
im2(:,1:5) = round(255*rand(200,5)); 
fig = figure('visible', 'off')
imshow(im1,[])
saveas(fig,'scene_l.png')
imshow(im2,[])
saveas(fig,'scene_r.png')
