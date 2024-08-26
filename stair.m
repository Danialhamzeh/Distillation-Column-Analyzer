function [No m] = stair(N,ALPHA,Zd,Xw,L,G,mx,my)

% stairs in Upward and Middle Sections

m = [Zd] ;
for j = 1:N
   while 1
        I = length(m) ;
        m(I+1) = -m(I)/((ALPHA-1)*m(I)-ALPHA) ;
        if I == 1
            xi = [m(I) m(I+1)] ;
            yi = [m(I) m(I)] ;
             plot(xi,yi,"b") 
             hold on 
        else
            xi = [m(I-1) m(I+1)] ;
            yi = [m(I) m(I)] ;
            plot(xi,yi,"b")
            hold on 
        end
        if mx(j) > m(I+1)
            if j == N 
                m(I+2) = (Xw-my(j))/(Xw-mx(j))*(m(I+1)-mx(j))+my(j) ;
                Xi = [m(I+1) m(I+1)] ;
                Yi = [m(I) m(I+2)] ;
                plot(Xi,Yi,"b") 
                hold on
                break
            else
                m(I+2) = (my(j+1)-my(j))/(mx(j+1)-mx(j))*(m(I+1)-mx(j))+my(j) ;
                Xi = [m(I+1) m(I+1)] ;
                Yi = [m(I) m(I+2)] ;
                plot(Xi,Yi,"b")
                hold on
                break
            end
        else
            m(I+2) = L(j)/G(j)*(m(I+1)-mx(j))+my(j) ;
            Xi = [m(I+1) m(I+1)] ;
            Yi = [m(I) m(I+2)] ;
            plot(Xi,Yi,"b")
            hold on
            continue
        end
    end
end


% aisles in Downward Section

while 1
    I = length(m) ;
    m(I+1) = -m(I)/((ALPHA-1)*m(I)-ALPHA) ;
    xi = [m(I-1) m(I+1)] ;
    yi = [m(I) m(I)] ;
    plot(xi,yi,"b")
    hold on 
    m(I+2) = (Xw-my(N))/(Xw-mx(N))*(m(I+1)-mx(N))+my(N) ;
    Xi = [m(I+1) m(I+1)] ; 
    Yi = [m(I) m(I+2)] ;
    plot(Xi,Yi,"b") 
    hold on
    if m(I+2) < Xw
        break
    end
end

No = (length(m)-1)/2 ;
