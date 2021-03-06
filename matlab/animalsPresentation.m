%% showing raw data

cd /home/yuval/Data/Amyg/1
A191=readChan('hb_c,rfhp0.1Hz','A191');
A247=readChan('/home/yuval/Data/Amyg/prerun1/c,rfhp0.1Hz','A247');
trig=readTrig_BIU('hb_c,rfhp0.1Hz')
trig=fixVisTrig(trig,300);

samp=[1.547e+05:1.73e+05];
t=samp./1017.25;
plot(t,A191(samp).*10^14)
hold on;plot(t,2*trig(samp),'k')
plot(t,smooth(0.6*A247(samp).*10^14,10)-300,'r')
legend('A190','Visual trigger','A247 (Heartbeats)')
%% select a channel and time
load /home/yuval/Data/MOI704/avg
cfg=[];
cfg.layout='4D248.lay';
cfg.interactive='yes';
ft_multiplotER(cfg,avg);
chani=ismember(avg.label,'A191')
A191=avg.avg(chani,:);

negi=find(A191(322:394)<0);
negi=negi+321;
figure;
plot(avg.time,A191);hold on;
plot(avg.time(negi),A191(negi),'r')
pad1=negi(1)-1;
pad0=pad1-length(negi)+1;
padi=pad0:pad1;
pad=zeros(size(negi));
plot(avg.time(padi),pad,'g')

%% template fit simulation
%load /home/yuval/Data/MOI704/temp
% tap=[1:9 8:-1:1];
% tapsh=tap(5:13);
temp=[0 1:5 4:-1:1 0];
x1=[0 0 0 0 0 0 0 0 0 temp 0 0 0 0 0 0 0 0 0];
%x2=[0 0 0 0 0 0 tap 0 0 0 0 0 0];
r=rand(size(x1));r=r-mean(r);
x=x1+r;


tapBlc = temp-mean(temp);
tmplt=tapBlc./sqrt(sum(tapBlc.*tapBlc));
[~,time0]=max(temp);
time1=length(tmplt)-time0;
SigX = nan(1,length(x));
TotX = SigX;SNR=SigX;sigSign=SigX;

ii = 6; %time0:(length(x)-time1);
y = x((ii-time0+1):ii+time1);
y = y-mean(y); % baseline correction
TotX(ii) = sum(y.*y);
proj = sum(y.*tmplt);
sigSign(ii)=proj/abs(proj);
SigX(ii) = proj*proj;
err = TotX(ii)-SigX(ii);
SNRbl = SigX(ii)/err;
snr=round(100.*SNRbl)/100;
figure;
subplot(3,2,1) % data and template
plot(x);hold on;
plot(temp,'r');
title('data and template')
ylim([-1 16])
subplot(3,2,2) % normalized data and template
plot(y.*tmplt,'k');
title('data x temp')
ylim([-1 4.5])
textbox(10,3,['SNR = ',num2str(snr)])


ii = 15; %time0:(length(x)-time1);
x3=3.*x1+r;
y = x3((ii-time0+1):ii+time1);
y = y-mean(y); % baseline correction
TotX(ii) = sum(y.*y);
proj = sum(y.*tmplt);
sigSign(ii)=proj/abs(proj);
SigX(ii) = proj*proj;
err = TotX(ii)-SigX(ii);
SNRbig = SigX(ii)/err;
snr=round(100.*SNRbig)/100;


subplot(3,2,5) % data and template
plot(x3);hold on;
plot(10:20,temp,'r');
%title('data and template')
ylim([-1 16])

subplot(3,2,6) % normalized data and template
plot(y.*tmplt,'k');
%title('data x temp')
ylim([-1 4.5])
textbox(10,3,['SNR = ',num2str(snr)])
ii = 15; %time0:(length(x)-time1);
y = x((ii-time0+1):ii+time1);
y = y-mean(y); % baseline correction
TotX(ii) = sum(y.*y);
proj = sum(y.*tmplt);
sigSign(ii)=proj/abs(proj);
SigX(ii) = proj*proj;
err = TotX(ii)-SigX(ii);
SNR = SigX(ii)/err;
snr=round(100.*SNR)/100;
subplot(3,2,3) % data and template
plot(x);hold on;
plot(10:20,temp,'r');
%title('data and template')
ylim([-1 16])
subplot(3,2,4) % normalized data and template
plot(y.*tmplt,'k');
%title('data x temp')
ylim([-1 4.5])
textbox(10,3,['SNR = ',num2str(snr)])


