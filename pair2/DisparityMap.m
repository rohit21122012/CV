	left = 'scene_l.png';
	right = 'scene_r.png';
% function DisparityMap(left, right, criteria)
% left is path of left image 
% right is path of right image
% criteria is intensity match criteria: 
% 	 i) Sum of absolute difference
% 	 ii)Sum of squared difference
% 	 iii) Normalized cross-correlation
	

	% search space is the number of pixel to be searched for the intensity for each pixel
	search_space = [15, 20];
	scale_factor = [16, 20];

	% read images from paths
	RGB_left = imread(left);
	RGB_right = imread(right);

	% convert images to grey scale
	RGB_left = rgb2gray(RGB_left);
	RGB_right = rgb2gray(RGB_right);




	% %initialize a disparity map of size same as one of the images
	disparity_map = zeros(size(RGB_left,1), size(RGB_left,2));
	% disparity_map_sq = zeros(size(RGB_left,1), size(RGB_left,2));
	% disparity_map_cc = zeros(size(RGB_left,1), size(RGB_left,2));


	w = search_space(1);	
	img_size = size(RGB_left);
	new_left = zeros(2*w+img_size(1), 2*w+img_size(2));
	new_right = zeros(2*w+img_size(1), 2*w+img_size(2));
	new_left(w+1:end-w,w+1:end-w) = RGB_left;
	new_right(w+1:end-w,w+1:end-w) = RGB_right;


	%Outer loop iterates over the row of left image
	for i=w+1:img_size(1)
		%This loop iterates over the columns in the ith row of the left image
		for j=w+1:img_size(2)
			cost = [];
			% cost_sq = [];
			% cost_cc = [];
			for jr=j:img_size(2)
				% left_win = zeros(2*w+1,2*w+1);
				% right_win = zeros(2*w+1, 2*w+1);
				
				left_win = new_left(i-w:i+w,j-w:j+w);			
				
				right_win = new_right(i-w:i+w,jr-w:jr+w);
				% for k=-w:w 
				% 	for l=-w:w
				% 		if((i+k>=1 && i+k<=size(RGB_left,1)) && (j+l>=1 && j+l<=size(RGB_left,2)))
				% 			left_win(k + w + 1,l + w + 1) = RGB_left(i+k, j+l);
				% 		end
				% 		if((i+k>=1 && i+k<=size(RGB_right,1)) && (j+l+jr>=1 && j+l+jr<=size(RGB_right,2)))
				% 			right_win(k + w + 1,l + w + 1) = RGB_right(i+k, j+l+jr);
				% 		end
				% 	end
				% end
				cost  = [cost, sum(sum(abs(left_win - right_win)))];
				% cost = [cost, ];
				% cost_sq = [cost_sq, sum(sum((left_win - right_win)^2))];
				%
				% cost_cc = [cost_cc, sum(sum(normxcorr2(left_win,right_win)))];
				
			end	

			[min_cost, min_cost_idx] = min(cost);
			% [min_cost_sq, min_cost_sq_idx] = min(cost_sq);
			% [min_cost_cc, min_cost_cc_idx] = min(cost_cc);
			% %This iterates over the search space in the right image 
			% for x=1:search_space(1)

			% 	%Boundary condition for pixels which have search space outside out of bounds of right image 
			% 	if((i+x-1) < size(RGB_right,2))

			% 		%criteria 1
			% 		if(criteria == 1)
			% 			intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
						
			% 		%criteria 2
			% 		elseif (criteria == 2)
			% 			intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
					
				
			% 		%criteria 3
			% 		elseif (criteria == 3) 
			% 			intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
					
			% 		end
				
			% 	end
			% end

			%Getting the min intensity pixel in the right image
			% [min_intensity_diff, disparity] = min(intensity_diff);

			%The disparity is the distance between the current pixel in l  and the best match pixel in
			%the right image (distance, in pixels, is the index of the intensity diff vector)
			disparity_map(i-w,j-w) = min_cost_idx;
			% disparity_map_sq(i-w,j-w) = min_cost_sq_idx;
			% disparity_map_cc(i-w,j-w) = min_cost_cc_idx;
		end
		disp([num2str(i),' row']);
	end

	save('dis2')

	w = search_space(2);	
	img_size = size(RGB_left);
	new_left = zeros(2*w+img_size(1), 2*w+img_size(2));
	new_right = zeros(2*w+img_size(1), 2*w+img_size(2));
	new_left(w+1:end-w,w+1:end-w) = RGB_left;
	new_right(w+1:end-w,w+1:end-w) = RGB_right;


	%Outer loop iterates over the row of left image
	for i=w+1:w+img_size(1)
		%This loop iterates over the columns in the ith row of the left image
		for j=w+1:w+img_size(2)
			cost = [];
			cost_sq = [];
			cost_cc = [];
			for jr=j:img_size(2)
				% left_win = zeros(2*w+1,2*w+1);
				% right_win = zeros(2*w+1, 2*w+1);
				
				left_win = new_left(i-w:i+w,j-w:j+w);			
				
				right_win = new_right(i-w:i+w,jr-w:jr+w);
				% for k=-w:w 
				% 	for l=-w:w
				% 		if((i+k>=1 && i+k<=size(RGB_left,1)) && (j+l>=1 && j+l<=size(RGB_left,2)))
				% 			left_win(k + w + 1,l + w + 1) = RGB_left(i+k, j+l);
				% 		end
				% 		if((i+k>=1 && i+k<=size(RGB_right,1)) && (j+l+jr>=1 && j+l+jr<=size(RGB_right,2)))
				% 			right_win(k + w + 1,l + w + 1) = RGB_right(i+k, j+l+jr);
				% 		end
				% 	end
				% end
				cost  = [cost, sum(sum(abs(left_win - right_win)))];
				% cost = [cost, ];
				% cost_sq = [cost_sq, sum(sum((left_win - right_win)^2))];
				%
				% cost_cc = [cost_cc, sum(sum(normxcorr2(left_win,right_win)))];
				
			end	

			[min_cost, min_cost_idx] = min(cost);
			% [min_cost_sq, min_cost_sq_idx] = min(cost_sq);
			% [min_cost_cc, min_cost_cc_idx] = min(cost_cc);
			% %This iterates over the search space in the right image 
			% for x=1:search_space(1)

			% 	%Boundary condition for pixels which have search space outside out of bounds of right image 
			% 	if((i+x-1) < size(RGB_right,2))

			% 		%criteria 1
			% 		if(criteria == 1)
			% 			intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
						
			% 		%criteria 2
			% 		elseif (criteria == 2)
			% 			intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
					
				
			% 		%criteria 3
			% 		elseif (criteria == 3) 
			% 			intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
					
			% 		end
				
			% 	end
			% end

			%Getting the min intensity pixel in the right image
			% [min_intensity_diff, disparity] = min(intensity_diff);

			%The disparity is the distance between the current pixel in l  and the best match pixel in
			%the right image (distance, in pixels, is the index of the intensity diff vector)
			disparity_map(i-w,j-w) = min_cost_idx;
			% disparity_map_sq(i-w,j-w) = min_cost_sq_idx;
			% disparity_map_cc(i-w,j-w) = min_cost_cc_idx;
		end
		disp([num2str(i),' row']);
	end

	save('dis2')

	%Showing the disparity man by scaling it to the scale factor
	hold on;
	axis off;
	subplot(2,2,1)
	imshow(RGB_left)
	subplot(2,2,2)
	imshow(RGB_right)
	subplot(2,2,3)
	imshow(disparity_map*scale_factor(1))
	subplot(2,2,4)
	imshow(disparity_map*scale_factor(2))

	% %Outer loop iterates over the row of left image
	% for i=1:size(RGB_left,1)
	% 	%This loop iterates over the columns in the ith row of the left image
	% 	for j=1:size(RGB_left,2)
	% 		intensity_diff = [];

	% 		%This iterates over the search space in the right image 
	% 		for x=1:search_space(2)

	% 			%Boundary condition for pixels which have search space outside out of bounds of right image 
	% 			if((i+x-1) < size(RGB_right,2))

	% 				%criteria 1
	% 				if(strcmp(criteria, 'abs'))
	% 					intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
						
	% 				%criteria 2
	% 				elseif (strcmp(criteria,'sq'))
	% 					intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
					
				
	% 				%criteria 3
	% 				elseif (strcmp(criteria,'norm') 
	% 					intensity_diff = [intensity_diff, abs(RGB_left(i,j) - RGB_right(i,j+x-1))];
					
	% 				end
				
	% 			end
	% 		end

	% 		%Getting the min intensity pixel in the right image
	% 		[min_intensity_diff, disparity] = min(intensity_diff);

	% 		%The disparity is the distance between the current pixel in l  and the best match pixel in
	% 		%the right image (distance, in pixels, is the index of the intensity diff vector)
	% 		disparity_map(i,j) = disparity;
	% 	end
	% end

	% subplot(2,3,5)
	% imshow(disparity_map*scale_factor(2))
	% subplot(2,3,6)
	% imshow(disparity_map*scale_factor(2))

	% saveas(gcf, criteria)
% end