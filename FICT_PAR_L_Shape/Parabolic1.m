clear all
format short
NDX=input('Enter the Number of Subdivisons in X direction = ');
NDY=input('Enter the Number of Subdivisons in Y direction = ');
T=input('Enter the no of divisions in the Time direction =');
DeltaT=1.0/T; % Lentgth of the time step
h=1/NDX;
AL1=NDX+1; % AL1 = # of Nodal Points on X axis
AL2=NDY+1; % AL2 = # of Nodal Points on Y axis
NELEM=2*NDX*NDY; % NELEM = # of Elements (TRIANGLES)
h1=1.0/(AL1-1); % Lentgth of the parameter
h2=1.0/(AL2-1); % Lentgth of the parameter
NVERTS=AL1*AL2; % NVERTS = Total # of Nodes
COORD=zeros(2,AL1*AL2); % Initialisation
LNODS=zeros(3,NELEM);   % Initialisation
% Define COORDINATES 
for k=1:AL2,
    for j=1:AL1,
        n=NVERTS-AL1+j;
        COORD(1,n)=(j-1)*h1; COORD(2,n)=(AL2-k)*h2;
        %%COORD(1,n)=-1+(j-1)*h1; COORD(2,n)=-1+(AL2-k)*h2;
    end
    NVERTS=NVERTS-AL1;
end
%COORD
Lnodes; % LOCAL and GLOBAL nodes relation function
%LNODS
NVERTS=AL1*AL2;
NFIX=2*(NDX+NDY); %% # of Fix Nodes on the boundary
KODGL=zeros(NVERTS,1); %% Array name
NODFIX=zeros(NFIX,1); %% which global number we are fixing %{edited in % by swapnil} which nodes are fixed
KODBC=zeros(NFIX,1); %%  defined to store boundary condition
Nodefix % This is the Nodefix function
%NODFIX
for P=1:NFIX
    KODBC(P)=1; % Homogeneous Dirichlet Bdry Condition %%%%??????
end
for P=1:NFIX,
    N1=NODFIX(P); KODGL(N1)=KODBC(P); %%%%here KODBC matrix takes the value 1 for the boundary nodes, otherwise 0.
end
IEQ=0;
for m=1:AL1*AL2,
    KD=KODGL(m);
    if(KD==0)
        IEQ=IEQ+1;%%%%it counts only those entries which are 0 i.e. only non boundary nodes. 
        KODGL(m)=IEQ;
    else
        KODGL(m)=0;
    end
end
NEQ=IEQ; % NEQ = # of Equation (Number of unknowns)
NVERTS=AL1*AL2;
KI=zeros(3,3); %% Local stiffness matrix

MI=zeros(3,3); %% Local mass matrix
GLSTIF=sparse(NEQ,NEQ); %% Global stiffness matrix
MASS=sparse(NEQ,NEQ); %% Global MASS matrix
INI=zeros(NEQ,1); %% Global INITIAL Vector

Uh_Ini=zeros(NEQ,1); U_h=zeros(NEQ,1); %% Global Load Vector

BM=sparse(NEQ,NEQ);%%%matrix B in our method
%B=zeros(NEQ,1); %% Global Load Vector
ALAMB=zeros(3,7); W=zeros(7); %% Seven point Gaussian integration
PHI= zeros(3); 



LVLSF;
mat; %%%Matrix BM calculated here 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for IELEM=1:NELEM,
    NVERT1=LNODS(1,IELEM); NVERT2=LNODS(2,IELEM); NVERT3=LNODS(3,IELEM);
    X1=COORD(1,NVERT1); Y1=COORD(2,NVERT1);
    X2=COORD(1,NVERT2); Y2=COORD(2,NVERT2);
    X3=COORD(1,NVERT3); Y3=COORD(2,NVERT3);
    BT11=(X1-X3); BT12=(X2-X3); BT21=(Y1-Y3); BT22=(Y2-Y3);
    DET=(X1-X3)*(Y2-Y3)-(X2-X3)*(Y1-Y3);
    BTI11=(Y2-Y3)/DET; BTI12=-(X2-X3)/DET; % This is for invese matrix 
    BTI21=-(Y1-Y3)/DET; BTI22=(X1-X3)/DET;
 Elstif; % This function for ELSTIF Matrix   
 Mass; % This function for MASS Matrix  
