function [fval] = DummyCustAssign(storeLoc,commX,commY,commSize,congest,timeScale,k)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    storeX = storeLoc(1:k)';
    storeY = storeLoc(k+1:2*k)';
    [~,fval] = CustomerAssignment(storeX,storeY,commX,commY,commSize,congest,timeScale);
end

