echo "DisparityMap('pair1/', 'pair1/scene_l.ppm', 'pair1/scene_r.ppm',2, 64)" | nohup matlab2013 -nodesktop -singleCompThread > pair1/out64.txt &
echo "DisparityMap('pair1/','pair1/scene_l.ppm', 'pair1/scene_r.ppm',2, 32)" | nohup matlab2013 -nodesktop -singleCompThread > pair1/out32.txt &

echo "DisparityMap('pair2/','pair2/scene_l.png', 'pair2/scene_r.png',2,64)" | nohup matlab2013 -nodesktop -singleCompThread > pair2/out64.txt &
echo "DisparityMap('pair2/','pair2/scene_l.png', 'pair2/scene_r.png',2,32)" | nohup matlab2013 -nodesktop -singleCompThread > pair2/out32.txt &
echo "DisparityMap('pair3/','pair3/im_l.png', 'pair3/im_r.png',2,64)" | nohup matlab2013 -nodesktop -singleCompThread > pair3/out64.txt &
echo "DisparityMap('pair3/','pair3/im_l.png', 'pair3/im_r.png',2,32)" | nohup matlab2013 -nodesktop -singleCompThread > pair3/out32.txt &

