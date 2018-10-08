%Written on 2017/03/27. For running TrackLegAngle4_All for all the flies
%(Directories) that are appropriate.
%
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

function []=TrackLegAngle4_All_All()

%load the file to decide which flies to run the script.
FliesID=load('IDFlies.txt');

%Find all the Flies.
FlyName=dir('20*');
        
NofFlies=size(FlyName,1);

for n=1:NofFlies
    if FliesID(n)==1
        cd(FlyName(n).name);
        FlyName(n).name
        datetime
        TrackLegAngle4_All();
        cd ..
    end
end

    

clear