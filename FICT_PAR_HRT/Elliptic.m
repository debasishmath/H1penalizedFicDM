clear all
format short
NDX=input('Enter the Number of Subdivisons in X direction = ');
NDY=input('Enter the Number of Subdivisons in Y direction = ');
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
KODBC=zeros(NFIX,1); %% Array name   %{edited in % by swapnil} this might be defined to store boundary condition
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
        IEQ=IEQ+1;%%%%  it counts only those entries which are 0 i.e. only non boundary nodes. 
        KODGL(m)=IEQ;
    else
        KODGL(m)=0;
    end
end
NEQ=IEQ; % NEQ = # of Equation (Number of unknowns)
NVERTS=AL1*AL2;
KI=zeros(3,3); %% Local stiffness matrix
GLSTIF=sparse(NEQ,NEQ); %% Global stiffness matrix
B=zeros(NEQ,1); %% Global Load Vector
ALAMB=zeros(3,7); W=zeros(7); %% Seven point Gaussian integration  %Lamb stands for Lambda the Barycentric Co-ordinates
PHI= zeros(3); 






LVLSF;
mat; %%%Matrix BM calculated here 




for IELEM=1:NELEM,
    NVERT1=LNODS(1,IELEM); NVERT2=LNODS(2,IELEM); NVERT3=LNODS(3,IELEM);
    X1=COORD(1,NVERT1); Y1=COORD(2,NVERT1);
    X2=COORD(1,NVERT2); Y2=COORD(2,NVERT2);
    X3=COORD(1,NVERT3); Y3=COORD(2,NVERT3);
    BT11=(X1-X3); BT12=(X2-X3); BT21=(Y1-Y3); BT22=(Y2-Y3);
    DET=(X1-X3)*(Y2-Y3)-(X2-X3)*(Y1-Y3);
    BTI11=(Y2-Y3)/DET; BTI12=-(X2-X3)/DET; % This is for invese matrix 
    BTI21=-(Y1-Y3)/DET; BTI22=(X1-X3)/DET;
 Elstif; % This function for ELSTIF Matrix   %it calculates local stiffness matrix for each triange
 
 Eload; % This function for ELOAD Vector

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
        end
    end
end
        B(TT,1)=B(TT,1)+F(INODE,1);
        end
    end
end
for i=1:NEQ,
    for j=i:NEQ,
        GLSTIF(j,i)=GLSTIF(i,j);
    end
end










%TSTIFM;

%LVLSF

%Ag;
%B=B-F2;                           %%change F2 for the inner domain
%Sol=GLSTIF\B %% This is the finite element solution.

% STIFK=FGLSTIF+0.0001*GLSTIF;
%  BB=FB+0.0001*FB;   %%adjust F2 here without delta %%since \tilde{f} is 0 outside the domain
%  Sol=STIFK\BB
mat1
e=h1^2;
KK=(1/e)*(GLSTIF-BM)+BM+e*GLSTIF;
Sol=KK\(BL-BM*G); %% This is the finite element solution.


%mat1;
%Sol=SOL;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NEXT PARAGRAPH FOR PLOTTING THE SOLUTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

for i=1:NEQ
   if ismember(i,GMANOD)
       Sol(i)=G(i);
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
                ZZZ(k,j)=Sol(EF);
             end   
    end
end
% surfc(XXX,YYY,ZZZ)


figure
surf(XXX,YYY,ZZZ)
xlabel('x')
ylabel('y')
zlabel('u^\epsilon_h')
figure
contour(XXX,YYY,ZZZ)
xlabel('x')
ylabel('y')
contour(XXX,YYY,ZZZ)
 %contour(XXX,YYY,ZZZ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   NEXT PARAGRAPH FOR ERROR ESTIMATE     %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
Error1