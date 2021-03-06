cd /media/yuval/win_disk/Data/connectomeDB/MEG/433839/unprocessed/MEG/3-Restin/4D
cfg=[];
cfg.dataset='c,rfDC';
cfg.channel='MEG';
cfg.hpfilter='yes';
cfg.hpfreq=1;
cfg.hpfiltord=4;
cfg.demean='yes';
cfg.channel={'MEG','E2'};
cfg.trl=[1,ceil(2034.51*300),1];
data=ft_preprocessing(cfg);

load HBtimes
periods=60*diff(HBtimes);
pre=round(data.fsample*0.3); 
frequency=median(periods)*ones(1,size(data.trial{1},2));
HBs=round(data.fsample*HBtimes(1));
HBs1=round(data.fsample*HBtimes(2));
frequency(1:HBs1-pre)=periods(1);
for HBi=1:(length(HBtimes)-1)
    HBs=round(data.fsample*HBtimes(HBi));
    HBs1=round(data.fsample*HBtimes(HBi+1));
    frequency(HBs-pre:HBs1-pre)=periods(HBi);
end
frequency(HBs1-pre:end)=periods(end);

    
    
s1=1;s2=20345;
datain={};
datain.data(1,1,1,1:s2-s1+1)=data.trial{1}(248,s1:s2)*10^13;
datain.dt=1/data.fsample;

dataref={};
dataref{1}.dt=datain.dt; % seconds between MEG samples
dataref{1}.data=mean(data.trial{1}(1:248,s1:s2))*10^13;
dataref{1}.freqlist = 40:60; % beats per minute
dataref{1}.frequency=frequency(s1:s2);
dataref{1}.N=1;
dataref{1}.qr=0.5;
dataref{1}.downt=0.001;
dataout=drifter(datain,dataref);
figure;
plot(data.time{1}(s1:s2),squeeze(dataout.data),'k')
hold on
%plot(squeeze(datain.data),'y--')
plot(data.time{1}(s1:s2),squeeze(dataout.noise),'m')
plot(data.time{1}(s1:s2),squeeze(dataout.estimate),'g')
legend({'dataout.data','noise','estimate'})


figure;
plot(data.time{1}(s1:s2),dataref{1}.data)
hold on
plot(data.time{1}(s1:s2),squeeze(datain.data)-squeeze(dataout.noise),'g')



dataref={};
dataref.dt=datain.dt;
dataref.data=data.trial{1}(249,s1:s2);
dataref.freqlist = 45:50; % beats per minute
dataref.frequency=45:0.05:50;
dataout=drifter(datain,dataref);
figure;
plot(squeeze(dataout.data),'k')
hold on
plot(squeeze(dataout.noise),'m')
plot(squeeze(dataout.estimate),'g')
