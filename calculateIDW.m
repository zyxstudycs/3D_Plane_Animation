function [z] = calculateIDW( xCoordinate,yCoordinate,zPoints,x,y,n,m )
W=zeros(n+1,m+1);
distance=W;
p=2;
total=0;
for i=1:n+1
    for j=1:m+1
        Xij=xCoordinate(i);
        Yij=yCoordinate(j);
        distance(i,j)=((x-Xij)^2+(y-Yij)^2)^0.5;
        total=total+distance(i,j)^(-p);
    end
end%get total distance
getZ=any(distance==0);
getZ=any(getZ==1);
if getZ==1
    [I,J]=find(distance==0);
    z=zPoints(I,J);
else
for i=1:n+1
    for j=1:m+1
        W(i,j)=distance(i,j)^(-p)/total;
    end
end%get weight parameter matrix W.
z=0;
for i=1:n+1
    for j=1:m+1
        z=z+zPoints(i,j)*W(i,j);
    end
end
end
end

