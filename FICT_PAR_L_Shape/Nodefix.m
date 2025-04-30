L=0; K=0;
for P=1:NFIX,
    if (P>=1 & P<AL1)
        NODFIX(P)=P;
    elseif (P>=AL1 & P<AL1+AL2-1)%%%%-1 because now one node is common at the corner
        K=K+AL1; NODFIX(P)=K; L=K+AL1;%sice at each step AL1 no of vertices are added in the mesh
    elseif (P>=AL1+AL2-1 & P<2*AL1+AL2-2)% 2 is multiplied since we are traveling back once again & 2 is subtracted since 2 points of cornerr
        NODFIX(P)=L; L=L-1;
    else 
        NODFIX(P)=L; L=L-AL1;
    end
end
   
                  
