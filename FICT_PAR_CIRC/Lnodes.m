for i=1:NDX
    for j=1:NDY
        T1=(j-1)*2*NDX+2*(i-1)+1; T2=T1+1;
        LNODS(1,T1)=1+AL1*(j-1)+(i-1); 
        LNODS(1,T2)=5+AL1*(j-1)+(i-1)+(NDX-2);
        LNODS(2,T1)=2+AL1*(j-1)+(i-1); 
        LNODS(2,T2)=4+AL1*(j-1)+(i-1)+(NDX-2);
        LNODS(3,T1)=4+AL1*(j-1)+(i-1)+(NDX-2); 
        LNODS(3,T2)=2+AL1*(j-1)+(i-1);
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            