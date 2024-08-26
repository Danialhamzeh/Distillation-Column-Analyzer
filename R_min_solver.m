function R_min = R_min_solver(ALPHA,q,Zf,Zd,Xw)
if q(1) == 1
    O1 = Zf(1) ;
    O2 = ALPHA*Zf(1)/((ALPHA-1)*Zf(1)+1) ;
else
    syms o1 o2
    SS = solve(ALPHA*o1/((ALPHA-1)*o1+1)-o2==0,q(1)/(q(1)-1)*o1-Zf(1)/(q(1)-1)-o2==0)
    O1 = eval(SS.o1) ;
    O2 = eval(SS.o2) ;
    if O1(1) > O1(2)
       O1 = O1(1) ;
       O2 = O2(1) ;
   else
      O1 = O1(2) ;
      O2 = O2(2) ;
    end
end
m = (O2-Zd)/(O1-Zd) ;
R_min = -m/(m-1) ; 