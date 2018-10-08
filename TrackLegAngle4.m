%Written on 2017/03/15. For the .avi files saved by the Basler camera. Go
%through the video file for all frames, except for the last 0.25 second.
%
%Written on 2017/01/03. For the new camera. Because there are many frames,
%don't show the images on the screen. I think that should reduce the time.
%Also, the file extension is now .tiff instead of .tif. Also don't save the
%video inorder to save space. Also needs to sort out the file names
%correctly.
%
%Written on 2016/12/12. Just have centroid (x,y) as the third and fourth column.
%Stop using StartN and EndN, it seems to just go through all of them.
%
%Written on 2016/03/24. Similar to the first version, but now it uses the
%background subtraction. Probably need another script to decide the
%threshold because we need the background and subtract it before deciding
%the threshold. (It will be some negative value).
%
%written on 2016/03/02, loosely based on TrackAntennaAngle6 and the others
%before that. This version will be the simplest possible, just take a
%threshold and find the orientation for the image above the threshold.
%
%Make one addition to make a video of the masked images. Need to figure out
%how to overlay orientation later.


function []=TrackLegAngle4(InFile,Threshold)
%StartN and EndN specified which image to use. First few images are not
%good because it is used for automatically adjusting. Need to take that
%into cosideration. Either write a script that ignores them or skip them.

%Find the output file from DrawMaskAndBackground.
MaskFile=dir('*DrawMaskAndBackground.mat');
load(MaskFile(1).name);

%Specify the video file
ExampleVid=VideoReader(InFile);

%Looks like the duration is not that accurate. However, we shouldn't need
%to read till the end. Take 1 second less and see if it is enough. We
%specify the reply frame rate of 50 fps, so this corresponds to only
%50/200 of a second in real time.

FramesToRead=floor((ExampleVid.Duration-1)*ExampleVid.FrameRate);
LegAngleArea=zeros(FramesToRead,4);

k=1;
while k<=FramesToRead
    vidFrame=readFrame(ExampleVid);
    %Just chose the regions selected in the previous MaskRegion and
    %subtract the Background from them. This may not be necessary.
    MaskedBGImage=double(vidFrame).*MaskRegion-BackgroundAll;

    Mask=MaskedBGImage<Threshold;
    
    TestRegion=regionprops(Mask,'orientation','area','centroid');
    %This will give a structure with many rows, find the one with the
    %largest area and use its orientation for now. We could have many
    %different algorithms for chosing which orientation to use, but for now
    %we just select the biggest area.
    allArea=[TestRegion.Area];%Concatinate all the area information.
    [MaxArea, Index]=max(allArea);
    LegAngleArea(k,1)=TestRegion(Index).Orientation;
    LegAngleArea(k,2)=MaxArea;
    LegAngleArea(k,3)=TestRegion(Index).Centroid(1);
    LegAngleArea(k,4)=TestRegion(Index).Centroid(2);
    
    k=k+1;
end


position=strfind(InFile,'.'); %gives the position of the period in the string FileName
NewName=InFile(1:position-1); %string NewName has the file name without the ".tiff".
Outfile=strcat(NewName,'TrackLegAngle4');

save(Outfile,'Threshold','LegAngleArea');

clear