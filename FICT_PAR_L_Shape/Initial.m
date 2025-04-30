GG=zeros(3,1);
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
    for j=1:3,
        %G(j,1)=G(j,1)+PHI(j)*W(i)*1;
        
%         GG(j,1)=GG(j,1)+PHI(j)*W(i)*( (ALAM1*X1+ALAM2*X2+ALAM3*X3)*...
%             (1-(ALAM1*X1+ALAM2*X2+ALAM3*X3))*(ALAM1*Y1+ALAM2*Y2+ALAM3*Y3)*...
%             (1-(ALAM1*Y1+ALAM2*Y2+ALAM3*Y3) ));
        
%         GG(j,1)=GG(j,1)+PHI(j)*W(i)*(-1)*( (ALAM1*X1+ALAM2*X2+ALAM3*X3 -0.5)^2 +...
%             (ALAM1*Y1+ALAM2*Y2+ALAM3*Y3 -0.5)^2-1/16);
        GG(j,1)=GG(j,1)+PHI(j)*W(i)*((ALAM1*X1+ALAM2*X2+ALAM3*X3-0.2)*(ALAM1*X1+ALAM2*X2+ALAM3*X3-0.8)*(ALAM1*X1+ALAM2*X2+ALAM3*X3-0.5)*...
                                      (ALAM1*Y1+ALAM2*Y2+ALAM3*Y3-0.2)*(ALAM1*Y1+ALAM2*Y2+ALAM3*Y3-0.8)*(ALAM1*Y1+ALAM2*Y2+ALAM3*Y3-0.5));
            
    end
end
for i=1:3,
    GG(i,1)=GG(i,1)*DET*0.5;
end