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

%{
%%% masking NaN %%%
ubcanomaly(isnan(ubcanomaly)) = -999;
datamask = ubcanomaly ~= -999;
maskedtemp = ubcanomaly(datamask);
maskeddate = datevec(datamask);
%}
%{
%%% correlation coefficient %%%
[R1, p1] = corrcoef(maskeddate, maskedtemp)
[R2, p2] = corrcoef(datevec, globalanomaly)
%}

%%% linear regression %%%
X1 = [ones(size(datevec)) datevec];
X2 = [ones(size(datevec)) datevec];

[R1, bint1, q1, qint1, stats1] = regress(ubcanomaly, X1)
[R2, bint2, q2, qint2, stats2] = regress(globalanomaly, X2)

T1pred = X1*R1;
T2pred = X2*R2;

%%% masks for histograms %%%
mask1 = datevec <= 1985;
mask2 = datevec > 1985;

%%% subplotting %%%
clf
figure(1)

subplot(4,2,1)
plot(datevec, ubcanomaly, datevec, T1pred)
xlabel('Time')
ylabel({'UBC Temperature';'Anomaly (degrees C)'})
title('UBC Temperature Anomaly (degrees C)vs. Time')
dim = [.32 .52 .3 .3];
str = {'Slope: 0.01955 degrees C/year','Coefficient of Determination: 0.06981'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

subplot(4,2,2)
plot(datevec, globalanomaly, datevec, T2pred)
xlabel('Time')
ylabel({'Global Temperature';'Anomaly (degrees C)'})
title('Global Temperature Anomaly (degrees C) vs. Time')
dim = [.765 .52 .3 .3];
str = {'Slope: 0.01175 degrees C/year','Coefficient of Determination: 0.6713'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

subplot(4,2,3)
plot(datevec, TSI)
xlabel('Time')
ylabel({'Total Solar';'Irradiance (W/m^2)'})
title('Total Solar Irradiance (W/m^2) vs. Time')


subplot(4,2,4)
plot(datevec, AOD)
xlabel('Time')
ylabel({'Global Mean Stratospheric';'Aerosol Optical Depth'})
title('Global Mean Stratospheric Aerosol Optical Depth vs. Time')

subplot(4,2,5)
plot(datevec, CO2)
xlabel('Time')
ylabel({'Atmospheric CO2';'Concentration (ppm)'})
title('Atmospheric CO2 Concentration (ppm) vs. Time')

subplot(4,2,6)
plot(datevec, CO2)
xlabel('Time')
ylabel({'Atmospheric SO2';'emissions (Tg/year)'})
title('Atmospheric SO2 emissions (Tg/year) vs. Time')

subplot(4,2,7)
plot(datevec, MEI)
xlabel('Time')
ylabel({'Multivariate';'ENSO Index'})
title('Multivariate ENSO Index vs. Time')

%%% plotting histograms %%%
figure(2)

subplot(2,1,1)
histogram(ubcanomaly(mask1),linspace(min(ubcanomaly),max(ubcanomaly), 150), 'Normalization', 'probability')
xlabel('Frequency')
ylabel({'Temperature (degrees C)'})
title('UBC Temperature Anomaly')
hold on 
histogram(ubcanomaly(mask2),linspace(min(ubcanomaly),max(ubcanomaly), 150), 'Normalization', 'probability')
legend('1985 and Before', 'After 1985')

subplot(2,1,2)
histogram(globalanomaly(mask1),linspace(min(globalanomaly),max(globalanomaly), 250), 'Normalization', 'probability')
xlabel('Frequency')
ylabel({'Temperature (degrees C)'})
title('Global Temperature Anomaly')
hold on
histogram(globalanomaly(mask2),linspace(min(globalanomaly),max(globalanomaly), 250), 'Normalization', 'probability')
legend('1985 and Before', 'After 1985')