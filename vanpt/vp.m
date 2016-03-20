rgb_van = imread('van.jpg');
gray_van = rgb2gray(rgb_van);
hough(gray_van);
BW = edge(gray_van,'canny');
[H,T,R] = hough(BW);

P = houghpeaks(H,8);
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',50);
figure
imshow(rgb_van)
hold on
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    % Determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');