B = load('Litecoin_close_Data-2013-2021.txt');
A = load('Litecoin_Open_Data-2013-2021.txt');
BB = load('close_Data_2013_2018.txt');
AA = load('open_Data_2013_2018.txt');
dates  = load('Litecoin_Dates_Data.txt');

z = A;
data1 = iddata(z,B,1,'TimeUnit','Days');
past_data = data1(1:1790);
future_data = data1.u(1791:end);
opt = polyestOptions('EnforceStability',true,'Display','on');
sys = polyest(data1,[2 2 2 0 0 1]);
K = 1201;
[yf,x0,sysf,yf_sd,x,x_sd] = forecast(sys,past_data,K,future_data);
UpperBound = iddata(yf.OutputData+3*yf_sd,[],yf.Ts,'Tstart',yf.Tstart);
LowerBound = iddata(yf.OutputData-3*yf_sd,[],yf.Ts,'Tstart',yf.Tstart);
figure;
plot(past_data(:,:,[]),yf(:,:,[]),UpperBound,'k--',LowerBound,'k--')
legend({'Measured','Forecasted','3 sd uncertainty'},'Location','best')

figure;
plot(A);

