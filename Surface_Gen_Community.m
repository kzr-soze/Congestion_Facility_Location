clc;
close all;

length = 3;
width = 2;
commScale = 5;
timeScale = 5;

n = 2;              % Num communities
k = 2;              % Num stores

C = .1;
alpha = C/(n*commScale);
congest = @(x) 1/(C-alpha*x);   % Linear congestion function

[X,Y] = meshgrid(0:.1:length,0:.1:width);

Z = 0*X + 0* Y;

storeX = rand(1,k) * length;
storeY = rand(1,k) * width;
commX = rand(1,n) * length;
commY = rand(1,n) *width;
commSize = randi(commScale,1,n);

    dist = zeros(n,k);      % Distance matrix between stores and communities
    
    % Fill dist with Manhattan distances (l_1 norm)
    for i = 1:n
        for j = 1:k
            dist(i,j) = abs(commX(i) - storeX(j)) + abs(commY(i) - storeY(j));
        end
    end
    
    dist = dist * timeScale;


intervals = 21;
x = linspace(0,1,intervals);
y = linspace(0,1,intervals);
z = zeros(intervals,intervals);

initAssignment = zeros(k,n);

for i =1:intervals
    for j = 1:intervals
        initAssignment(1,1) = x(i);
        initAssignment(2,1) = 1 - x(i);
        initAssignment(1,2) = y(j);
        initAssignment(2,2) = 1-y(j);
        z(i,j) = TotalTime(commSize,congest,initAssignment,n,k,dist);
    end
end

s = surf(x,y,z);
%s = surf(x,y,z,'Edgecolor','none');




[assign,fval] = CustomerAssignment(storeX,storeY,commX,commY,commSize,congest,timeScale);

disp(assign);
disp(fval);