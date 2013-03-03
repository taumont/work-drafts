% ambPipeline

%% run SAM beamforming for M170
% creates dom and sub.mat files for every subject
% cov for the whole trial
% weights applied on the averaged data
ambFT([1:25]);

%% grand averaging
% it also has statistics after grand averaging, I don't know if this part works.
ambGrAvg(1:25)

%% statistics M170
% runs montecarlo. if stat exists already only plots the statistics.
[cfg1,probplot,cfg2,statplot]=ambMonte('M170','subp','domp',0.995);

% by cluster
%[cfg1,probplot,cfg2,statplot]=ambMonteClust('Clust','subp','domp',0.95);
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M170','subp','domp',0.95,0.01);
%% now for M350

% aplying global weights on averaged data for 235-390ms
ambSAMbyTimeWin([1:25],[0.235 0.39],'M350')

% grandaveraging
ambGrAvg1([1:25],'M350')

% statistics
[cfg1,probplot,cfg2,statplot]=ambMonte('M350','M350subp','M350domp',0.995)
% statistics by cluster
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M350','M350subp','M350domp',0.95,0.01);

%% M350 main effect for hemisphere
% merge sub and dom
ambMergeSources('M350','pow');
% get the pretrigger noise value
ambGrAvg1([1:25],'M350','noise');
% merge the two noise conditions
ambMergeSources('M350','noise');
% change noise field to pow
load M350domsubN
for subi=1:25;
    M350domsubN.trial(1,subi).pow=M350domsubN.trial(1,subi).noise;
    %[M350domsubN.trial(1,subi)]=rmfield(M350domsubN.trial(1,subi),'noise');
end
save M350domsubN M350domsubN %  I was unable to remove noise field, identical to pow now.
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M350_ME','M350domsubp','M350domsubN',0.95,0.01);

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl005_M350_ME','M350domsubp','M350domsubN',0.95,0.005);

%% masking
% create mask by:
% [source,intsource,grid,mesh]=makeMask('iskull');
% intsource1=intsource;
% cfg.keepindividual     = 'yes';
% cfg.parameter          = 'pow';
% Msk=ft_sourcegrandaverage(cfg,intsource,intsource1);
% inside=Msk.inside;outside=Msk.outside;
% save mask_innerskull inside outside
load /home/yuval/Data/amb/mask
% now there are masks for inner skull and cortex in ft_BIU/matlab/files
load M350domsubp
M350maskedp=M350domsubp;
M350maskedp.inside=inside;
M350maskedp.outside=outside;
save M350maskedp M350maskedp
load M350domsubN
M350maskedN=M350domsubN;
M350maskedN.inside=inside;
M350maskedN.outside=outside;
save M350maskedN M350maskedN

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl005_M350masked_ME','M350maskedp','M350maskedN',0.95,0.005);
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M350masked_ME','M350maskedp','M350maskedN',0.95,0.01);
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl025_M350masked_ME','M350maskedp','M350maskedN',0.95,0.025);
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl05_M350masked_ME','M350maskedp','M350maskedN',0.95,0.05);

