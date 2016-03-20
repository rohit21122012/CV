rgb_van = imread('rail.jpg');
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
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');
    % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','white');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','white');
    % Determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    % Get the equation of the line
    x1 = xy(1,1);
    y1 = xy(1,2);
    x2 = xy(2,1);
    y2 = xy(2,2);
    slope = (y2-y1)/(x2-x1);
    xLeft = 1; % x is on the left edge
    yLeft = slope * (xLeft - x1) + y1;
    xRight = size(gray_van,2); % x is on the reight edge.
    yRight = slope * (xRight - x1) + y1;
    x(:,k) = [xLeft; xRight];
    y(:,k) = [yLeft; yRight];
% plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color','green');
% % Plot original points on the lines .
% plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
% plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end

[xi,yi] = polyxpoly(x(:,1), y(:,1), x(:,2), y(:,2))
plot(xi, yi,'x','LineWidth',20,'Color','green');
x(1,:) = -1000;
x(2,:) = 1000;
[xi,yi] = polyxpoly(x(:,1), y(:,1), x(:,2), y(:,2))
plot(xi, yi,'x','LineWidth',20,'Color','purple');