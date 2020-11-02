clear
clc

%%% generating data %%%
[num text all]=xlsread('lab3_data.xlsx')

%%% converting data to variable vectors %%%
datevec = num(:,1);
ubcanomaly = num(:,2);
globalanomaly = num(:,3);
TSI = num(:,4);
AOD = num(:,5);
CO2 = num(:,6);
SO2 = num(:,7);
MEI = num(:,8);

%%% linear regression %%%
X1 = [ones(size(globalanomaly)) globalanomaly];

[R1, bint1, q1, qint1, stats1] = regress(TSI, X1)
[R2, bint2, q2, qint2, stats2] = regress(AOD, X1)
[R3, bint3, q3, qint3, stats3] = regress(CO2, X1)
[R4, bint4, q4, qint4, stats4] = regress(SO2, X1)
[R5, bint5, q5, qint5, stats5] = regress(MEI, X1)

TSIslope = R1(2,1);
AODslope = R2(2,1);
CO2slope = R3(2,1);
SO2slope = R4(2,1);
MEIslope = R5(2,1);

TSIinterval = bint1(2,:);
AODinterval = bint2(2,:);
CO2interval = bint3(2,:);
SO2interval = bint4(2,:);
MEIinterval = bint5(2,:);

TSIcoefD = stats1(1,1);
AODcoefD = stats2(1,1);
CO2coefD = stats3(1,1);
SO2coefD = stats4(1,1);
MEIcoefD = stats5(1,1);

%%% linear regression  for MEI vs Temp %%%
X2 = [ones(size(globalanomaly)) globalanomaly];
X3 = [ones(size(ubcanomaly)) ubcanomaly];

[R6, bint6, q6, qint6, stats6] = regress(MEI, X2);
[R7, bint7, q7, qint7, stats7] = regress(MEI, X3)

T2pred = X2*R6;
T3pred = X3*R7;

%%% plot %%%
clf

subplot(2,1,1)
plot(globalanomaly, MEI, 'ko', globalanomaly, T2pred, 'r-')
xlabel({'Global Temperature';'Anomaly (degrees C)'})
ylabel({'Multivariate';'ENSO Index'})
dim = [.15 .6 .3 .3];
str = {'Slope: 1.4424'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

subplot(2,1,2)
plot(ubcanomaly, MEI, 'ko', ubcanomaly, T3pred, 'r-')
xlabel({'UBC Temperature';'Anomaly (degrees C)'})
ylabel({'Multivariate';'ENSO Index'})
dim = [.15 .13 .3 .3];
str = {'Slope: 0.2355'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
