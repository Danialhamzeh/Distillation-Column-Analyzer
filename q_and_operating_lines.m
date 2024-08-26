function [L G mx my] = q_and_operating_lines(N,ALPHA,q,Zf,F,Zd,D,Xw,R)
% plot q_lines
% plot the upward operating line


L = [] ;           % L is amount of liquid at rectification section
G = [] ;           % G is the amount of vapour at rectification section
mx = [] ;    
my = [] ;          % mx and my are the intersection of q-lines and operating lines


L(1) = R*D  ;              
G(1) = (R+1)*D  ;           

plot([Zd Xw],[Zd Xw],"ro") ;
hold on 

if q(1) == 1
    mx(1) = Zf(1) ; 
    my(1) = L(1)/G(1)*Zf(1)+Zd/(R+1) ;

else  
    syms k1 k2
    S = solve(q(1)/(q(1)-1)*k1-Zf(1)/(q(1)-1)-k2==0,L(1)/G(1)*k1+Zd/(R+1)-k2==0) ;
    mx(1) = eval(S.k1) ;
    my(1) = eval(S.k2) ;
end
x1 = [Zd mx(1)] ;
y1 = [Zd my(1)] ;
plot(x1,y1,"k") ;
hold on 

% plot first q-line
XX = [Zf(1) mx(1)] ; 
YY = [Zf(1) my(1)] ;
plot(XX,YY,"r") 
hold on



% plot the Middle and Final Operating Lines

if N == 1
      xi = [mx(1) Xw] ;
      yi = [my(1) Xw] ;
      plot(xi,yi,"k")
      hold on
end
for j = 2:N                              %  j = shomare operating line
    L(j) = L(j-1)+F(j-1)*q(j-1) ; 
    G(j) = L(j) + G(j-1) - L(j-1) - F(j-1) ;
    if q(j) == 1
        mx(j) = Zf(j) ;
        my(j) = L(j)/G(j)*Zf(j)-L(j)/G(j)*mx(j-1)+my(j-1) ;
    else 
        syms t1 t2
        S = solve(q(j)/(q(j)-1)*t1-Zf(j)/(q(j)-1)-t2 == 0,L(j)/G(j)*t1-L(j)/G(j)*mx(j-1)+my(j-1)-t2 == 0) ;
        mx(j) = eval(S.t1) ;
        my(j) = eval(S.t2) ;
    end
    xi = [mx(j-1) mx(j)] ;
    yi = [my(j-1) my(j)] ;
    plot(xi,yi,"k")
    hold on

    % plot q-lines in order 2 to N
    XX = [Zf(j) mx(j)] ; 
    YY = [Zf(j) my(j)] ;
    plot(XX,YY,"r")
    hold on

    if j == N
        Xi = [mx(j)  Xw] ;
        Yi = [my(j) Xw] ;
        plot(Xi,Yi,"k") 
        hold on 
    end
end