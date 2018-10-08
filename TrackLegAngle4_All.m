%Written on 2017/03/15. For running TrackLegAngle4 for all the .avi files
%in the directory. Actually, use TrialID to specify which ones to run.
%
%Written on 20170302. slightly different file names to track the linear
%motion. Also uses the 3rd version that specifies the direction of motion
%to get the correct background.
%
%Written on 2017/02/09. Just use the 2nd version of the mask. Everything
%else is the same. Also show time of progress.
%
%Written on 2017/02/08, based on TrackLegAngle3A_All, just runs
%TrackTibiaIntensity for all the appropriate folders.

function []=TrackLegAngle4_All()

%load the file to decide which trials to run the script.
TrialID=load('IDTrial.txt');
%Load the threshold
load('FindLegThreshold.mat');
%Find all the VideoFiles.
VideoFileName=dir('*.avi');
        
NofTrials=size(VideoFileName,1);

for n=1:NofTrials
    if TrialID(n)==1
        VideoFileName(n).name
        datetime
        TrackLegAngle4(VideoFileName(n).name,Threshold);
    end
end

    

clear