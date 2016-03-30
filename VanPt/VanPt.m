function VanPt(folder_path, fileName)

    fig = figure;

    %Reading the image
    rgb_van = imread([folder_path, fileName]);


    subplot(2,3,1);
    imshow(rgb_van);
    title('RGB Image');

    %Extracting the grayscale of the image
    subplot(2,3,2);
    gray_van = rgb2gray(rgb_van);
    imshow(gray_van);
    title('Gray Scaled Image');


    %Detecting edges using canny
    BW = edge(gray_van,'canny');
    subplot(2,3,3);
    imshow(BW)
    title('Edges using canny');

    %Doing hough transform to get rho and theta 
    [H,T,R] = hough(BW);
    subplot(2,3,4);
    imshow(imadjust(mat2gray(H)),'XData',T,'YData',R,...
          'InitialMagnification','fit');
    title('Hough transform');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal


    %Finding peaks in the hough transform (which indicate the lines)
    P = houghpeaks(H,8);
    %Getting the lines from the hough, peak, edge inputs
    lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',50);


    subplot(2,3,5);
    imshow(rgb_van);
    hold on;
    max_len = 0;
    %This plots the lines over the image
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','blue');
        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','white');
        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','white');
        % Determining the endpoints of the longest line segment
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
            max_len = len;
            xy_long = xy;
        end
    end
    % Highlighting the longest line segment
    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
    title('Hough Lines');

    %Extending the lines to x = -1000 and x = 1000
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        % Get the equation of the line
        x1 = xy(1,1);
        y1 = xy(1,2);
        x2 = xy(2,1);
        y2 = xy(2,2);
        slope = (y2-y1)/(x2-x1);
        xLeft = -1000; % x is on the left edge
        yLeft = slope * (xLeft - x1) + y1;
        xRight = 1000; % size(gray_van,2); % x is on the right edge.
        yRight = slope * (xRight - x1) + y1;
        x(:,k) = [xLeft; xRight];
        y(:,k) = [yLeft; yRight];
    end


    %Replotting the lines to show in the 6th subplot
    subplot(2,3,6);
    imshow(rgb_van);
    hold on;
    max_len = 0;
    %This plots the lines over the image
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','blue');
        % Determining the endpoints of the longest line segment
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
            max_len = len;
            xy_long = xy;
        end
    end

    %Finding intersection points 
    for k = 1:length(lines)
        for l = k+1:length(lines)
            angle = abs(lines(k).theta-lines(l).theta);
            disp(['a1:', num2str(lines(k).theta), ' a2:', num2str(lines(l).theta), ' diff:', num2str(angle)])
            %Plotting only those points which are intersections of lines having angles less than 60
            if(angle < 60)
                [xi,yi] = polyxpoly(x(:,k), y(:,k), x(:,l), y(:,l))
                plot(xi, yi,'x','LineWidth',2,'Color','red');    
            end
        end
    end
    title('Vanishing Points');

    %Saving the image
    saveas(fig, [folder_path, 'res.png'])
end    