load /home/yuval/Data/amb/mask
load subp %domp
subMskdp=subp;
subMskdp.inside=inside;
subMskdp.outside=outside;
save subMskdp subMskdp
load domp %domp
domMskdp=domp;
domMskdp.inside=inside;
domMskdp.outside=outside;
save domMskdp domMskdp
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M170masked_S_D','subMskdp','domMskdp',0.95,0.01);
% mask out of cortex voxels
% load /home/yuval/Data/amb/mask_cortex
% ctxdomp=domp;
% ctxsubp=subp;
% ctxdomp.inside=inside;
% ctxsubp.inside=inside;
% ctxdomp.outside=outside;
% ctxsubp.outside=outside;
% save ctxdomp ctxdomp
% save ctxsubp ctxsubp
% [cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M170ctx_S_D','ctxsubp','ctxdomp',0.95,0.01);

%% sources not interpolated
cd /home/yuval/Data/amb
ambSAMbyTimeWin(1:25,[0.15 0.235],'m170',0)
ambGrAvg1([1:25],'m170');
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_m170','m170subp','m170domp',0.95,0.01);
load sMRI
load Cl01_m170stat
load template_grid
stat.pos=template_grid.pos;
stat=rmfield(stat,'transform');
stat.unit='mm';
sMRI.unit='mm';
cfg10 = [];
cfg10.parameter = {'prob','stat'};
%cfg10.interpmethod  = 'spline';%'cubic' 'linear';
stat=ft_sourceinterpolate(cfg10,stat,sMRI);
save teststat stat
%[cfg1,probplot,cfg2,statplot]=ambMonteClust('test','m170subp','m170domp',0.95,0.01);
ambPlotStat('test',0.95,'surface'); % 'slice' 'surface' 'ortho';
ambPlotStat('test',0.95,'slice');
ambPlotStat('test',0.95,'ortho');

%% M170 main effect
ambMergeSources('','pow');
% get the pretrigger noise value
ambGrAvg1([1:25],'','noise');
% merge the two noise conditions
ambMergeSources('','noise');
% change noise field to pow
load domsubN
for subi=1:25;
    domsubN.trial(1,subi).pow=domsubN.trial(1,subi).noise;
    %[M350domsubN.trial(1,subi)]=rmfield(M350domsubN.trial(1,subi),'noise');
end
save domsubN domsubN %  I was unable to remove noise field, identical to pow now.
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M170_ME','domsubp','domsubN',0.95,0.01);

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl005_M170_ME','domsubp','domsubN',0.95,0.005);

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl001_M170_ME','domsubp','domsubN',0.95,0.001);

%% plot final
cd /home/yuval/Data/amb
ambPlotStat1('Cl025_M170masked_S_D',[0.95 0.98],'ortho',60); % RH
ambPlotStat1('Cl01_M350masked_ME',[0.7 1.5],'ortho',60); % RH
ambPlotStat1('Cl01_M350masked_ME',[0.7 1.5],'ortho',-50); % broca
ambPlotStat1('Cl01_M350masked_ME',[0.7 1.5],'ortho',-64); % Wernicke
% get mni coordinates, same but with crosshair on
ambPlotStatCHon('Cl025_M170masked_S_D',[0.95 0.98],'ortho',60); % RH
ambPlotStatCHon('Cl01_M350masked_ME',[0.7 1.5],'ortho',60); % RH
ambPlotStatCHon('Cl01_M350masked_ME',[0.7 1.5],'ortho',-50); % broca
ambPlotStatCHon('Cl01_M350masked_ME',[0.7 1.5],'ortho',-64); % Wernicke

cd /home/yuval/Dropbox/MEGpaper/files/matlab
plotFields


%% M170 main effect

[cfg1,probplot,cfg2,statplot]=ambMonteClust('M170sub_N_00025','subp','M350domsubN',0.95,0.00025);
[cfg1,probplot,cfg2,statplot]=ambMonteClust('M170dom_N_0025','domp','M350domsubN',0.95,0.0025);
cfg2.funcolorlim=[-10 10];
cfg2=rmfield(cfg2,'maskparameter')
ft_sourceplot(cfg2,statplot)

%% unrelated trials
ambUR(1:19)
ambUR20to25(20:25)
load /home/yuval/Data/amb/behav
[~,pACC,~,sACC]=ttest2(behav(:,1),behav(:,3))
[~,pRT,~,sRT]=ttest2(behav(:,2),behav(:,4))
mean([behav(:,2),behav(:,4)],1)
% run one run at a time
open ambCleanUR
% grand avging (and resampling 20-25)
lironGAur
cfg=[];
cfg.method='RMS';
cfg.neighbours='LR';
rmsD=clustData(cfg,Dur);
rmsS=clustData(cfg,Sur);

% plot BL uncorrected RMS
[figure1,figure2]=RMSfigureUR2;
%% Gosh, I had the unrelated all along
% load /home/yuval/Dropbox/MEGpaper/files/matlab/RMS_LR_2011
cd /home/yuval/Dropbox/MEGpaper/files/matlab
correctBL_RMS1
AreaBL1
load Area_2013_M170

%correct BL, same BL for all conditions
correctBL_RMS2
% change p (peak) inside
open Area_BL2
load /home/yuval/Dropbox/MEGpaper/files/matlab/Area_2013_M170_all
% move to statistica7

load /home/yuval/Dropbox/MEGpaper/files/matlab/RMS_2013_allConds1BL

time=-0.3:1/1017.25:0.7;
mLrmsBL=squeeze(mean(LrmsBL,3));
mRrmsBL=squeeze(mean(RrmsBL,3));

figure;
plot(time,mLrmsBL(:,[2,8]))
hold on
plot(time,mRrmsBL(:,[2,8]),'--')
title('RELATED')
legend('L D','L S','R D','R S')
ylim(1e-13*[-0.5 1.5])
figure
plot(time,mLrmsBL(:,[3,9]))
hold on
plot(time,mRrmsBL(:,[3,9]),'--')
title('UNRELATED')
legend('L D','L S','R D','R S')
ylim(1e-13*[-0.5 1.5])

figure;
plot(time,mLrmsBL(:,[2,3]))
hold on
plot(time,mLrmsBL(:,[8,9]),'--')
title('Left')
legend('D Re','D UR','S RE','S UR')
ylim(1e-13*[-0.5 1.5])
figure
plot(time,mRrmsBL(:,[2,3]))
hold on
plot(time,mRrmsBL(:,[8,9]),'--')
title('Right')
legend('D Re','D UR','S RE','S UR')
ylim(1e-13*[-0.5 1.5])

%% source loc unrelated
ambURsourceloc(1)
ambGrAvgURs(1:25)
