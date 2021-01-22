clc;clear;close all

imagefiles = dir('*.TIF');      
nfiles = length(imagefiles);    % Number of files found

for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage(:,:,ii) = imread(currentfilename);
end

a=uint8(mean(currentimage(:,:,1:20),3));
imshow(a)


