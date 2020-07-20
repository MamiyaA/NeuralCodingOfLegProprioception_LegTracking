# NeuralCodingOfLegProprioception_LegTrackingAndSynchronization
Scripts for tracking and analyzing tibia position data presented in "Neural Coding of Leg Proprioception in Drosophila" (Mamiya, Gurung, and Tuthill (2018) Neuron: DOI:https://doi.org/10.1016/j.neuron.2018.09.009). Also scripts for synchronizing calcium imaging data with tibia tracking data and piezo movement data.

![Graphical Abstract](Mamiya_etal_Neuron.jpg)

Brief descriptions of the analysis scripts.

DetectCameraAndImagingFrames: Calculate the timing of the image frames for 2-photon laser scanning microscope and high-speed video camera. Read the binary file that contains time series data that describes the position of the x and y mirrors of the scanning laser microscope and the exposure signal for the camera used to track the fly tibia position. Use peak detection alogirthm to identify the end of the frame for each time of images.

DetectCameraAndImagingFrames_All: Runs DetectCameraAndImagingFrames for all the appropriate files in the directory.

DrawMaskAndBackground3_withComments: Read in a sample video file and ask the user to specify the area to use for tracking tibia angle. Also generates a background image without the tibia by combining two images with tibia at different position.

TrackLegAngle4: Combine background image and image mask generated above with user specified threshold to find the pixels corresponding to the tibia. For each frame, calculate the orientation (second moment of inertia) and the centroid of the tibia pixels. 

TrackLegAngle4_All: Runs TrackLegAngle4 for all the apporpriate files in a directory.

TrackLegAngle4_All_All: Runs TrackLegAngle4_All for all the appropriate folders in a directory.

TrackLegAngle4_withComments: TrackLegAngle4 script with more comments for each line.

FindPiezoStartFrames: Use the binary data file that contains the Piezo command signal and the output from the DetectCameraAndImagingFrames to find the 2-photon imaging frame that corresponds to the beginning of the presentation of the Piezo vibration stimulus.

ConvertTibiaAngle_FindMoveOnset: Calculate and convert femur-tibia angle to degrees based on the use specified femur angle and the tibia tracking data. Use tibia trackin data to find the onset of tibia movement. Plot both tibia angle and tibia angle speed for user inspection.

