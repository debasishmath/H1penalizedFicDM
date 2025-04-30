%% FUNCTION FILE FOR ERROR%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ER=zeros(size(INTLNODS,2),1);
ER1=zeros(size(INTLNODS,2),1); %for H1

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



    
    
ERF=zeros(6,1);
ERF1=zeros(6,1);%for H1
for i=1:3,
     ALAMB(i,1)=1.0/3.0;
 end
 w2=(155.0-sqrt(15.0))/1200.0; w3=(155.0+sqrt(15.0))/1200.0;
 A1=(9.0+2*sqrt(15.0))/21.0; A2=(9.0-2*sqrt(15.0))/21.0;
 B1=(6.0+sqrt(15.0))/21.0; B2=(6.0-sqrt(15.0))/21.0;
 W(1)=9.0/40.0; W(2)=w2; W(3)=w2;
 ALAMB(1,2)=A1; ALAMB(2,2)=B2; ALAMB(3,2)=B2; 
 ALAMB(1,3)=B2; ALAMB(2,3)=A1; ALAMB(3,3)=B2; W(4)=w2;
 ALAMB(1,4)=B2; ALAMB(2,4)=B2; ALAMB(3,4)=A1; W(5)=w3;
 ALAMB(1,5)=A2; ALAMB(2,5)=B1; ALAMB(3,5)=B1; W(6)=w3;
 ALAMB(1,6)=B1; ALAMB(2,6)=A2; ALAMB(3,6)=B1; W(7)=w3;
 ALAMB(1,7)=B1; ALAMB(2,7)=B1; ALAMB(3,7)=A2;
 for i=1:7,
     ALAM1=ALAMB(1,i); ALAM2=ALAMB(2,i); ALAM3=ALAMB(3,i);
     PHI(1)=ALAM1;
     PHI(2)=ALAM2;
     PHI(3)=ALAM3;
   
       
        



ER(IELEM,1)=ER(IELEM,1)+W(i)*( exp(1)*( 0.5*-(ALAM1*X1+ALAM2*X2+ALAM3*X3   -0.5)^2 -...
                                           ( ALAM1*Y1+ALAM2*Y2+ALAM3*Y3- 0.5)^2 +0.0625 )-...
                                           ( U_h(INTLNODS(1,IELEM))*PHI(1)  + U_h(INTLNODS(2,IELEM))*PHI(2) + U_h(INTLNODS(3,IELEM))*PHI(3) )  )^2;
                                       
 ER1(IELEM,1)=ER1(IELEM,1)+W(i)* ((exp(1)*-(ALAM1*X1+ALAM2*X2+ALAM3*X3   -0.5) ...
                                    -(U_h(INTLNODS(1,IELEM))*BTI11 +...
                                            U_h(INTLNODS(2,IELEM))*BTI21 + U_h(INTLNODS(3,IELEM))*(-BTI11-BTI21)))^2+...
                                    (exp(1)*-2*(ALAM1*Y1+ALAM2*Y2+ALAM3*Y3   -0.5) ...
                                    -(U_h(INTLNODS(1,IELEM))*BTI12 +...
                                            U_h(INTLNODS(2,IELEM))*BTI22 + U_h(INTLNODS(3,IELEM))*(-BTI12-BTI22)))^2);
 
 
    
 end


ER(IELEM,1)=ER(IELEM,1)*DET*0.5;
ER1(IELEM,1)=ER1(IELEM,1)*DET*0.5;

 end


 


H1ERS=(sum(ER1))^0.5; %%seminorm

L2ER=(sum(ER))^0.5
H1ER=H1ERS+L2ER

















