Images = dir ('C:\Users\hwlab\Desktop\1 mM - uncondensed - Images');
nImages = length (Images);
Trajectory = zeros(size(Images{1}));
  for i = 1:nImages
    Trajectory = Trajectory + Images{i};
  end
  Trajectory = min(Trajectory,1);
  imshow(Trajectory);