function [wi, ti] = heun ( RHS, t0, x0, tf, N )

    %MOD_EULER  approximate the solution of the initial value problem
    %
    %                       x'(t) = RHS( t, x ),    x(t0) = x0
    %
    %           using Heun's method - this routine will work for a system
    %           of first-order equations as well as for a single equation
    %
    %     calling sequences:
    %             [wi, ti] = heun ( RHS, t0, x0, tf, N )
    %             heun ( RHS, t0, x0, tf, N )
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

    for i = 1:N
        f1 = feval ( RHS, t0, x0 );
        xtilde = x0 + h * f1;
        x0 = x0 + (h/2) * ( f1 + feval ( RHS, t0+h, xtilde ) );
        t0 = t0 + h;

        wi(1:neqn,i+1) = x0';
    end;
end