% Eload321; % This function for ELOAD Vector
 %Initial; % This function for INITIAL Vector
 
 for INODE=1:3,
    SS=LNODS(INODE,IELEM); TT=KODGL(SS);%%%%KODGL gives the nonboundary node number recounting from 1
    if (TT==0)
        C1=0;                                        %%%%so as to consider only inner nodes
    else
        C1=1;   end
if(C1)
        for JNODE=1:3,
            PP=LNODS(JNODE,IELEM); QQ=KODGL(PP);
            if (QQ==0)
                C2=0;                                       %%%%These all the loops are provided so as to deal with fixed nodes
            else
                C2=1;   end
if(C2)
        BB=TT-QQ;
        if(BB<0)%%%%%%%%%%%%%  so as to consider the terms only once 
            C3=0;
        else
            C3=1;  end%%%%i.e.>=0
if(C3)
        GLSTIF(QQ,TT)=GLSTIF(QQ,TT)+KI(INODE,JNODE);%%%%%%%%%%%   so as to give the upper triangular matrixn   QQ<TT is chosen
        MASS(QQ,TT)=MASS(QQ,TT)+MI(INODE,JNODE);
        end
    end
end
        %%B(TT,1)=B(TT,1)+F(INODE,1);
        %INI(TT,1)=INI(TT,1)+GG(INODE,1);
        end
    end
end
for i=1:NEQ,
    for j=i:NEQ,
        GLSTIF(j,i)=GLSTIF(i,j);
        MASS(j,i)=MASS(i,j);
        end
end
mat1;
INI_M=IG;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Uh_Ini=IG;
%Uh_Ini=MASS\INI_M %% This is the solution for initial value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Calculate the solution for Time > 0 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for Time=1:T %%% This is the loop time step started
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GBL1=zeros(NEQ,1); %% Global Load Vector
%Gt=zeros(NEQ,1);
%mat;
%mat1;
%%%%%%%%%%%%%%%%%%%%%%
Gt=zeros(NEQ,1);
%mat1;
for i=1:size(GMANOD,1)
   Gt(GMANOD(i,1))=gnt(Time*DeltaT, COORD1(1,GMANOD(i)),COORD1(2,GMANOD(i)));%g
end  
%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for IELEM=1:NELEM,
%     NVERT1=LNODS(1,IELEM); NVERT2=LNODS(2,IELEM); NVERT3=LNODS(3,IELEM);
%     X1=COORD(1,NVERT1); Y1=COORD(2,NVERT1);
%     X2=COORD(1,NVERT2); Y2=COORD(2,NVERT2);
%     X3=COORD(1,NVERT3); Y3=COORD(2,NVERT3);
%     BT11=(X1-X3); BT12=(X2-X3); BT21=(Y1-Y3); BT22=(Y2-Y3);
%     DET=(X1-X3)*(Y2-Y3)-(X2-X3)*(Y1-Y3);
%     BTI11=(Y2-Y3)/DET; BTI12=-(X2-X3)/DET; % This is for invese matrix 
%     BTI21=-(Y1-Y3)/DET; BTI22=(X1-X3)/DET;
%  %Elstif; % This function for ELSTIF Matrix   
%  %Mass; % This function for MASS Matrix  
%  %Eload321; % This function for ELOAD Vector
%  %Initial321; % This function for INITIAL Vector
%   for INODE=1:3,
%      SS=LNODS(INODE,IELEM); TT=KODGL(SS);
%      if (TT==0)
%          C1=0;
%      else
%          C1=1;   end
%  if(C1)
%          
%   % %         BL(TT,1)=BL(TT,1)+F1(INODE,1);
% %   %      INI(TT,1)=INI(TT,1)+G(INODE,1);
%          end
%      end
% end
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:NEQ
            
            GBL1(i,1)=exp(Time*DeltaT)*BL(i,1); % Here exp(T) multiplying 
    end
 %Uh_Ini  
