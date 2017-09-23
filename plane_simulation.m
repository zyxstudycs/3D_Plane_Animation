clear

%specify the coordinate of local system
buildPlane;
p=importdata('planeCoordinate.mat');
element=importdata('planeElement.mat');
l=50;
m=0;
n=20;
rotate=eye(3);
camera=70;
camera_view=2;
%specify the coordinates of the plane in the local system

save('xMovement', 'l');
save('yMovement', 'm');
save('zMovement', 'n');
save('rotate_matrix','rotate');
save('camera_position','camera');
save('camera_view','camera_view');
h.hf = figure(1);
texture = imread('texture.jpg'); %import the image.
[xResult,yResult,zResult] = useIDW;
[skyX,skyY,skyZ] = sphere(50);
skyX=skyX*100+50;
skyY=skyY*100+50;
skyZ=skyZ*100+50;
skymap = summer;
fig=figure(1);

while(ishandle(fig))
        pause(0.01);
        fig=figure(1);
        %create ground
        groundSurf=surf(xResult,yResult,zResult,'LineStyle','none');
        groundSurf.FaceColor = 'texturemap'; %Tell the surface to use a texturemap for coloring
        groundSurf.CData = texture; %Now set the color data of the surface to be the imported image data.
        material('dull'); %It's nice to have a shiny plane and a dull ground.
        camlight('headlight');
        hold on
        %create sky
        sky = surf(skyX,skyY,skyZ,'LineStyle','none','FaceColor','interp');
        colormap(skymap)
        
        fig.Children.Visible = 'off';
        fig.Children.Clipping = 'off';
        fig.Children.Projection = 'perspective';
               
        l=importdata('xMovement.mat');
        m=importdata('yMovement.mat');
        n=importdata('zMovement.mat');
        rotate=importdata('rotate_matrix.mat');
        
        velocity=0.3;
        l=[0,velocity,0]*rotate(:,1)+l;
        m=[0,velocity,0]*rotate(:,2)+m;
        n=[0,velocity,0]*rotate(:,3)+n;
        save('xMovement', 'l');
        save('yMovement', 'm');
        save('zMovement', 'n');
        plane = localTrans(p,l,m,n,rotate);
       
        %draw the model plane    
        trisurf(element, plane(:,1),plane(:,2),plane(:,3), 'FaceColor','cyan','edgecolor','blue');  
        xlabel('x');ylabel('y');zlabel('z'); 
        hold off
    
        % put camera parameter 
        camera_view=importdata('camera_view.mat');
        if camera_view==1
        camera=importdata('camera_position.mat');
        camposX=1.5*(plane(72,1)+plane(78,1))/2-0.5*(plane(50,1)+plane(41,1))/2;
        camposY=1.5*(plane(72,2)+plane(78,2))/2-0.5*(plane(50,2)+plane(41,2))/2;
        camposZ=1.5*(plane(72,3)+plane(78,3))/2-0.5*(plane(50,3)+plane(41,3))/2;
        campos([camposX,camposY,camposZ]);
        camtarget([((plane(50,1)+plane(41,1))/2),((plane(50,2)+plane(41,2))/2),((plane(50,3)+plane(41,3))/2)]);
        camva(camera);
        else if camera_view==2
                camera=importdata('camera_position.mat');
                campos([l+3 ,m+1 ,n+2]);
                camtarget([l,m,n]);
                camva(camera-30);
            end
        end

        %use keyboard to change the value 
        set(h.hf, 'WindowKeyPressFcn', @changeParameter);

end