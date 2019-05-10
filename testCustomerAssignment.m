% Script to test that CustomerAssignment runs correctly
clc;
close all;

length = 30;
width = 20;
commScale = 5;
timeScale = 5;

n = 5;              % Num communities
k = 3;              % Num stores

C = .1;
alpha = C/(n*commScale);
congest = @(x) 1/(C-alpha*x);   % Linear congestion function


storeX = rand(1,k) * length;
storeY = rand(1,k) * width;
commX = rand(1,n) * length;
commY = rand(1,n) *width;
commSize = randi(commScale,1,n);

[assign,fval] = CustomerAssignment(storeX,storeY,commX,commY,commSize,congest,timeScale);

disp(assign);
disp(fval);


