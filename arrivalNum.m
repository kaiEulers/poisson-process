% arrivalNum(Z,t1,t2) returns the number of arrivals
% between time t1 and t2 in the arrival time vector Z.
% If t2 is omitted, arrival(Z,t1) returns the number of
% arrivals between time 0 and t1.

% Z = varargin{1}
% t1 = varargin{2}
% t2 = varargin{3}

function num = arrivalNum(varargin)
    
    if nargin == 2
        
        num = sum(varargin{1} <= varargin{2});
       
    elseif nargin == 3
        
        num  = sum((varargin{1} >= varargin{2}) & (varargin{1} <= varargin{3}));
        
    else
        
        disp('ERROR!!!')
        disp('Invalid number of inputs.')
        
    end
    
end