clear
clc

%%% generating data %%%
[num text all]=xlsread('lab3_data.xlsx')

%%% converting data to variable vectors %%%
datevec = num(:,1);
ubcanomaly = num(:,2);
globalanomaly = num(:,3);

%%% mask NaN from ubcanomaly %%%
ubcanomaly(isnan(ubcanomaly)) = -999; 
datamask = ubcanomaly ~= -999;
maskedubc = ubcanomaly(datamask);

%%% mask same values out from globalanomaly %%%
maskedglobal = globalanomaly(datamask);

%%% correlation coefficient %%%
[R, p] = corrcoef(maskedubc, maskedglobal);

%%% plot %%%
clf

plot(maskedubc, maskedglobal, 'ro')
xlabel({'UBC Temperature';'Anomaly (degrees C)'})
ylabel({'Global Temperature';'Anomaly (degrees C)'})
dim = [.15 .6 .3 .3];
str = {'Correlation Coefficient: 0.3738','p-value: 1.78786254334773e-24'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');