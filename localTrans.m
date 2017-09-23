function [pMove ] = localTrans( p,l,m,n,rotate )

    %after move 
    pMove=p; 
    p_rotate=pMove*rotate;
    pMove=[p_rotate(:,1)+l,p_rotate(:,2)+m,p_rotate(:,3)+n];
    
end


