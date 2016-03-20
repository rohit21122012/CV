echo "VanPt('rail/', 'rail.jpg')" | nohup matlab2013 -nodesktop -singleCompThread > rail/out.txt &
echo "VanPt('house/', 'house.jpg')" | nohup matlab2013 -nodesktop -singleCompThread > house/out.txt &
echo "VanPt('grill/', 'rail.jpg')" | nohup matlab2013 -nodesktop -singleCompThread > grill/out.txt &


#echo "DisparityMap('pair1/','pair1/scene_l.ppm', 'pair1/scene_r.ppm', 5, 15)" | nohup matlab2013 -nodesktop -singleCompThread > pair1/out15.txt &
