avg=zeros(1,4);
box=zeros(1,4);
enlarge=80;

load('acfDetector3');
faced=acfDetector3.acfDetector3;
videoFileReader = vision.VideoFileReader('cxk.avi');

bas=imread('lanqiu.png');
 writerObj=VideoWriter('test.avi');  %// 定义一个视频文件用来存动画
    open(writerObj);   

A=step(videoFileReader);
 I=step(videoFileReader);
bboxes = detect(faced,A);
[bsizex,~]=size(bboxes);
if(bsizex==1)
    bbox=bboxes;
else
     bbox=round(mean(bboxes)) ;
end
box(1)=bbox(1);
box(2)=bbox(2);
box(3)=bbox(3);
box(4)=bbox(4);
avg(1)=bbox(1);
avg(2)=bbox(2);
avg(3)=bbox(3);
avg(4)=bbox(4);
for i=1:1500

A=step(videoFileReader);
II=rgb2gray(A);
bboxes = detect(faced,II);
[bby,~]=size(bboxes);
if(bby==1||bby==0)
    bbox=bboxes;
else
    temp=zeros(1,bby);
    for j=1:bby
        if (bboxes(j,3)>150&&bboxes(j,3)<220)
        temp(j)=bboxes(j,3);
        else
            temp(j)=2000;
        end
    end
         temp=sort(temp);
         for j=1:bby
             if(bboxes(j,3)==temp(1))
                 bbox=bboxes(j,1:4);
             end
         end
    
end

% [bsizex,~]=size(bboxes);
% if(bsizex==1)
%     bbox=bboxes;
% else
%      bbox=round(mean(bboxes)) ;
% end

if isempty(bbox)==0
     for a=1:4
     avg(a)=bbox(a);
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
g1=medfilt2(A(:,:,1));%%红
g2=medfilt2(A(:,:,2));%%绿
g3=medfilt2(A(:,:,3));%%蓝
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