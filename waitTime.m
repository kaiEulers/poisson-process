% W is a vector containing maxW number of wait times
% lambda is the parameter for the exponential RV of the
% inter-arrival time T
% a and b are the boundries of the uniform RV of the
% service time S

function W = waitTime(lambda, a, b, maxW)
       
    mu = 1/lambda;
    
    S = zeros(maxW-1, 1);
    W = zeros(maxW, 1);
    
    % Initial conditions
    W0 = 0;
    S0 = 0;
    
    % T is the time between k-1 and kth arrival
    T = exprnd(mu);
    % W is the wait time of the kth visit
    W(1) = max([W0 + S0 - T(1), 0]);
    
    % Start k at 2
    for k = 2:maxW
        
        % S is the service time
        S(k-1) = (b-a)*rand() + a;
        % T is the time between k-1 and kth arrival
        T = exprnd(mu);
        % W is the wait time of the kth arrival
        % If wait time is negative, wait time is 0
        W(k) = max([W(k-1) + S(k-1) - T, 0]);
        
    end
    
end
