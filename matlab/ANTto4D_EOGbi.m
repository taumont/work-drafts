function ANTto4D_EOGbi(eegFN,run,megFN,method,segBegSamp)
% mergeEegMeg
% cd to where the eeg data is. there should be run folders with meg: 1,2...

% method='first2'; % first1 first2 last1 last2 firstAndLast2
% run='3';
% megFN='c,rfhp1.0Hz';
% segBegSamp=[1,round((10*60+29.038)*1024),round((23*60+44.578)*1024),round((36*60+28.374)*1024)];

hdrMEG=ft_read_header([run,'/',megFN]);
hdrEEG=ft_read_header(eegFN);
srEeg=hdrEEG.Fs;
srMeg=hdrMEG.Fs;



if ~exist('segBegSamp','var')
    segBegSamp=1;
end



% choose method of syncing
% first2 = first matched pair, last2 = last matched pair, firstAndLast2 =
% calculate sr based on trigger matching
% FIXME: needs detection of wrong matches in samp.

if ~exist('eeg.mat','file')
    cfg=[];
    cfg.demean='yes';
    cfg.bpfilter='yes';
    cfg.channel = {'HEOG','VEOG'};
    cfg.bpfreq=[1 100];
    eeg=readCNT(cfg);
    display('saving eeg ft structure')
    save eeg eeg
else   
    display('loading eeg.mat')
    load eeg.mat
end

if ~exist('events.mat','file')
    evt=readTrg;
    events=evt(find(evt(:,3)==1),1); %#ok<FNDSB>
    % events is the time in which the .trg file had event value 1
    save events events
else
    load events
end

if ~exist([run,'/samp.mat'],'file')
    evt1017=round(events*1017.25);
    display('reading trig')
    trig=readTrig_BIU([run,'/',megFN]);
    TRIG=bitand(uint16(trig),1024);
    if isempty(find(TRIG,1))
        TRIG=bitand(uint16(trig),4096);
    end
    trigSh=TRIG(2:end);trigSh(end+1)=0;
    onset=find(trigSh-TRIG>0);onset=onset+1;
    % onset is the sample in which the MEG trig had 1024 onset
    samp=findEegMegSamp(onset,evt1017);
    
    if isempty(samp)
        error('no match found, samp is empty')
    end
    save([run,'/samp'],'samp')
else
    load ([run,'/samp'])
end
%%
switch method
    case 'first2'
        t1=events(samp(1,3));
        s1eeg=nearest(eeg.time{1,1},t1);
        s1meg=samp(1,2);
    case 'last2'
        t1=events(samp(end,3));
        s1eeg=nearest(eeg.time{1,1},t1);
        s1meg=samp(end,2);
    case 'firstAndLast2'
        t1=events(samp(1,3));
        t2=events(samp(end,3));
        s1meg=samp(1,2);
        s2meg=samp(end,2);
        s1eeg=nearest(eeg.time{1,1},t1);
        s2eeg=nearest(eeg.time{1,1},t2);
        srEeg=(s2eeg-s1eeg)/(t2-t1);
        if ~srEeg==1024
            error('eeg sampling rate should be 1024, please check')
        end
        srMeg=(s2meg-s1meg)/(t2-t1);
        if ~round(srMeg)==1017
            error('MEG sr should be about 1017')
        end
        eval(['!echo run ',run,' MEG sr = ',num2str(srMeg),' >> LOGsr.txt'])
end
% s1eeg=nearest(eeg.time{1,1},t1);
% s1meg=samp(1,2);
segNum=find(segBegSamp<s1eeg,1);

t0eeg=(segBegSamp(segNum)-s1eeg-1)/srEeg;
t0meg=-s1meg/srMeg;
% find nearest eeg sample
timediff=t0meg-t0eeg;
rsEEG = resampEEG4MEG(eeg.trial{1,1},timediff,srEeg,srMeg,hdrMEG.nSamples);


rsEEG=rsEEG./1000; % from mV to V
%baseline correction for the first 10s
m=mean(rsEEG(:,1:10240),2);
mMat=repmat(m,1,size(rsEEG,2));
rsEEG=rsEEG-mMat;
if ~exist([run,'/','rsEEG'],'file')
    save ([run,'/','rsEEG'],'rsEEG')
end

%% comparing eeg and meg
% 
% EOG=ft_preprocessing(cfg);
% 
% ECG = ECG.trial{1,1};
% 
% cfg.channel = {'MEG'};
% meg=ft_preprocessing(cfg);
% time=meg.time{1,1};
% megECG=mean(meg.trial{1,1});
% clear meg
% % check sync of EEG and MEG
% figure;
% plot(time,ECG/max(abs(ECG)),'g');hold on;plot(time,megECG/max(abs(megECG)))
% legend('ECG', 'mean MEG')
% 
% corrEcgMeg = corrcoef(ECG(1:10000), megECG(1:10000));
% 
