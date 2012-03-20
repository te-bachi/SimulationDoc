function [wi, ti] = ab2 ( RHS, t0, x0, tf, N )

    %AB2       approximate the solution of the initial value problem
    %
    %                       x'(t) = RHS( t, x ),    x(t0) = x0
    %
    %          using the second-order Adams-Bashforth method - this routine 
    %          will work for a system of first-order equations as well as 
    %          for a single equation
    %
    %          NOTE: the optimal RK2 method is used to initialize the 
    %                multistep method
    %
    %
    %     calling sequences:
    %             [wi, ti] = ab2 ( RHS, t0, x0, tf, N )
    %             ab2 ( RHS, t0, x0, tf, N )
    %
    %     inputs:
    %             RHS     string containing name of m-file defining the 
    %                     right-hand side of the differential equation;  the
    %                     m-file must take two inputs - first, the value of
    %                     the independent variable; second, the value of the
    %                     dependent variable
    %             t0      initial value of the independent variable
    %             x0      initial value of the dependent variable(s)
    %                     if solving a system of equations, this should be a 
    %                     row vector containing all initial values
    %             tf      final value of the independent variable
    %             N       number of uniformly sized time steps to be taken to
    %                     advance the solution from t = t0 to t = tf
    %
    %     output:
    %             wi      vector / matrix containing values of the approximate 
    %                     solution to the differential equation
    %             ti      vector containing the values of the independent 
    %                     variable at which an approximate solution has been
    %                     obtained
    %

    neqn = length ( x0 );
    ti = linspace ( t0, tf, N+1 );
    wi = [ zeros( neqn, N+1 ) ];
    wi(1:neqn, 1) = x0';

    h = ( tf - t0 ) / N;

    %
    %  generate w1 using the optimal RK2 method  
    %

    fold = feval ( RHS, t0, x0 );
    xtilde = x0 + (2*h/3) * fold;
    x0 = x0 + (h/4) * fold + (3*h/4) * feval ( RHS, t0 + (2*h/3), xtilde );
    t0 = t0 + h;
    wi(1:neqn,2) = x0';


    %
    %  perform remaining time steps using 2-step Adams Bashforth method
    %

    for i = 2:N
        fnew = feval ( RHS, t0, x0 );
        x0 = x0 + (3*h/2) * fnew - h/2 * fold;
        t0 = t0 + h;
        fold = fnew;

        wi(1:neqn,i+1) = x0';	
    end;
end