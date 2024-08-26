ALPHA = input(" Relative volatility of Binary mixture ")
Zd = input("molar fraction of volatile component in upward section ")
Xw = input("molar fraction of volatile component in downward section ")



% determine the Number of Feeds and specify q, Zf(molar fraction of volatile
% component), and F(Feed molar rate) in each Feed in a form of Zf(1)
% > Zf(2) > Zf(3) > ... > Zf(N)

N = input("Number of Feeds ")
F = [] ;
Zf = [] ;
q = [] ; 
for i = 1:N
    q(i) = input("q ") 
    Zf(i) = input("Zf ") 
    F(i) = input("F ") 
end



% molar flow rate of Distillate (D)

syms D W
S = solve(sum(F)-D-W == 0,sum(F.*Zf)-D*Zd-W*Xw == 0) ;
W = eval(S.W) ; 
disp("molar flow rate of Distillate product")
D = eval(S.D) 



%  plot equlibrium curve and y = x

y1 = @(x) ALPHA*x/((ALPHA-1)*x+1)
y2 = @(x) x
fplot(y1,[0 1],'k')
hold on 
fplot(y2,[0 1],'k')
hold on
grid on
title('Mccabe and Thiele method');
xlabel('x');
ylabel('y');



% find the minimum reflux ratio (R-min)

R_min = R_min_solver(ALPHA,q,Zf,Zd,Xw)




% specify the reflux ratio (R)

R = input("molar reflux ratio ")



% plot q-lines and operating lines
% find L and G in each section

[L G mx my] = q_and_operating_lines(N,ALPHA,q,Zf,F,Zd,D,Xw,R)



% find the No of stages

disp("No of stages")
[No] = stair(N,ALPHA,Zd,Xw,L,G,mx,my)
