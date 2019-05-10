clc;
close all;

length = 3;
width = 2;
commScale = 5;
timeScale = 5;

n = 10;              % Num communities
k = 3;              % Num stores

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

intervals = 21;
x = linspace(0,length,intervals);
y = linspace(0,width,intervals);
z = zeros(intervals,intervals);

for i =1:intervals
    for j = 1:intervals
        storeX(k) = x(i);
        storeY(k) = y(j);
        [assign, fval] = CustomerAssignment(storeX,storeY,commX,commY,commSize,congest,timeScale);
        z(i,j) = fval;
    end
end

s = surf(x,y,z);
%s = surf(x,y,z,'Edgecolor','none');




[assign,fval] = CustomerAssignment(storeX,storeY,commX,commY,commSize,congest,timeScale);

disp(assign);
disp(fval);
