function [xResult,yResult,zResult] = useIDW()

%IDW, Inverse Distance Weighting interpolation
clear
n=2;
m=3;
xCoordinate=[0;40;99];
yCoordinate=[0;30;60;99];
zCoordinate=[0;0;0;0;0;48;20;0;0;-20;0;0];%generate random value of x,y,z
zPoints=zeros((n+1),(m+1));
k=1;

for i=1:(n+1)
    for j=1:(m+1)
        zPoints(i,j)=zCoordinate(k);
        k=k+1;
    end
end

%get maxtrix of z.

%get limit of x and y oritation
xLimit=[min(xCoordinate),max(xCoordinate)];
yLimit=[min(yCoordinate),max(yCoordinate)];
increase=1;
xNumber=(xLimit(2)-xLimit(1))/increase+1;
yNumber=(yLimit(2)-yLimit(1))/increase+1;

%get every interpolated points
xResult=zeros(xNumber,yNumber); yResult=xResult; 
zResult=xResult;
countX=1; countY=1;
for x=xLimit(1):increase:xLimit(2)
    for y=yLimit(1):increase:yLimit(2)
        xResult(countX,countY)=x;
        yResult(countX,countY)=y;
        z=calculateIDW(xCoordinate,yCoordinate,zPoints,x,y,n,m);
        zResult(countX,countY)=z;
        countY=countY+1;
    end
    countX=countX+1;
    countY=1;
end

%get all points 
allPoints=zeros((n+1)*(m+1),3);
k=1;
for i=1:n+1
    for j=1:m+1
        allPoints(k,1)=xCoordinate(i);
        allPoints(k,2)=yCoordinate(j);
        allPoints(k,3)=zPoints(i,j);
        k=k+1;
    end
end


end

