bbox=zeros(1,4);
videoFileReader = vision.VideoFileReader('cxk.avi');
for i=1:200
    step(videoFileReader);
end
for i=1:1000
  I=step(videoFileReader);
  II=rgb2gray(I);
 bboxes = detect(acfDetector3,II);
% [bby,~]=size(bboxes);
% if(bby==1||bby==0)
%     bbox=bboxes;
% else
%     temp=zeros(1,bby);
%     for j=1:bby
%         if (bboxes(j,3)>210&&bboxes(j,3)<240)
%         temp(j)=bboxes(j,3);
%         else
%             temp(j)=2000;
%         end
%     end
%          temp=sort(temp);
%          for j=1:bby
%              if(bboxes(j,3)==temp(1))
%                  bbox=bboxes(j,1:4);
%              end
%          end
%     
% end

% [bsizex,~]=size(bboxes);
% if(bsizex==1)
%     bbox=bboxes;
% else
%      bbox=round(mean(bboxes)) ;
% end
annotation = acfDetector3.ModelName;
I = insertObjectAnnotation(I,'rectangle',bboxes,annotation);
imshow(I)
end