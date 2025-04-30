    
    %% Define the nonhomogeneous boundary contion
    G=zeros(NEQ,1);
    IG=zeros(NEQ,1);
    
        for i=1:size(GMANOD,1)
        G(GMANOD(i,1))=gn(COORD1(1,GMANOD(i)),COORD1(2,GMANOD(i)));%g
        end
      
        for i=1:size(INRNOD,1)
        IG(INRNOD(i,1))=gn(COORD1(1,INRNOD(i)),COORD1(2,INRNOD(i)));%g
        end
        
        
        
         
        
function g=gn(x,y)
       %  g=0;
%          g=1/16-(x-0.5)^2-(y-0.5)^2; %in fact u
            g=(-(x-0.5)^2-(y-0.5)^2+1/16); %in fact u
         
end

% function gt=gnt(t,x,y)
%        %  g=0;
% %          g=1/16-(x-0.5)^2-(y-0.5)^2; %in fact u
%             gt=exp(t)*(-(x-0.5)^2-(y-0.5)^2+1/16); %in fact u
%          
% end