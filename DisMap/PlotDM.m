function PlotDM(folder_path)
	load([folder_path, 'dm_win_5_ss_15']);
	fig = figure;
	title('Disparity Map, Window: 5')

	subplot(2,3,1)
	imshow(uint8(disparity_map)*16);
	title('Search Space: 15 | Sum of Abs Diffs')

	subplot(2,3,2)
	imshow(uint8(disparity_map_sq)*16);
	title('Search Space: 15 | Sum of Sq Diffs')

	subplot(2,3,3)
	imshow(uint8(disparity_map_cc)*16);
	title('Search Space: 15 | Sum of Norm Cross Corr')
	
	load([folder_path, 'dm_win_5_ss_20']);

	subplot(2,3,4)
	imshow(uint8(disparity_map)*16);
	title('Search Space: 20 | Sum of Abs Diffs')

	subplot(2,3,5)
	imshow(uint8(disparity_map_sq)*16);
	title('Search Space: 20 | Sum of Sq Diffs')

	subplot(2,3,6)
	imshow(uint8(disparity_map_cc)*16);
	title('Search Space: 20 | Sum of Norm Cross Corr')	

	saveas(fig, [folder_path, 'res.png']);
end


