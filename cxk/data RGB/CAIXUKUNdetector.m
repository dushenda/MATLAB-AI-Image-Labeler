clear;clc;
videoFileReader = vision.VideoFileReader('../../cxk.avi');
videoPlayer = vision.VideoPlayer('Name','≤Ã–Ï¿§¥Ú«Ú','Position',[500 300 1007 638]);
a=0;
for i=0:30
        A=step(videoFileReader);
        if(mod(i,2)==0)
            imwrite(A,strcat('first',num2str(round(i)),'.jpg'));
            imshow(A);
        end
end