clear
clc

%%% generating data %%%
[num text all]=xlsread('lab3_data.xlsx')

%%% converting data to variable vectors %%%
datevec = num(:,1);
ubcanomaly = num(:,2);
globalanomaly = num(:,3);

%%%initialize vectors %%%
datevector = [];
ubcslopes = [];
ubcintervals = [];
globalslopes = [];
globalintervals = [];
row = 0;

for year = 1950:10:2016
    row = row + 1;
    %%% mask to grab decade data %%%
    decademask = datevec < (year+10) & datevec >= year;
    decadedate = datevec(decademask);
    decadetemp1 = ubcanomaly(decademask);
    decadetemp2 = globalanomaly(decademask);
    
    %%% linear regression %%%
    X1 = [ones(size(decadedate)) decadedate];
    X2 = [ones(size(decadedate)) decadedate];

    [R1, bint1, q1, qint1, stats1] = regress(decadetemp1, X1)
    [R2, bint2, q2, qint2, stats2] = regress(decadetemp2, X2)

    T1pred = X1*R1;
    T2pred = X2*R2;
    
    slope1 = R1(2,1);
    slope2 = R2(2,1);
    interval1 = bint1(2,:);
    interval2 = bint2(2,:);
    
    datevector(row, :) = year;
    ubcslopes(row, :) = slope1;
    globalslopes(row, :) = slope2;
    ubcintervals(row, :) = interval1;
    globalintervals(row, :) = interval2;
end 



    