% Generates arrival times where inter-arrival times is
% the random variable exponential(lambda)

function Z = arrivalTime(lambda, tMax)
    
    mu = 1/lambda;
    % T is the time between the k-1 and the kth student
    % T is the inter-arrival time
    T = exprnd(mu);
    % Initial conditions
    Z0 = 0;
    % First arrival time
    Z(1) = Z0 + T(1);
    % Iteration starts from second arrival time
    k = 2;
    
    % Iteration ends at tMax
    while Z(end) < tMax
        
        % T is the time between the k-1 and the kth student
        % T is the inter-arrival time
        T = exprnd(mu);
        % Iteration starts from second arrival time
        Z(k) = Z(k-1) + T;
        k = k + 1;
        
    end
    Z = Z';
    
end