% Script to test that StoreLocationAssignment runs correctly
clc;
close all;

rounds = 10;       % Iterations for Multi-Start
length = 3;
width = 2;
commScale = 5;      % Max Community size
timeScale = 2;

n = 40;              % Num communities
k = 3;              % Num stores

C = .1;
% alpha = C/(n*commScale);
% beta = 0.85*commScale*n;
alpha = C/(35*commScale);
beta = 0.85 *commScale*35;
congest = @(x) 1/(C - alpha*x/(log(beta/x)));

%alpha = C/(40*5);
%congest = @(x) 1/(C-alpha*x);   % Linear congestion function

commX = rand(1,n) * length;
commY = rand(1,n) *width;
commSize = randi(commScale,1,n);

best_Store = 0;
best_Customers = 0;
fval_set = zeros(rounds,1);
best_fval = inf;
times = zeros(rounds,1);

tic
t_last = toc;
for i = 1:rounds
    [assignStore,assignCustomers,fval_set(i)] = StoreLocationAssignment(commX,commY,commSize,congest,timeScale,k,length,width);
    t = toc;
    times(i) = t - t_last;
    t_last = toc;
    if fval_set(i) <= best_fval
        best_fval = fval_set(i);
        best_Store = assignStore;
        best_Customers = assignCustomers;
    end
end

disp(best_Store);
disp(best_Customers');
disp(best_fval);
disp(['n = ',num2str(n),', k = ',num2str(k)]);
disp('Times and values')
disp([mean(times),var(times),std(times)]);
disp([mean(fval_set),var(fval_set),std(fval_set)]);

hold on
sz = 7*commSize;
scatter(commX',commY',sz,'r','filled');
scatter(best_Store(:,1),best_Store(:,2),'b','filled');