figure;
plot(y)
hold on
plot(tmplt,'r')

[SNR2,SigX2]=fitTemp(x,tmplt,time0);
figure;
plot(SNR2)

%% show SNR trace
cd /home/yuval/Data/Amyg/1
temp=[0:50 49:-1:0];
[~,time0]=max(temp);
tempBlc = temp-mean(temp);
tmplt=tempBlc./sqrt(sum(tempBlc.*tempBlc));
A191=readChan('hb_c,rfhp0.1Hz','A191');
x=(A191(1,500:500+1018));
[SNR,~,sign]=fitTemp(x,tmplt,time0);
figure; plot(SNR+0.3)
hold on;
plot(SNR.*sign-0.3,'k');
plot(x.*1e+12-1,'r')

legend('SNR','Signed SNR','MEG')
title('101 samples template (100ms)')

%% show freq_analysis

load /home/yuval/Data/Amyg/1/TF100
cfg=[];
cfg.layout='4D248.lay';
ft_multiplotTFR(cfg,TF)
figure;
plot(TF.time,squeeze(mean(TF.powspctrm(:,22,1,:),1)))
title('average SNR trace for A191 100ms (10Hz) template')

%% plot peak distribution
cd /home/yuval/Data/Amyg/1
load datacln;
cfg              = [];
cfg.keeptrials = 'yes';
cfg.output       = 'pow';
cfg.channel      = 'A191';
cfg.method       = 'mtmconvol';
cfg.foi          = 10;    % freq of interest
cfg.t_ftimwin    = 1./cfg.foi;
cfg.toi          = -0.2:0.001:0.5;
cfg.tapsmofrq  = 1;
cfg.trials='all';%[1:2];
cfg.tail=[]; % pad the template with zeros, 'beg' 'end' 'both' or [] for no padding
[TF,wlt] = freqanalysis_triang_temp(cfg, datacln);

peaks=peaksInTrials1freq(TF,wlt);

[~,chani]=ismember('A191',peaks.label);
post=[];negt=[];
for ti=1:length(peaks.chan{1,chani}.trial)
    try
        post=[post,peaks.chan{1,chani}.trial{1,ti}.time(1,peaks.chan{1,chani}.trial{1,ti}.SNR>0)];
    end
    try
        negt=[negt,peaks.chan{1,chani}.trial{1,ti}.time(1,peaks.chan{1,chani}.trial{1,ti}.SNR<0)];
    end
end

figure;hist(post,50);
h1 = findobj(gca,'Type','patch');
set(h1,'FaceColor','r')
hold on;
hist(negt,50);
legend ('pos','neg')
title('Count of Peaks by time bins')

figure;
plot(post,'r.')
hold on
plot(length(post)+1:length(post)+length(negt),negt,'.')

cfg              = [];
cfg.keeptrials = 'yes';
cfg.output       = 'pow';
cfg.channel      = 'A191';
cfg.method       = 'mtmconvol';
cfg.foi          = 20;    % freq of interest
cfg.t_ftimwin    = 1./cfg.foi;
cfg.toi          = -0.2:0.001:0.5;
cfg.tapsmofrq  = 1;
cfg.trials='all';%[1:2];
cfg.tail='beg'; % pad the template with zeros, 'beg' 'end' 'both' or [] for no padding
[TF,wlt] = freqanalysis_triang_temp(cfg, datacln);


peaks=peaksInTrials1freq(TF,wlt);

[~,chani]=ismember('A191',peaks.label);
post=[];negt=[];
for ti=1:length(peaks.chan{1,chani}.trial)
    try
        post=[post,peaks.chan{1,chani}.trial{1,ti}.time(1,peaks.chan{1,chani}.trial{1,ti}.SNR>0)];
    end
    try
        negt=[negt,peaks.chan{1,chani}.trial{1,ti}.time(1,peaks.chan{1,chani}.trial{1,ti}.SNR<0)];
    end
end

figure;hist(post,50);
h1 = findobj(gca,'Type','patch');
set(h1,'FaceColor','r')
hold on;
hist(negt,50);
legend ('pos','neg')
title('Count of Peaks by time bins')

figure;
plot(post,'r.')
hold on
plot(length(post)+1:length(post)+length(negt),negt,'.')
xlabel ('peaks in all trials')
ylabel('time(S)')

%% show M100 issue

