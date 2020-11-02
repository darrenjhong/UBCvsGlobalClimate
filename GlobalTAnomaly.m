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
X1 = [ones(size(TSI)) TSI AOD CO2 SO2 MEI]
[R1, bint1, q1, qint1, stats1] = regress(globalanomaly, X1);

TSIslope = R1(2,1);
AODslope = R1(3,1);
CO2slope = R1(4,1);
SO2slope = R1(5,1);
MEIslope = R1(6,1);

TSIinterval = bint1(2,:);
AODinterval = bint1(3,:);
CO2interval = bint1(4,:);
SO2interval = bint1(5,:);
MEIinterval = bint1(6,:);

T1pred = X1*R1; 

%%% plot %%%
clf

plot(globalanomaly, T1pred, 'ko', globalanomaly, globalanomaly, 'r-')
xlabel({'Global Temperature';'Anomaly (degrees C)'})
ylabel({'Predicted Global Temperature';'Anomaly (degrees C)'})
dim = [.15 .55 .3 .3];
str = {'Coefficient of Determination: 0.8382'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');



