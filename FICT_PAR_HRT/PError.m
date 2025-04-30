%% Pointwise Error


%% Exact Value
Ex_Val=zeros(NEQ,1);
for i=1:NEQ
    Ex_Val(i)=-(((COORD1(1,i)-0.5)^2+(COORD1(2,i)-0.5)^2-0.0625)^3-(COORD1(1,i)-0.5)^2 *(COORD1(2,i)-0.5)^3 -(COORD1(1,i))*COORD1(2,i));
end
%%
PERV=zeros(NEQ,1);
for i=1:NEQ
    if (ismember(i,CINRNOD))
        PERV(i,1)=abs(Sol(i)-Ex_Val(i));
    end
end



SUM = 0; 
for k=1:AL2,
     for j=1:AL1,
         SUM=SUM + 1;
         XXX(k,j)=COORD(1,SUM);   YYY(k,j)=COORD(2,SUM); 
     end
end
RV = 0;
for k=1:AL2,
     for j=1:AL1,
         RV=RV + 1;
             EF=KODGL(RV);
             if(EF==0)
                ZZZ(k,j)=0; %%%%our g
             else
                ZZZ(k,j)=PERV(EF);
             end   
    end
end
surfc(XXX,YYY,ZZZ)