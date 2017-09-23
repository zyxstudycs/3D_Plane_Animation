function changeParameter(h,e)

rotate=importdata('rotate_matrix.mat');
camera=importdata('camera_position.mat');
camera_view=importdata('camera_view.mat');

%specify each keyboard for rotate
    if get(h,'CurrentCharacter')=='q'
        camera=70;
    else if get(h,'CurrentCharacter')=='a'
        camera=100;
        else if get(h,'CurrentCharacter')=='z'
                camera=130;  
            end
        end
    end
    
    if get(h,'CurrentCharacter')=='w'
        camera_view=1;
    else if get(h,'CurrentCharacter')=='e'
        camera_view=2;
            end
        end
    
    if get(h,'CurrentCharacter')=='l'
        rotate=angle2dcm(0,0.05,0)*rotate;
    else if get(h,'CurrentCharacter')=='j'
        rotate=angle2dcm(0,-0.05,0)*rotate;
        else rotate=rotate*angle2dcm(0,0,0);
        end
    end
    
    if get(h,'CurrentCharacter')=='i'
       rotate=angle2dcm(0,0,0.05)*rotate;
    else if get(h,'CurrentCharacter')=='k'
        rotate=angle2dcm(0,0,-0.05)*rotate;
        else rotate=rotate*angle2dcm(0,0,0);
        end
    end
    
    if get(h,'CurrentCharacter')=='u'
        rotate=angle2dcm(0.05,0,0)*rotate;
    else if get(h,'CurrentCharacter')=='o'
        rotate=angle2dcm(-0.05,0,0)*rotate;
        else rotate=rotate*angle2dcm(0,0,0);
        end
    end
    
    
    %get each value for movement as time goes by
    save('rotate_matrix','rotate');
    save('camera_position','camera');
    save('camera_view','camera_view');
    
end


