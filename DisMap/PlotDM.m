function PlotDM(folder_path)
	load([folder_path, 'dm_win_2_ss_64']);
	fig = figure;
	title('Disparity Map, Window Size: 5x5')

	subplot(2,3,1)
	imshow(disparity_map,[]);
	title('Search Space: 15 | Sum of Abs Diffs')

	subplot(2,3,2)
	imshow(disparity_map_sq,[]);
	title('Search Space: 15 | Sum of Sq Diffs')

	subplot(2,3,3)
	imshow(disparity_map_cc,[]);
	title('Search Space: 15 | Sum of Corr')
	
 	load([folder_path, 'dm_win_2_ss_20']);
 
 	subplot(2,3,4)
 	imshow(disparity_map,[]);
 	title('Search Space: 20 | Sum of Abs Diffs')
 
 	subplot(2,3,5)
 	imshow(disparity_map_sq,[]);
 	title('Search Space: 20 | Sum of Sq Diffs')
 
 	subplot(2,3,6)
 	imshow(disparity_map_cc,[]);
 	title('Search Space: 20 | Sum of Corr')	

	saveas(fig, [folder_path, 'res.png']);
end


