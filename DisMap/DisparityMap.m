function DisparityMap(folder_path, left, right, w, ss)

% function DisparityMap(left, right, criteria)
% left is path of left image 
% right is path of right image
% criteria is intensity match criteria: 
% 	 i) Sum of absolute difference
% 	 ii)Sum of squared difference
% 	 iii) Normalized cross-correlation
% search space is the number of pixel to be searched for the intensity for each pixel
		

	
	% read images from paths
	%swaping left and right  because left image sees the right part
	RGB_left = imread(right);
	RGB_right = imread(left);

	% convert images to grey scale
	gray_left = rgb2gray(RGB_left);
	gray_right = rgb2gray(RGB_right);




	% %initialize a disparity map of size same as one of the images
	disparity_map = zeros(size(gray_left,1), size(gray_left,2));
	disparity_map_sq = zeros(size(gray_left,1), size(gray_left,2));
	disparity_map_cc = zeros(size(gray_left,1), size(gray_left,2));
	
	% window for the pixel
	w = 1;	

	img_size = size(gray_left);
	new_left = zeros(2*w+img_size(1), 2*w+img_size(2));
	new_right = zeros(2*w+img_size(1), 2*w+img_size(2));
	new_left(w+1:end-w,w+1:end-w) = gray_left;
	new_right(w+1:end-w,w+1:end-w) = gray_right;


	%Outer loop iterates over the row of right image
	for i=w+1:w+img_size(1)
		%This loop iterates over the columns in the ith row of the right image
		for j=w+1:w+img_size(2)
			
			
			right_dist = min(j+ss, w+img_size(2)); 
			cost = zeros(1,right_dist-j+1);
			cost_sq = zeros(1,right_dist-j+1);
			cost_cc = zeros(1,right_dist-j+1);
			

			for jr=j:right_dist
			
				left_win = new_left(i-w:i+w,j-w:j+w);			
				
				right_win = new_right(i-w:i+w,jr-w:jr+w);
				
				%absolute criteria
				cost(jr-j+1)  = sum(sum(abs(left_win - right_win)));
			
				%square criteria
				cost_sq(jr-j+1)  = sum(sum((left_win - right_win).^2));

				%normalized cross-correlation criteria
				cost_cc(jr-j+1)  = sum(sum(corr(left_win,right_win)));
			end	

			[min_cost, min_cost_idx] = min(cost);
			[min_cost_sq, min_cost_sq_idx] = min(cost_sq);
			[max_cost_cc, max_cost_cc_idx] = max(cost_cc);

			%The disparity is the distance between the current pixel in right image  and the best match pixel in
			%the left image (distance is the index of the intensity diff vector (in pixels))
			disparity_map(i-w,j-w) = min_cost_idx;
			disparity_map_sq(i-w,j-w) = min_cost_sq_idx;
			disparity_map_cc(i-w,j-w) = max_cost_cc_idx;
		end
		disp(['Row :', num2str(i)]);
	end

	%Saving the result for plotting
	save([folder_path, 'dm_win_', num2str(w), '_ss_', num2str(ss)]);

% 	hold on;
% 	axis off;
% 	subplot(2,2,1)
% 	imshow(RGB_left)
% 	subplot(2,2,2)
% 	imshow(RGB_right)
% 	subplot(2,2,3)
% 	imshow(disparity_map*scale_factor(1))
% 	subplot(2,2,4)
% 	imshow(disparity_map*scale_factor(2))
% subplot(2,3,5)
% imshow(disparity_map*scale_factor(2))
% subplot(2,3,6)
% imshow(disparity_map*scale_factor(2))

% saveas(gcf, criteria)

