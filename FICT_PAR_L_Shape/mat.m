%% %%%%%%%%%Calculation of matrices%%%%%%%%%%%%
%% Using Center of Gravity Approach (using INTLNODS)
BM=sparse(NEQ,NEQ);
%BM=zeros(NEQ,NEQ);
BL=zeros(NEQ,1);

IM=sparse(NEQ,NEQ);
%IM=zeros(NEQ,NEQ);
%INI_M=zeros(NEQ,1);

 for IELEM=1:size(INTLNODS,2)
    NVERT1=INTLNODS(1,IELEM);
    NVERT2=INTLNODS(2,IELEM);
    NVERT3=INTLNODS(3,IELEM);
    X1=COORD1(1,NVERT1); Y1=COORD1(2,NVERT1);
    X2=COORD1(1,NVERT2); Y2=COORD1(2,NVERT2);
    X3=COORD1(1,NVERT3); Y3=COORD1(2,NVERT3);
    BT11=(X1-X3); BT12=(X2-X3); BT21=(Y1-Y3); BT22=(Y2-Y3);
    DET=(X1-X3)*(Y2-Y3)-(X2-X3)*(Y1-Y3);
    BTI11=(Y2-Y3)/DET; BTI12=-(X2-X3)/DET; % This is for invese matrix 
    BTI21=-(Y1-Y3)/DET; BTI22=(X1-X3)/DET;
 Elstif;
 Mass;
 Eload;
%Initial;
for i=1:3
    for j=1:3
        BM(INTLNODS(i,IELEM),INTLNODS(j,IELEM))=BM(INTLNODS(i,IELEM),INTLNODS(j,IELEM))+KI(i,j);
        IM(INTLNODS(i,IELEM),INTLNODS(j,IELEM))=IM(INTLNODS(i,IELEM),INTLNODS(j,IELEM))+MI(i,j);

    end
    BL(INTLNODS(i,IELEM),1)=BL(INTLNODS(i,IELEM),1)+F(i,1);
  % INI_M(INTLNODS(i,IELEM),1)=INI_M(INTLNODS(i,IELEM),1)+GG(i,1);
    
end

 end
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
 
 
