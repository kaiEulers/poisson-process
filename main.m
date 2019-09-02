%% PRM Workshop 6: Poisson Random Process
%% Question 3b
% Theoretical value of P[Y(20)<=3 AND Y(40)<=5]
clc, clear

q = 0;
for k1 = 0:3
   for k2 = 0:(5 - k1)
       
      q = q + 5^(k1+k2)/(factorial(k1)*factorial(k2)) *exp(-10);
       
   end
end
q

%% Question 4: Sample path of Poisson Process
clc, clear

lambda = 0.25;
mu = 1/lambda;
tMax = 60;

% arrivalTime() returns a vector of visit time up to
% tMax
Z1 = arrivalTime(lambda, tMax);
Z2 = arrivalTime(lambda, tMax);
Y1 = [1:length(Z1)]';
Y2 = [1:length(Z2)]';

figure(1)
stairs(Z1, Y1, 'linewidth', 1)
hold on
stairs(Z2, Y2, 'linewidth', 1)
hold off
xlabel('Time (min)'), ylabel('Number of arrivals')
title('Poisson Process Sample Paths')
xlim([0 60])
grid on
saveas(figure(1), 'PRMws6_4.jpg')

% ----------Question 5ai, ii, iii: Number of arrivals
% arrivalNum(Z,t1,t2) returns the number of arrivals
% between time t1 and t2 in the arrival time vector Z.
% If t2 is omitted, arrival(Z,t1) returns the number of
% arrivals between time 0 and t1.

% Expected number of visits in the first
% t = {20, 30, 40}mins
Y20 = arrivalNum(Z1, 20);
Y30 = arrivalNum(Z1, 30);
Y40 = arrivalNum(Z1, 40);

% ----------Question 5bi, ii, iii: Number of arrivals
% Expected number of visits in between
% t = {[20, 40], [30, 50], [40, 60]}mins
Y20_40 = arrivalNum(Z1, 20, 40);
Y30_50 = arrivalNum(Z1, 30, 50);
Y40_60 = arrivalNum(Z1, 40, 60);

Time_Frame = {
    'First 20 mins'
    'First 30 mins'
    'First 40 mins'
    'Between 20 & 40 mins'
    'Between 30 & 50 mins'
    'Between 40 & 60 mins'
    };
Number_of_Arrivals = [
    Y20
    Y30
    Y40
    Y20_40
    Y30_50
    Y40_60
    ];
disp(table(Time_Frame, Number_of_Arrivals))

%% Question 6a: Empirical PMF of Y(40)
% WARNING: This section will take some time to run!
% Empirical PMF of number of visit by t = 40
clc, clear

% --------------------Empirical Probability
lambda = 0.25;
tMax = 60;
trials = 50e3;

Y20 = zeros(trials, 1);
Y30 = zeros(trials, 1);
Y40 = zeros(trials, 1);
Y20_40 = zeros(trials, 1);
Y30_50 = zeros(trials, 1);
Y40_60 = zeros(trials, 1);
for k = 1:trials
    
    Z = arrivalTime(lambda, tMax);
    Y20(k) = arrivalNum(Z, 20);
    Y30(k) = arrivalNum(Z, 30);
    Y40(k) = arrivalNum(Z, 40);
    Y20_40(k) = arrivalNum(Z, 20, 40);
    Y30_50(k) = arrivalNum(Z, 30, 50);
    Y40_60(k) = arrivalNum(Z, 40, 60);
    
end
save PRMws6 Y20 Y30 Y40 Y20_40 Y30_50 Y40_60
%%
load PRMws6
% --------------------Theoretical Probability
% Theoretical distribution of number of visits at
% interval tau is poisson(lambda*tau)
tau = 40;
alpha = lambda*tau;

k = 0:max(Y40);
Y40_theo = alpha.^k./factorial(k) * exp(-alpha);

% --------------------Plots
figure(2)
histogram(Y40, max(Y40), 'normalization', 'pdf')
hold on
stairs(k, Y40_theo, 'linewidth', 2)
hold off
grid on
xlabel('Number of arrivals'), ylabel('Probability')
title({
    'Theoretical & Empirical PMF of Y(40)'
    'Distribution of the number visits to water fountain in the first 40min'
    })
legend({'Empirical PMF', 'Theoretical PMF'})
saveas(figure(2), 'PRMws6_6a.jpg')

%% Compare Empirical PMFs
clc
load PRMws6

figure(3)
histogram(Y20, max(Y20), 'normalization', 'pdf', 'displaystyle', 'stairs', 'linewidth', 1)
hold on
histogram(Y20_40, max(Y20_40), 'normalization', 'pdf', 'displaystyle', 'stairs', 'linewidth', 1)
histogram(Y30_50, max(Y30_50), 'normalization', 'pdf', 'displaystyle', 'stairs', 'linewidth', 1)
histogram(Y40_60, max(Y40_60), 'normalization', 'pdf', 'displaystyle', 'stairs', 'linewidth', 1)
hold off
grid on
xlabel('Number of arrivals'), ylabel('Probability')
title('Empirical PMF of Y(20) = Y(20 < t < 40) = Y(30 < t < 50) = Y(40 < t < 60)')
legend({
    'PMF of Y(20)'
    'PMF of Y(20 < t < 40)'
    'PMF of Y(30 < t < 50)'
    'PMF of Y(40 < t < 60)'
    })