%%%% Finding Solution 
e=sqrt(h);
%  Temp1 = IM +(1/e)*(MASS-IM) + DeltaT*BM +(1/e)* DeltaT*(GLSTIF-BM)+e*DeltaT*GLSTIF; % This Implicit method (Backward Euler Method)
%  Temp2 = (IM +(1/e)*(MASS-IM))*Uh_Ini + DeltaT*(BL);
% (IM+(1/e)*(MASS-IM))*Uh_Ini;

%  Temp1 = IM +(1/e)*(MASS-IM) + DeltaT*BM +(1/e)* DeltaT*(GLSTIF-BM)+e*DeltaT*GLSTIF; % This Implicit method (Backward Euler Method)
%  Temp2 = (IM +(1/e)*(MASS-IM))*Uh_Ini + DeltaT*(BL-IM*Gt-BM*Gt);

%%Temp1 = MASS + DeltaT*BM +(1/e)* DeltaT*(GLSTIF-BM)+e*DeltaT*GLSTIF; % This Implicit method (Backward Euler Method)
%Temp2 = MASS*Uh_Ini + DeltaT*(BL); %Original approach
%%Temp2 = MASS*Uh_Ini + DeltaT*(BL-MASS*Gt-BM*Gt);% Splitting approach

Temp1 = MASS + DeltaT*BM +(1/e)* DeltaT*(GLSTIF-BM)+e*DeltaT*GLSTIF;
%Temp1 = MASS + DeltaT*BM +(1/e)* DeltaT*(GLSTIF-BM)+e*DeltaT*GLSTIF; % This Implicit method (Backward Euler Method)
Temp2 = MASS*Uh_Ini + DeltaT*(GBL1); %Original approach
%Temp2 = MASS*Uh_Ini + DeltaT*(BL-MASS*Gt-BM*Gt);% Splitting approach

  U_h=Temp1\Temp2; %% This isthe finite element solution.

 Uh_Ini=U_h; % Assigning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end  %% This is end for loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NEXT PARAGRAPH FOR PLOTTING THE SOLUTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

U_h;
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
                ZZZ(k,j)=0; 
             else
                ZZZ(k,j)=U_h(EF);
             end   
    end
end
%surf(XXX,YYY,ZZZ)
%contour(XXX,YYY,ZZZ)
% pcolor(XXX,YYY,ZZZ);
%   shading interp

figure
surf(XXX,YYY,ZZZ)
shading interp
xlabel('x')
ylabel('y')
zlabel('u^\epsilon_h')
figure
contour(XXX,YYY,ZZZ)
xlabel('x')
ylabel('y')
contour(XXX,YYY,ZZZ)








Error1;























% 
% mat1;
% e=h1^2;
% KK=(1/e)*(GLSTIF-BM)+BM+e*GLSTIF;
% Sol=KK\(BL-BM*G); %% This is the finite element solution.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% NEXT PARAGRAPH FOR PLOTTING THE SOLUTION
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% 
% %Sol=SOL;
% for i=1:NEQ
%    if ismember(i,GMANOD)
%        Sol(i)=G(i);
%    end
% end
%     
%     
% SUM = 0; 
% for k=1:AL2,
%      for j=1:AL1,
%          SUM=SUM + 1;
%          XXX(k,j)=COORD(1,SUM);   YYY(k,j)=COORD(2,SUM); 
%      end
% end
% RV = 0;
% for k=1:AL2,
%      for j=1:AL1,
%          RV=RV + 1;
%              EF=KODGL(RV);
%              if(EF==0)
%                 ZZZ(k,j)=0;
%              else
%                 ZZZ(k,j)=Sol(EF);
%              end   
%     end
% end
% figure
% surf(XXX,YYY,ZZZ)
% xlabel('x')
% ylabel('y')
% zlabel('u^\epsilon_h')
% figure
% contour(XXX,YYY,ZZZ)
% xlabel('x')
% ylabel('y')
% contour(XXX,YYY,ZZZ)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%   NEXT PARAGRAPH FOR ERROR ESTIMATE     %%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
% 
% Error1;




function gt=gnt(t,x,y)
       %  g=0;
%          g=1/16-(x-0.5)^2-(y-0.5)^2; %in fact u
            gt=exp(t)*((x-0.2)*(x-0.8)*(x-0.5)*(y-0.2)*(y-0.8)*(y-0.5)); %in fact u
         
end
