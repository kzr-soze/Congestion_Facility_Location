function [time] = TotalTime(commSize,congest,assignment,n,k,dist)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    storeAssigned = zeros(k,1);     % Amount of customers assigned per store
    assignment = reshape(assignment,[k,n])';
    %disp(['in TotalTime']);
    %disp(assignment)
    for i =1:n
        for j = 1:k
            storeAssigned(j) = storeAssigned(j) + commSize(i) * assignment(i,j);
        end
    end
    %disp(storeAssigned)
    
    time = 0;   % Total time used by all customers, roundtrip + congestion
    for i = 1:n
        for j = 1:k
            time = time + dist(i,j) * commSize(i) * assignment(i,j);
        end
    end
    for j = 1:k
        time = time + congest(storeAssigned(j))*storeAssigned(j);
    end
    
end