figure(4)
histogram(Y20, max(Y20), 'normalization', 'pdf')
hold on
histogram(Y30, max(Y30), 'normalization', 'pdf')
histogram(Y40, max(Y40), 'normalization', 'pdf')
hold off
grid on
xlabel('Number of arrivals'), ylabel('Probability')
title('Empirical PMFs')
legend({
    'PMF of Y(20)'
    'PMF of Y(30)'
    'PMF of Y(40)'
    })

%% Question 6b: Emipirical P[Y(20)<=3 AND Y(40)<=5]
clc
load PRMws6

% Empirical probability of no more than 3 students
% visiting the fountain in the first 20min AND no more
% than 5 students visiting the fountain in the first
% 40min
Y20_3_Y40_5 = mean((Y20 <= 3)&(Y40 <= 5));
disp(['P[Y(20)<=3 AND Y(40)<=5] = ' num2str(Y20_3_Y40_5*100) '%'])

%% Question 6c: Emipirical E[Y(t)]
% for t = {20, 30, 40}
clc
load PRMws6

% Expected value of number of students visiting the
% fountain in the first 20min, 30min, and 40min
% respectively
exp_Y20 = mean(Y20);
exp_Y30 = mean(Y30);
exp_Y40 = mean(Y40);

Random_Variable = {
    'Y(20)'
    'Y(30)'
    'Y(40)'
    };
Empirical_Expected_Value = [
    exp_Y20
    exp_Y30
    exp_Y40
    ];
disp(table(Random_Variable, Empirical_Expected_Value))

%% Question 6d: Emipirical E[Y(t)*Y(t+10)]
% for t = {20, 30}
clc
load PRMws6

% Empirical auto-correlation values
exp_Y20Y30 = mean(Y20.*Y30);
exp_Y30Y40 = mean(Y30.*Y40);

% Theoretical auto-correlation values
theo_Y20Y30 = 1/4*20 + 1/16*20*30;
theo_Y30Y40 = 1/4*30 + 1/16*30*40;

Random_Variable = {
    'Y(20)*Y(20 + 10)'
    'Y(30)*Y(30 + 10)'
    };
Empirical_AutoCorrelation = [
    exp_Y20Y30
    exp_Y30Y40
    ];
Theoretical_AutoCorrelation = [
    theo_Y20Y30
    theo_Y30Y40
    ];
disp(table(Random_Variable, Empirical_AutoCorrelation, Theoretical_AutoCorrelation))

%% Question 9a: Wait times with service time U~(0.3,1)
% WARNING: This section will take some time to run!
clc, clear

% Parameter for inter-arrival time exponential(lambda)
lambda = 0.25;
% Parameters for service time U~(a,b)
a = 0.3;
b = 1;

% Function waitTime() computes the wait time given
% parameters of the inter-arrival time and service time
% and the number of arrivals
trials = 50e3;
maxW = 30;
Wa = zeros(maxW, trials);
for cnt = 1:trials
    
    % Wait time
    Wa(:,cnt) = waitTime(lambda, a, b, maxW);
    
end

% Mean wait times
Wa_mean = mean(Wa, 2);
save('PRMws6', 'Wa_mean', '-append')
%%
load PRMws6
% Plot of mean Wait Times
figure(5)
stairs([1:30], Wa_mean, 'linewidth', 1)
grid on
xlabel('Arrival Number')
ylabel('Mean Wait Time (min)')
title(['Mean Wait Times with Service Time U~(' num2str(a) ',' num2str(b) ')'])
saveas(figure(5), 'PRMws6_9a.jpg')

%% Question 9b: Wait times with service time U~(2,5)
% WARNING: This section will take some time to run!
clc, clear

% Parameter for inter-arrival time exponential(lambda)
lambda = 0.25;
% Parameters for service time U~(a,b)
a = 2;
b = 5;

% Function waitTime() computes the wait time given
% parameters of the inter-arrival time and service time
% and the number of arrivals
trials = 50e3;
maxW = 30;
Wb = zeros(maxW, trials);
for cnt = 1:trials
    
    % Wait time
    Wb(:,cnt) = waitTime(lambda, a, b, maxW);
    
end

% Mean wait times
Wb_mean = mean(Wb, 2);
save('PRMws6', 'Wb_mean', '-append')
%% 
load PRMws6

% Plot Mean Wait Times for 9a and 9b
figure(6)
stairs([1:30], Wa_mean, 'linewidth', 1)
hold on
stairs([1:30], Wb_mean, 'linewidth', 1)
hold off
grid on
xlabel('Arrival Number')
ylabel('Mean Wait Time (min)')
legend({
    'Service Time U~(0.3,1)'
    'Service Time U~(2,5)'
    })
saveas(figure(6), 'PRMws6_9b.jpg')
