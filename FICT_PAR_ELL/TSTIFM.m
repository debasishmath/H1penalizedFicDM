
%%%% This is for the Toatal Stiffness Matrix i.e. Matrix corresponding to
%%%% all the nodes including the boundary nodes also.
TSTIFFM=sparse(NVERTS,NVERTS);
for IELEM=1:NELEM
    NVERT1=LNODS(1,IELEM); NVERT2=LNODS(2,IELEM); NVERT3=LNODS(3,IELEM);
    X1=COORD(1,NVERT1); Y1=COORD(2,NVERT1);
    X2=COORD(1,NVERT2); Y2=COORD(2,NVERT2);
    X3=COORD(1,NVERT3); Y3=COORD(2,NVERT3);
    BT11=(X1-X3); BT12=(X2-X3); BT21=(Y1-Y3); BT22=(Y2-Y3);
    DET=(X1-X3)*(Y2-Y3)-(X2-X3)*(Y1-Y3);
    BTI11=(Y2-Y3)/DET; BTI12=-(X2-X3)/DET; % This is for invese matrix 
    BTI21=-(Y1-Y3)/DET; BTI22=(X1-X3)/DET;
    %Elstif  %%%Elstif is runned already no need to run it again
    
    for i=1:3
        S=LNODS(i,IELEM);
        for j=1:3
            P=LNODS(j,IELEM);
            if (S-P <=0)      %This is for the upper triangular matrix 
                TSTIFFM(S,P)=TSTIFFM(S,P)+KI(i,j);
            end
        end
    end
    
                
    
    
end

for i=1:NVERTS
    for j=1:NVERTS                      %copying all the upper entries above the diagonal into lower one
        TSTIFFM(j,i)=TSTIFFM(i,j);
    end
end
