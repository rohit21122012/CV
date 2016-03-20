#echo "DisparityMap('pair1/', 'pair1/scene_l.ppm', 'pair1/scene_r.ppm', 5, 20)" | nohup matlab2013 -nodesktop -singleCompThread > pair1/out20.txt &
#echo "DisparityMap('pair1/','pair1/scene_l.ppm', 'pair1/scene_r.ppm', 5, 15)" | nohup matlab2013 -nodesktop -singleCompThread > pair1/out15.txt &
echo "DisparityMap('pair2/','pair2/scene_l.png', 'pair2/scene_r.png', 5, 20)" | nohup matlab2013 -nodesktop -singleCompThread > pair2/out20.txt 2>pair2/err20.txt &
#echo "DisparityMap('pair2/','pair2/scene_l.png', 'pair2/scene_r.png', 5, 15)" | nohup matlab2013 -nodesktop -singleCompThread > pair2/out15.txt &
# echo "DisparityMap('pair3/','pair3/im_l.png', 'pair3/im_r.png', 5, 20)" | nohup matlab2013 -nodesktop -singleCompThread > pair3/out20.txt &
# echo "DisparityMap('pair3/','pair3/im_l.png', 'pair3/im_r.png', 5, 15)" | nohup matlab2013 -nodesktop -singleCompThread > pair3/out15.txt &