cd('/home/yuval/Data/Amyg/1');
load win
load peaks
[~,chani]=ismember('A191',peaks.label);
pos100=peakSorter('A191',peaks,win100,ones(length(peaks.chan{1,chani}.trial),1),'pos','biggest','noWlts');
% pos100=peakSorter(chP,peaks,win100,ones(length(peaks.chan{1,chani}.trial),1),'pos','biggest');
%figure;hist(pos100.cond1pos.timewin{1,1}(:,4))
trials=1:length(peaks.chan{1,1}.trial);
trialsM100=pos100.cond1pos.timewin{1,1}(:,1);
trialsNoM100=trials(setxor(trialsM100,1:length(trials)))';
load datacln
minN=min(length(trialsM100),length(trialsNoM100)); % to compare equal num of trials
cfg=[];
cfg.trials=trialsM100(1:minN);
M100=ft_timelockanalysis(cfg,datacln);
cfg.trials=trialsNoM100(1:minN);
noM100=ft_timelockanalysis(cfg,datacln);

cfg=[];
cfg.channel='A191';
figure;ft_singleplotER(cfg,M100,noM100);


load /home/yuval/Data/Amyg/peakM100A191
chP='A191';timewin=[0.075 0.135];
load /home/yuval/Data/Amyg/A191Alpha
subi= 1;
sub=num2str(subi);
cd(['/home/yuval/Data/Amyg/',sub]);
subFreq=freqs(subi);
subWin=round(1000/subFreq)./1000;
load peaks
t100=peakM100(subi,3);
halfWin=0.015;
tbeg=t100-halfWin-subWin;
tend=t100+halfWin-subWin;
timewindow=[tbeg tend];
chP='A191';
[~,chani]=ismember(chP,peaks.label);
pos100=peakSorter(chP,peaks,timewindow,ones(length(peaks.chan{1,chani}.trial),1),'pos','biggest','noWlts');
neg100=peakSorter(chP,peaks,timewindow,ones(length(peaks.chan{1,chani}.trial),1),'neg','biggest','noWlts');
trials=1:length(peaks.chan{1,1}.trial);
trialsM100=pos100.cond1pos.timewin{1,1}(:,1);
trialsNoM100=neg100.cond1neg.timewin{1,1}(:,1);
load datacln
minN=min(length(trialsM100),length(trialsNoM100)); % to compare equal num of trials
cfg=[];
cfg.trials=trialsM100(1:minN);
M100=ft_timelockanalysis(cfg,datacln);
cfg.trials=trialsNoM100(1:minN);
noM100=ft_timelockanalysis(cfg,datacln);
cfg=[];
cfg.channel=chP;
figure;
subplot(1,2,1)
plot(M100.time,M100.avg(chani,:));
hold on
plot(M100.time,noM100.avg(chani,:),'r');
ylim([-7e-13 7e-13])
legend('positive peaks','negative peaks');
xp=M100.avg(chani,:);xn=noM100.avg(chani,:);
subplot(1,2,2)
plot(M100.time,(xp-xn)./2)
hold on;plot(M100.time,(xp+xn)./2,'r')
legend('(positive-negative)/2','(positive+negative)/2');

%% compare conditions, M250
cd /home/yuval/Data/Amyg/1
load datacln
cfg              = [];
cfg.keeptrials = 'yes';
cfg.output       = 'pow';
cfg.channel      = 'A191';
cfg.method       = 'mtmconvol';
cfg.foi          = 20;    % freq of interest
cfg.t_ftimwin    = 1./cfg.foi;
cfg.toi          = -0.2:0.001:0.5;
cfg.tapsmofrq  = 1;
cfg.trials='all';%[1:2];
cfg.tail=[]; % pad the template with zeros, 'beg' 'end' 'both' or [] for no padding
[TF,wlt] = freqanalysis_triang_temp(cfg, datacln);


peaks=peaksInTrials1freq(TF,wlt);
chP='A191';[~,chani]=ismember(chP,peaks.label);
posPeaks=peakSorter(chP,peaks,[0.08 0.13;0.2 0.3],datacln.trialinfo,'pos','earliest','noWlts');


[~,chani]=ismember(chP,datacln.label);
%amp=datacln.trialinfo;
halfWin=2;snrThr=0.8;
trialinfo=ampLatByCond(datacln.trialinfo,posPeaks,2,datacln,chani,halfWin,snrThr);

