A = load('Litecoin_close_Data-2013-2021.txt');
B = load('Litecoin_Open_Data-2013-2021.txt');
C = load('Litecoin_Dates_Data.txt');

AA = load('close_Data_2013_2018.txt');
BB = load('open_Data_2013_2018.txt');

StartDate = datetime('3/30/2017');
EndDate = datetime('7/6/2021');
DateRange = StartDate:EndDate;

sampleTime = 1; % time between mesaurements 
IDdata = iddata(A(1400:end),[],sampleTime,'OutputName',{''},'TimeUnit','Days');
trend = getTrend(IDdata,0); 
IDdata = detrend(IDdata,0);
modelOrder = 5;

opt = arOptions('Approach','ls','Window','ppw');
sys = ar(IDdata,5,opt);

numSamples = 2991;
[yf,x0,sysf,yf_sd,x,x_sd] = forecast(sys,IDdata,numSamples);
IDdata = retrend(IDdata,trend);
yf = retrend(yf,trend);

figure;
UpperBound1 = iddata(yf.OutputData+1*yf_sd,[],yf.Ts,'Tstart',yf.Tstart,'TimeUnit','Days');
LowerBound = iddata(yf.OutputData-1*yf_sd,[],yf.Ts,'Tstart',yf.Tstart,'TimeUnit','Days');
plot(IDdata(:,:,[]),'r',yf(:,:,[]),'b');
hold on
plot(UpperBound1,'k--',LowerBound,'k--');
legend({'measured','forecasted','+/- 1 sd uncertainty'},'Location','best');
xlabel('From 3/30/17 - 7/1/2021');
ylabel('Price in USD');
title('Price Of Litecoin');

