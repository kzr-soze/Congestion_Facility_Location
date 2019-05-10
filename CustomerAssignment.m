function [assign,fval] = CustomerAssignment(storeX,storeY,commX,commY,commSize,congest,timeScale)
%CustomerAssignment : Computes the optimal assignment of customers to
%   stores for fixed locations
%   Detailed explanation goes here
    
    n = size(commSize,2);   % Number of customer communities
    k = size(storeX,2);     % Number of stores
    
    dist = zeros(n,k);      % Distance matrix between stores and communities
    
    % Fill dist with Manhattan distances (l_1 norm)
    for i = 1:n
        for j = 1:k
            dist(i,j) = abs(commX(i) - storeX(j)) + abs(commY(i) - storeY(j));
        end
    end
    
    dist = dist * timeScale;
    
   % disp(dist);
    
    
    initAssignment = zeros(k,n);    % Initialize with all customers assigned to store 1
    for i = 1:n
        for j = 1:k
            initAssignment(j,i) = 1/k;
        end
    end
    initAssignment = reshape(initAssignment,[n*k,1]);
    
   % disp([n,k])
   % disp(initAssignment)
   % disp(reshape(initAssignment,[k,n]));
    
    objFun = @(assign) TotalTime(commSize,congest,assign,n,k,dist); 
    Aeq = zeros(n,k*n);
    index = 1;
    for i = 1:n
        for j = 1:k
            Aeq(i,index) = 1;
            index = index+1;
        end
    end
   
        
    beq = zeros(n,1) + 1;
    lb = zeros(1,k*n);
    ub = zeros(1,k*n) + 1;
    
   % disp(Aeq*initAssignment);
   % disp(beq);
   % disp(TotalTime(commSize,congest,initAssignment,n,k,dist));
    
    [assign, fval] = fmincon(objFun,initAssignment,[],[],Aeq,beq,lb,ub);
    assign = reshape(assign,[k,n]);
    
end

