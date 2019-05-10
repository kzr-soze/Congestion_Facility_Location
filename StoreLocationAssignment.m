function [assignStore,assignCustomers,fval] = StoreLocationAssignment(commX,commY,commSize,congest,timeScale,k,l,w)
%StoreLocationAssignment : Given Community locations and sizes, determines
%   optimal location of stores


    storeX = l * rand(k,1);
    storeY = w * rand(k,1);
    initAssignment = [storeX;storeY];
    ub = [zeros(k,1) + l; zeros(k,1) + w];
    disp(ub)
    disp(initAssignment)
    lb = zeros(2*k,1);
    disp(initAssignment(1:k)')
    
    disp(DummyCustAssign(initAssignment,commX,commY,commSize,congest,timeScale,k));
    
    obj = @(assign) DummyCustAssign(assign,commX,commY,commSize,congest,timeScale,k);
    disp(obj(initAssignment));
    
    [assignStore, fval] = fmincon(obj,initAssignment,[],[],[],[],lb,ub);
    
    storeX = assignStore(1:k)';
    storeY = assignStore(k+1:2*k)';
    assignStore = [assignStore(1:k),assignStore(k+1:2*k)];
    
    assignCustomers = CustomerAssignment(storeX,storeY,commX,commY,commSize,congest,timeScale);
    
end

