



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%This is the code for nonhomogeneous boundary condition%%%%%%%%%%%%%
%%%%%%%%%Chnage here UG wrt the given boundary condition%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count=0;
for i=1:size(KODGL,1)
    if (KODGL(i,1) ~= 0)
         count=count+1;
         Z(count,1)=i;  %%This gives the numbering of the inner nodes
    end
end


AG=zeros(count,NVERTS);  %% size of AG matrix is (no of non boundary nodes )*no of all the nodes
for i=1:count
    AG(i,:)=TSTIFFM(Z(i,1),:);
end
    
    UG=zeros(NVERTS,1);
    for i=1:NVERTS
        if (KODGL(i,1)==0)
            UG(i,1)=0;        %%%%%%your boundary condition g
        else UG(i,1)=0;
        end
    end
    
    F2=AG*UG;
    
    
    
    
    