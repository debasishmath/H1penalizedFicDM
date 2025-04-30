% %  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%LEVEL SET FUNCTION%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%This is the code for the level set function to identify the nodes
%%%%%%%%%inside the inner domain \Omega rectange centered at (.5, .5) of
%%%%%%%%%length .5


for i=1:size(COORD,2)
 
    x=COORD(:,i);
    if (( 0.2<=x(1) & x(1)<=0.8 & 0.2<=x(2) & x(2)<=0.5 ) || (0.2<=x(1) & x(1)<=0.5 & 0.5<=x(2) & x(2)<=0.8) )
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
     
   
               
 



INRNOD=zeros(NEQ,1); %%INRNOD stands for inner node no i.e. all the nodes except the boundary i.e. eqn no

for m=1:NVERTS
    if(KODGL(m)~=0)                     %%Now KODGL is nonzero for the inner nodes and for each node it has related eqn no.
        if (FCOORD(1,m)~=0 & FCOORD(2,m)~=0)  %%%To consider the nodes outside the inner domain \Omega  
            INRNOD(m,1)=KODGL(m);
        end
    end
end
          
    INRNOD=nonzeros(INRNOD);

  
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%to find the triangles which lie completely inside of inner domain
    %%%\omega
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
   ILNODS=LNODS; 
    for j=1:NELEM
        for i=1:3
            if (KODGL(ILNODS(i,j))==0)
                ILNODS(i,j)=0;
            else ILNODS(i,j)=KODGL(ILNODS(i,j));
            end
        end
    end
   
 ILNODS(:,any(ILNODS == 0))=[];
 
 for j=1:size(ILNODS,2)
     for i=1:3
         if (ismember(ILNODS(i,j),INRNOD)==0)
             ILNODS(i,j)=0;
         end
     end
 end
 
     
     ILNODS(:,any(ILNODS == 0))=[];
    % p=( 2*(NDX-2)*(0.5*(NDX-2)+0.5))+1; %To remove the extra triangle at (.5,.5)
     % ILNODS(:,p)=[];
     
     
    
     
     for i=1:size(ILNODS,2)
         if ( COORD1(:,ILNODS(1,i))==[0.5;0.5])% & COORD1(:,ILNODS(2,i))==[0.5+h1;0.5])
             p=i;
         end
     end
     
         ILNODS(:,p)=[]; %To remove the extra triangle at (.5,.5)
         
         
     
         
         
         
         
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
       if  ( ( 0.2<=x_G(1,i) & x_G(1,i)<=0.8 & 0.2<=x_G(2,i) & x_G(2,i)<=0.5 ) || (0.2<=x_G(1,i) & x_G(1,i)<=0.5 & 0.5<=x_G(2,i) & x_G(2,i)<=0.8) )
           
        INTLNODS(:,i)=INTLNODS(:,i);
    else INTLNODS(:,i)=0;
    end
end
INTLNODS(:,any(INTLNODS == 0))=[];

for i=1:size(OTRLNODS,2)  
       if  ( ( 0.2>x_G(1,i) || x_G(1,i)>0.8 || 0.2>x_G(2,i) || x_G(2,i)>0.5 ) &  (0.2>x_G(1,i) || x_G(1,i)>0.5 || 0.5>x_G(2,i) || x_G(2,i)>0.8))
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
         
         
         