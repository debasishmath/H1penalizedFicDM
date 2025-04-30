
% %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%LEVEL SET FUNCTION%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%This is the code for the level set function to identify the nodes
%%%%%%%%%inside the inner domain \Omega 


for i=1:size(COORD,2)
 
    x=COORD(:,i);
    if (  (x(1)-0.5)^2  + (x(2)-0.5)^2  -0.0625   <=0)  %%%**<=0;//,=h1/3 to consider the nodes outside the domain nearer to the boundary
         FCOORD(:,i)=COORD(:,i);
     else FCOORD(:,i)=[0,0];
    end
   
end



                                    
COORD1=zeros(2,NVERTS);

for i=1:NVERTS
    if (KODGL(i)~=0)
        COORD1(:,i)=COORD(:,i);
    end
end

  COORD1(:,any(COORD1==0))=[];  %removes columns containing zeros
  
  
  INRNOD1=zeros(NEQ,1); %%INRNOD stands for inner node no i.e. all the nodes except the boundary i.e. eqn no

for m=1:NVERTS
    if(KODGL(m)~=0)                     %%Now KODGL is nonzero for the inner nodes and for each node it has related eqn no.
        if (FCOORD(1,m)~=0 & FCOORD(2,m)~=0)  %%%To consider the nodes outside the inner domain \Omega  
            INRNOD1(m,1)=KODGL(m);
        end
    end
end
          
    INRNOD1=nonzeros(INRNOD1);%%INNER Nodes wrt ILNODS approach

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%to find the triangles which lie completely inside  and nearer to the boundary of  inner domain
    %%%\omega
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
   ILNODS=LNODS;    %%%This Loop makes the entries corresponding to the boundary nodes of the rectangle zero
    for j=1:NELEM
        for i=1:3
            if (KODGL(ILNODS(i,j))==0)
                ILNODS(i,j)=0;
            else ILNODS(i,j)=KODGL(ILNODS(i,j));
            end
        end
    end
   
 ILNODS(:,any(ILNODS == 0))=[];
  
 for j=1:size(ILNODS,2) %This loop makes the entries corresponding to the nodes outside the inner domain  to 0
     for i=1:3
         if (ismember(ILNODS(i,j),INRNOD1)==0)
             ILNODS(i,j)=0;
         end
     end
 end
 
     
     ILNODS(:,any(ILNODS == 0))=[];
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Center of gravity approach%%%%%%%%%%%%%%%%%%%
%find the center of gravity for each triangle



INTLNODS=LNODS;
OTRLNODS=LNODS;
for i=1:NELEM
    for j=1:3
        if KODGL(INTLNODS(j,i)==0)
            INTLNODS(j,i)=0;
            OTRLNODS(j,i)=0;
        else INTLNODS(j,i)=KODGL(INTLNODS(j,i));
             OTRLNODS(j,i)=KODGL(OTRLNODS(j,i));
        end
    end
end

INTLNODS(:,any(INTLNODS == 0))=[];
OTRLNODS(:,any(OTRLNODS == 0))=[];

x_G=zeros(2,size(INTLNODS,2));%%%Center of Gravity of each triangle 
for i=1:size(INTLNODS,2)
    x_G(1,i)=(COORD1(1,INTLNODS(1,i))+COORD1(1,INTLNODS(2,i))+COORD1(1,INTLNODS(3,i)))/3;
    x_G(2,i)=(COORD1(2,INTLNODS(1,i))+COORD1(2,INTLNODS(2,i))+COORD1(2,INTLNODS(3,i)))/3;
end

for i=1:size(INTLNODS,2)  
       if  (  (x_G(1,i)-0.5)^2 + (x_G(2,i)-0.5)^2 -0.0625 <=0)
        INTLNODS(:,i)=INTLNODS(:,i);
    else INTLNODS(:,i)=0;
    end
end
INTLNODS(:,any(INTLNODS == 0))=[];

for i=1:size(OTRLNODS,2)  
       if  (  (x_G(1,i)-0.5)^2 + (x_G(2,i)-0.5)^2 -0.0625 >0)
        OTRLNODS(:,i)=OTRLNODS(:,i);
    else OTRLNODS(:,i)=0;
    end
end
OTRLNODS(:,any(OTRLNODS == 0))=[];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TO FIND THE BOUNDARY NODES%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

INRNOD=zeros(NEQ,1);

for i=1:NEQ
    if (ismember(i,INTLNODS))
        INRNOD(i)=i;
    end
end
 
INRNOD=nonzeros(INRNOD);


GMANOD=intersect(INTLNODS,OTRLNODS);
%% NODES WHICH LIE COMPLETELY INSIDE%%
CINRNOD=setdiff(INRNOD,GMANOD);


%% Nods which lie Completely outside the domain \omega
    TNOD=[1:NEQ]'; % local variable to define the total nodes
    COTRNOD=setdiff(TNOD,INRNOD);% %completely outer nodes