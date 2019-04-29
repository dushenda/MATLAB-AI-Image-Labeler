avg=zeros(1,4);
box=zeros(1,4);
enlarge=150;

faceDetector = vision.CascadeObjectDetector();

videoFileReader = vision.VideoFileReader('cxk.avi');
bas=imread('lanqiu.png');
writerObj=VideoWriter('test.avi');  %// ����һ����Ƶ�ļ������涯��
open(writerObj);   

A=step(videoFileReader);

bbox= step(faceDetector, A);
% bboxes = detect(faced,A);
% [bsizex,~]=size(bboxes);
% if(bsizex==1)
%     bbox=bboxes;
% else
%      bbox=round(mean(bboxes)) ;
% end
for i=1:4
    box(i)=bbox(i);
    avg(i)=bbox(i);
end

for i=1:1500
%     release(faceDetector);
A=step(videoFileReader);
D=rgb2gray(A);

bbox= step(faceDetector, D);

% bboxes = detect(faced,A);
% [bsizex,~]=size(bboxes);
% if(bsizex==1)
%     bbox=bboxes;
% else
%      bbox=round(mean(bboxes)) ;
% end

if isempty(bbox)==0
     for a=1:4
     avg(a)=round(bbox(a)/2+box(a)/2);
     end
     for a=1:4
     box(a)=bbox(a);
     end
 if bbox(1)<600&&bbox(2)<600
    
B=imresize(imread('lanqiu.png'),[avg(3)+enlarge,avg(4)+enlarge]);

B=im2uint8(B);
A=im2uint8(A);

Gx=avg(2);
Gy=avg(1);
[Lx,Ly,~]=size(B);

%  A((Gx+1):(Gx+Lx),(Gy+1):(Gy+Ly),1:3)= B(1:Lx,1:Ly,1:3);
 if Gx+Lx<720&&Gy+Ly<1280
 for o=1:Lx
     for p=1:Ly
         uint16 sum=0;
         
             sum=B(o,p,1)/3+B(o,p,2)/3+B(o,p,3)/3;
        
         if sum<180
             for q=1:3
                 x=Gx+o-enlarge/2;
                 y=Gy+p-enlarge/2;
                 if x<1
                     x=1;
                 end
                 if y<1
                     y=1;
                 end
                 A(x,y,q)=B(o,p,q);
             end
         else
             for q=1:3
                 A(Gx+o,Gy+p,q)=A(Gx+o,Gy+p,q);
             end
         end
     end
 end
 end
 [L2x,L2y,~]=size(A);
 
 if(L2x>720||L2y>1280)
     A = imcrop(A,[0 0 1280 720]);
 end

g1=medfilt2(A(:,:,1));%%��
g2=medfilt2(A(:,:,2));%%��
g3=medfilt2(A(:,:,3));%%��
g(:,:,1)=g1;
g(:,:,2)=g2;
g(:,:,3)=g3;
A=g;
end
end
imshow(A)

 writeVideo(writerObj,A); 

end
close(writerObj);