trialinfoNoNaN=trialinfo(find(~isnan(trialinfo(:,2))),:);
animals=trialinfoNoNaN(trialinfoNoNaN(:,1)==100,2:3);
landscape=trialinfoNoNaN(trialinfoNoNaN(:,1)==102,2:3);
fruits=trialinfoNoNaN(trialinfoNoNaN(:,1)==104,2:3);
vehicles=trialinfoNoNaN(trialinfoNoNaN(:,1)==106,2:3);

anN=sum(trialinfo(:,1)==100);ann=sum(trialinfoNoNaN(:,1)==100);
laN=sum(trialinfo(:,1)==102);lan=sum(trialinfoNoNaN(:,1)==102);
frN=sum(trialinfo(:,1)==104);frn=sum(trialinfoNoNaN(:,1)==104);
veN=sum(trialinfo(:,1)==106);ven=sum(trialinfoNoNaN(:,1)==106);
anR=ann/anN;
allR=(lan+frn+ven)/(laN+frN+veN);
binomStat(anN,ann,allR)

[~,p,~,stat]=ttest2(animals(:,2),landscape(:,2)); % latency
[~,p,~,stat]=ttest2(animals(:,1),landscape(:,1)); % amplitude
[~,p,~,stat]=ttest2(animals(:,2),vehicles(:,2));
[~,p,~,stat]=ttest2(animals(:,2),fruits(:,2));
all=[landscape(:,2);fruits(:,2)];
[~,p,~,stat]=ttest2(animals(:,2),all)

X1=animals(:,2);X2=landscape(:,2);X3=fruits(:,2);X4=vehicles(:,2);
X=[X1;X2;X3;X4];
g1=ones(size(X1));g2=2*ones(size(X2));g3=3*ones(size(X3));g4=4*ones(size(X4));
group=[g1;g2;g3;g4];
[p,table,stats] = anova1(X,group,'on')


figure;
plot(animals(:,2),'r.');
hold on;
plot(landscape(:,2),'g.')
legend('animals','landscape')
figure;
plot(animals(:,1),'r.');
hold on;
plot(landscape(:,1),'g.')
legend('animals','landscape')



cfg=[];
cfg.channel='A191';
cfg.trials=find(datacln.trialinfo(:,1)==100);
anim=ft_timelockanalysis(cfg,datacln);
cfg.trials=find(datacln.trialinfo(:,1)==102);
land=ft_timelockanalysis(cfg,datacln);
cfg.trials=find(datacln.trialinfo(:,1)==104);
frui=ft_timelockanalysis(cfg,datacln);
cfg.trials=find(datacln.trialinfo(:,1)==106);
vehi=ft_timelockanalysis(cfg,datacln);
ft_singleplotER([],anim,land,frui,vehi)
legend('animals','landscape','fruits','vehicles')
plot(mean(animals(:,2)),0,'o')
plot(mean(landscape(:,2)),0,'ro')
plot(mean(vehicles(:,2)),0,'ko')
plot(mean(fruits(:,2)),0,'go')

%% M170

negPeaks=peakSorter(chP,peaks,[0.14 0.24],datacln.trialinfo,'neg','biggest','noWlts');

[~,chani]=ismember(chP,datacln.label);
%amp=datacln.trialinfo;
halfWin=2;snrThr=0.9;
trialinfo=ampLatByCond(datacln.trialinfo,negPeaks,1,datacln,chani,halfWin,snrThr);

trialinfoNoNaN=trialinfo(find(~isnan(trialinfo(:,2))),:);
animals=trialinfoNoNaN(trialinfoNoNaN(:,1)==100,2:3);
landscape=trialinfoNoNaN(trialinfoNoNaN(:,1)==102,2:3);
fruits=trialinfoNoNaN(trialinfoNoNaN(:,1)==104,2:3);
vehicles=trialinfoNoNaN(trialinfoNoNaN(:,1)==106,2:3);

anN=sum(trialinfo(:,1)==100);ann=sum(trialinfoNoNaN(:,1)==100);
laN=sum(trialinfo(:,1)==102);lan=sum(trialinfoNoNaN(:,1)==102);
frN=sum(trialinfo(:,1)==104);frn=sum(trialinfoNoNaN(:,1)==104);
veN=sum(trialinfo(:,1)==106);ven=sum(trialinfoNoNaN(:,1)==106);
anR=ann/anN;
allR=(lan+frn+ven)/(laN+frN+veN);
binomStat(anN,ann,allR)


y=trialinfoNoNaN(:,3);
wts=ones(length(y),1);
x=1:length(y);
x=[wts,x'];
[b,bint,r,rint,stats] = regress(y,x)
plot(y)