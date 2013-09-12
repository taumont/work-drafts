

%% exploring results
% evoked response

open aliceExplore
open aliceExplore20

open aliceStatExplore1



%% subject by subject
subfolder='mark';
alice2(subFolder);
aliceReduceAvg(subFolder);
aliceAlpha(subFolder);
aliceWbW(subFolder);

%% run all
sf={'idan'  'inbal'  'liron'  'maor'  'odelia'	'ohad'  'yoni' 'mark'};
for i=1:length(sf)
    % alice2(sf{i});
    % aliceReduceAvg(sf{i});
    % aliceAlpha(sf{i});
    aliceWbW(sf{i});
    %     cd(sf{i})
    %     movefile('files/topo*','files/prev/')
    %movefile('files/prev/seg*','files/')
%     cd ..
end

%% find timing of components
open aliceCompLimSub
% max([EEG,MEG]) to min([EEG,MEG])
comps=aliceCompLimSub2;
%% calculating area
aliceTables
aliceTables('LR');
aliceTables('Post');
aliceTables('PostLR');
% ci=1 for N100, 2 for N170, 3 for M100, 4 for M170
% test tamil effect for N100, whole head rms.
[p,stats,X]=aliceStats(1,'z','tablesPost','tamil')
[p,stats,X]=aliceStats(3,'z','tablesPost','tamil')
[p,stats,X]=aliceStats(1,'z','tablesWH','loud')
[p,stats,X]=aliceStats(2,'z','tablesR','loud','U')
[p,stats,X]=aliceStats(1,'z','tablesPost','WBW')
[p,stats,X]=aliceStats(3,'z','tablesPost','WBW')
[p,stats,X]=aliceStats(2,'z','tablesPost','WBW')
[p,stats,X]=aliceStats(1,'z','tablesWH')
[p,stats,X]=aliceStats(1,'','tablesLR')

[p,stats,X]=aliceStats(1,'z','tablesPost','tamil','U')
[p,stats,X]=aliceStats(3,'z','tablesPost','tamil','U')
[p,stats,X]=aliceStats(1,'z','tablesWH','loud','U')

%% LR
aliceLR
aliceLR1('alice')
aliceGA('LR')
aliceGA('LRalice')
aliceLR1('6101820')
cd /home/yuval/Copy/MEGdata/alice/ga
stat=statPlot('GavgE10LR','GavgE8_12LR',[0.17 0.17],[],'paired-ttest') % tamil
stat=statPlot('GavgE10LR','GavgE8_12LR',[0.1 0.1],[],'paired-ttest')
stat=statPlot('GavgE20LR','GavgE2_4LR',[0.1 0.1],[],'paired-ttest') % WbW
stat=statPlot('GavgE20LR','GavgE2_4LR',[0.17 0.17],[],'paired-ttest')
stat=statPlot('GavgE18LR','GavgE16LR',[0.17 0.17],[],'paired-ttest')
stat=statPlot('GavgM18LR','GavgM16LR',[0.17 0.17],[],'paired-ttest')
stat=statPlot('GavgM10LR','GavgM8_12LR',[0.17 0.17],[],'paired-ttest') % tamil

%stat=statPlot('GavgM10LR','GavgM8_12LR',[0.17 0.17],[],'paired-ttest') % tamil
load /home/yuval/Copy/MEGdata/alice/ga/GavgEaliceLR.mat
load /home/yuval/Copy/MEGdata/alice/ga/GavgMaliceLR.mat
cfg=[];
cfg.layout='4D248.lay';
cfg.xlim=[0.17 0.17];
figure;
ft_topoplotER(cfg,GavgMaliceLR)
cfg=[];
cfg.layout='WG32.lay';
cfg.xlim=[0.17 0.17];
figure;
ft_topoplotER(cfg,GavgEaliceLR)

aliceTtest0('GavgMaliceLR',0.17,0);

aliceTtest0('GavgMaliceLR',0.17,1);

aliceTtest0('GavgM20LR',0.17,1); % Word bt Word
aliceTtest0('GavgM20LR',0.1,1);
aliceTtest0('GavgE20LR',0.17,1);
aliceTtest0('GavgE20LR',0.1,1);

%% Freq LR differences
aliceGA('frLR')
aliceGA('frLRalice')
aliceGA('frLRrest')
aliceGA('frLRwbw')


stat=statPlot('GavgFrM20LR','GavgFrMrestLR',[9 9],[-3e-27 3e-27],'paired-ttest') % rest
stat=statPlot('GavgFrM20LR','GavgFrMaliceLR',[9 9],[-3e-27 3e-27],'paired-ttest') % rest


stat=statPlot('GavgFrM2LR','GavgFrM100LR',[10 10],[-3e-27 3e-27],'paired-ttest') % rest
aliceTtest0('GavgFrM100LR',10,1);

open aliceStatExplore

%% Fr differences
aliceGA('fr')
aliceGA('frAlice')
aliceGA('frRest')



stat=statPlot('GavgFrMrest','GavgFrMalice',[9 9],[0 1e-26],'paired-ttest')
stat=statPlot('GavgFrErest','GavgFrEalice',[9 9],[0 5],'paired-ttest')
stat=statPlot('GavgFrM20','GavgFrMrest',[9 9],[0 1e-26],'paired-ttest')

stat=statPlot('GavgFrM8','GavgFrM10',[10 10],[0 1e-26],'paired-ttest') 
stat=statPlot('GavgFrM102','GavgFrM100',[9 9],[0 1e-26],'paired-ttest') 
stat=statPlot('GavgFrE100','GavgFrE2',[9 9],[0 5],'paired-ttest')
stat=statPlot('GavgFrErest','GavgFrE2',[9 9],[0 5],'paired-ttest')
%% coh
aliceGA('coh')
stat=statPlot('GavgCohM10','GavgCohMalice',[9 9],[0 1],'paired-ttest')
stat=statPlot('GavgCohE10','GavgCohEalice',[9 9],[0 1],'paired-ttest')
stat=statPlot('GavgCohMrest','GavgCohMalice',[9 9],[0 1],'paired-ttest')

%% N400
aliceTtest0('GavgEaliceLR1',0.36,1);
aliceTtest0('GavgMaliceLR1',0.36,1);
alicePlotLR(0.36)

alicePlotLR(0.17)
% see plotN400.m



%% old

alice1('maor')

alice1('yoni',1);
aliceReduceAvg('maor')
aliceAlpha('maor')

subFolder={'yoni','idan','liron'};
for i=1:3
    sf=subFolder{i};
    aliceReduceAvg(sf)
    aliceAlpha(sf)
end

aliceWbW('liron')

aliceTables('maor') % blink issues with speach paragraph

subFolder='odelia';
alice1(subFolder);
aliceReduceAvg(subFolder)
aliceAlpha(subFolder)
aliceWbW(subFolder)

open alicePlots

open aliceTestCompLimMethod

open aliceCompLimSub
% 
% times=findCompLims('rms',[],avgE2);
% timeCourse=findCompLims('yzero',[],avgE2,avgE4,avgE6,avgE8,avgE10,avgE12,avgE14,avgE16,avgE18);
% timeCourseO=findCompLims('yzero',{'O1','O2','Oz'},avgE2,avgE4,avgE6,avgE8,avgE10,avgE12,avgE14,avgE16,avgE18);
% timeCourseO=findCompLims('absMean',{'O1','O2','Oz'},avgE2,avgE4,avgE6,avgE8,avgE10,avgE12,avgE14,avgE16,avgE18);

%% source loc
cd /home/yuval/Copy/MEGdata/alice
sf={'idan'  'inbal'  'liron'  'maor'  'odelia'	'ohad'  'yoni' 'mark'};
% prepare folders and stuff
for subi=1:8
    copyfile('~/SAM_BIU/docs/SuDi0812.rtw',['/home/yuval/Copy/MEGdata/alice/',sf{subi},'/',sf{subi},'.rtw'])
end
aliceMarkers
% SAM
for subi=1:8
    cd(['/home/yuval/Copy/MEGdata/alice/',sf{subi}])
    fn=ls('xc*');
    fn=fn(1:end-1);
    cd ..
    if ~exist([sf{subi},'/SAM/general,3-35Hz/alla.cov'],'file')
        eval (['!SAMcov64 -r ',sf{subi},' -d ',fn,' -m general -v'])
    end
    if ~exist([sf{subi},'/hull.shape'],'file')
        copyfile ([sf{subi},'/MRI/hull.shape'],[sf{subi},'/'])
    end
    if ~exist([sf{subi},'/SAM/general,3-35Hz,alla.wts'],'file')
        eval (['!SAMwts64 -r ',sf{subi},' -d ',fn,' -m general -c alla -v'])
    end
end

% estimate noise by weights and by weights+noisecov
aliceNoiseEstimate(sf)
% move mri to tlrc
% !@auto_tlrc -base ~/SAM_BIU/docs/temp+tlrc -input ortho+orig -no_ss
% make images
load /home/yuval/Copy/MEGdata/alice/ga/GavgMalice
aliceImage(GavgMalice,[0.0885 0.0885],'alice089') % NOTE COMMENT BELOW
aliceImage(GavgMalice,[0.179 0.179],'alice179')
aliceImage(GavgMalice,[-0.2 -0.1],'noise')
aliceImage(GavgMalice,[0.210 0.210],'alice210')

% RUN ./alice2tlrc after every line above

aliceAvgTlrc('alice179')
aliceAvgTlrc('alice089')
aliceAvgTlrc('alice210')
aliceAvgTlrc('noise')

!~/abin/afni -dset ~/SAM_BIU/docs/temp+tlrc &

% compare left - right voxels

aliceLRtlrc('alice210',1)




% ttest
setA='-setA r1 ';
for subi=1:8
    setA=[setA,sf{subi},'r1 alice210LRdif_',num2str(subi),'+tlrc '];
end
command = ['~/abin/3dttest++ -no1sam -prefix aliceLRt ',setA];
eval(['!',command])

[t,v]=alicePermute(prefix);
% normalize (divide by std)
aliceNormSTD('alice210LRdif')
[t,v]=alicePermute([prefix,'N']); % clust size sig !!!
[t,v]=alicePermuteFour(prefix);

aliceLRtlrc('alice179',1)
[t,v]=alicePermute('alice179LRdif',true);
aliceNormSTD('alice179LRdif')
[t,v]=alicePermute('alice179LRdifN');

aliceLRtlrc('alice089',1)
[t,v]=alicePermute('alice089LRdif',true);
aliceNormSTD('alice089LRdif')
[t,v]=alicePermute('alice089LRdifN'); % clust size and t sig !!!

alicePermutePaired('alice210','noise')
% setA-setB

alicePermutePaired('alice179','noise')

alicePermutePaired('alice089','noise')

% ALPHA
aliceAlphaSAM('inbal');
aliceMaxAlpha('Nalice');
% run alice2tlrc
aliceMaxAlpha('Nrest');

% for subi=1:8
%     cd(['/home/yuval/Copy/MEGdata/alice/',sf{subi}])
%     fn=ls('xc*');
%     fn=fn(1:end-1);
%     cd ..
%     if ~exist([sf{subi},'/SAM/general,7-13Hz/alla.cov'],'file')
%         eval (['!SAMcov64 -r ',sf{subi},' -d ',fn,' -m alpha -v'])
%     end
%     if ~exist([sf{subi},'/hull.shape'],'file')
%         copyfile ([sf{subi},'/MRI/hull.shape'],[sf{subi},'/'])
%     end
%     if ~exist([sf{subi},'/SAM/general,3-35Hz,alla.wts'],'file')
%         eval (['!SAMwts64 -r ',sf{subi},' -d ',fn,' -m general -c alla -v'])
%     end
% end

for subi=1:8
    masktlrc(['NrestMax_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
end
for subi=1:8
    masktlrc(['alphaMax_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
end
alicePermutePaired('NrestMax','alphaMax')

aliceTlrc('Nalice');
aliceTlrc('Nrest');
% mask
alicePermutePairedF('Nrest','Nalice',9)

%% freesurfer
% run in terminal "ortho2FS aliceLiron"
aliceMeshHesh('liron')
sf={'idan'  'inbal'  'liron'  'maor'  'odelia'	'ohad'  'yoni' 'mark'};
for i=1:length(sf)
    aliceMeshHesh(sf{i})
    pause
end

%% wts by band
sf={'idan'  'inbal'  'liron'  'maor'  'odelia'	'ohad'  'yoni' 'mark'};
for subi=1:8
    cd(['/home/yuval/Copy/MEGdata/alice/',sf{subi}])
    fn=ls('xc*');
    fn=fn(1:end-1);
    cd ..
    if ~exist([sf{subi},'/SAM/alpha,7-13Hz/alla.cov'],'file')
        eval (['!SAMcov64 -r ',sf{subi},' -d ',fn,' -m alpha -v'])
    end
    if ~exist([sf{subi},'/hull.shape'],'file')
        copyfile ([sf{subi},'/MRI/hull.shape'],[sf{subi},'/'])
    end
    if ~exist([sf{subi},'/SAM/alpha,7-13Hz,alla.wts'],'file')
        eval (['!SAMwts64 -r ',sf{subi},' -d ',fn,' -m alpha -c alla -v'])
    end
end

load /home/yuval/Copy/MEGdata/alice/ga/GavgMalice

%aliceImage(GavgMalice,[0.210 0.210],'alice210','alpha,7-13Hz,alla.wts')
for subi=2:8
    aliceAlphaSAM(sf{subi},'alpha,7-13Hz,alla.wts');
end
% aliceMaxAlpha('N7-13alice');
% % run alice2tlrc
% aliceMaxAlpha('N7-13rest');
aliceTlrc('N7-13Hzalice');
aliceTlrc('N7-13Hzrest');
% % mask
% for subi=1:8
%     masktlrc(['N7-13Hzalice_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
%     masktlrc(['N7-13Hzrest_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
% end
permute.label={'t-threshold','critical t','critical cluster size'}
[critT,critClustSize]=alicePermutePairedF('N7-13Hzrest','N7-13Hzalice',9,3);
permute.results(1,1:3)=[3,critT,critClustSize];
[critT,critClustSize]=alicePermutePairedF('N7-13Hzrest','N7-13Hzalice',9,3.5);
permute.results(2,1:3)=[3.5,critT,critClustSize];
[critT,critClustSize]=alicePermutePairedF('N7-13Hzrest','N7-13Hzalice',9,4);
permute.results(3,1:3)=[4,critT,critClustSize];
save N7-13Hzrest_N7-13Hzalice permute
permute.label
permute.results

%% F-test for Tamil and word by word
aliceGA('24812');
load /home/yuval/Copy/MEGdata/alice/ga/GavgM10
aliceImage(GavgM10,[0.210 0.210],'seg10M210');
load /home/yuval/Copy/MEGdata/alice/ga/GavgM8
aliceImage(GavgM8,[0.210 0.210],'seg8M210');
load /home/yuval/Copy/MEGdata/alice/ga/GavgM12
aliceImage(GavgM12,[0.210 0.210],'seg12M210');
aliceTlrc('seg8M210');
aliceTlrc('seg10M210');
aliceTlrc('seg12M210');

prefix1='seg8M210';prefix2='seg10M210';prefix3='seg12M210';
%[critF,critClustSize]=alicePermuteAnova(prefix1,prefix2,prefix3,3)
[critF,critClustSize]=alicePermuteAnova(prefix1,prefix2,prefix3,[3 3.5 4]);


load /home/yuval/Copy/MEGdata/alice/ga/GavgM2
aliceImage(GavgM2,[0.210 0.210],'seg2M210');
load /home/yuval/Copy/MEGdata/alice/ga/GavgM4
aliceImage(GavgM4,[0.210 0.210],'seg4M210');
load /home/yuval/Copy/MEGdata/alice/ga/GavgM20
aliceImage(GavgM20,[0.210 0.210],'seg20M210');
aliceTlrc('seg2M210');
aliceTlrc('seg4M210');
aliceTlrc('seg20M210');
% ./alice2tlrc
for subi=1:8
    masktlrc(['seg2M210_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
    masktlrc(['seg20M210_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
    masktlrc(['seg4M210_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
end
prefix1='seg2M210';prefix2='seg20M210';prefix3='seg4M210';
[critF,critClustSize]=alicePermuteAnova(prefix1,prefix2,prefix3,[3 3.5 4]);

timest='089';
time=str2num(timest)/1000;
aliceImage(GavgM2,[time time],['seg2M',timest]);
aliceImage(GavgM4,[time time],['seg4M',timest]);
aliceImage(GavgM20,[time time],['seg20M',timest]);
aliceTlrc(['seg2M',timest]);% ./alice2tlrc
aliceTlrc(['seg4M',timest]);% ./alice2tlrc
aliceTlrc(['seg20M',timest]);% ./alice2tlrc
for subi=1:8
    masktlrc(['seg2M',timest,'_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
    masktlrc(['seg20M',timest,'_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
    masktlrc(['seg4M',timest,'_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
end
prefix1=['seg2M',timest];prefix2=['seg20M',timest];prefix3=['seg4M',timest];
[critF,critClustSize]=alicePermuteAnova(prefix1,prefix2,prefix3,[3 3.5 4]);

timest='179';
time=str2num(timest)/1000;
aliceImage(GavgM2,[time time],['seg2M',timest]);
aliceImage(GavgM4,[time time],['seg4M',timest]);
aliceImage(GavgM20,[time time],['seg20M',timest]);
aliceTlrc(['seg2M',timest]);% ./alice2tlrc
aliceTlrc(['seg4M',timest]);% ./alice2tlrc
aliceTlrc(['seg20M',timest]);% ./alice2tlrc
for subi=1:8
    masktlrc(['seg2M',timest,'_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
    masktlrc(['seg20M',timest,'_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
    masktlrc(['seg4M',timest,'_',num2str(subi),'+tlrc'],'~/SAM_BIU/docs/MASKctx+tlrc')
end
prefix1=['seg2M',timest];prefix2=['seg20M',timest];prefix3=['seg4M',timest];
[critF,critClustSize]=alicePermuteAnova(prefix1,prefix2,prefix3,[3 3.5 4]);

timest='210';
endFstr='-ftr F -contr  1 -1  1 Alice_WBW -mean 1 alice1 -mean 2 WBW -mean 3 alice2 -bucket FTnew';
prefix1='seg2M210';prefix2='seg20M210';prefix3='seg4M210';
[critF,critClustSize]=alicePermuteAnova(prefix1,prefix2,prefix3,[3 3.5 4],endFstr);

prefix1=['seg8M',timest];prefix2=['seg10M',timest];prefix3=['seg12M',timest];
endFstr='-ftr F -contr  1 -1  1 Alice_Tamil -mean 1 alice1 -mean 2 tamil -mean 3 alice2 -bucket FTnew';
[critF,critClustSize]=alicePermuteAnova(prefix1,prefix2,prefix3,[3 3.5 4],endFstr);

%% repeated measures ANOVA
prefix1='seg2M210';prefix2='seg20M210';prefix3='seg4M210';
[critF,critClustSize]=alicePermuteAnova2(prefix1,prefix2,prefix3,[3 3.5 4 4.5 5 5.5 6],'-fa F -acontr 1 -2 1 Alice_WBW -amean 1 alice1 -amean 2 WBW -amean 3 alice2 -bucket FTnew');
prefix1='seg8M210';prefix2='seg10M210';prefix3='seg12M210';
[critF,critClustSize]=alicePermuteAnova2(prefix1,prefix2,prefix3,[3 3.5 4 4.5 5 5.5 6],'-fa F -acontr 1 -2 1 Alice_Tamil -amean 1 alice1 -amean 2 Tamil -amean 3 alice2 -bucket FTnew');

for segi=[4 20 8 10 12];aliceLRtlrc(['seg',num2str(segi),'M210']);end
prefix1='seg2M210LRdif';prefix2='seg20M210LRdif';prefix3='seg4M210LRdif';
[critF,critClustSize]=alicePermuteAnova2(prefix1,prefix2,prefix3,[3 3.5 4 4.5 5 5.5 6],'-fa F -acontr 1 -2 1 Alice_WBW -amean 1 alice1 -amean 2 WBW -amean 3 alice2 -bucket FTnew');
prefix1='seg8M210LRdif';prefix2='seg10M210LRdif';prefix3='seg12M210LRdif';
[critF,critClustSize]=alicePermuteAnova2(prefix1,prefix2,prefix3,[3 3.5 4 4.5 5 5.5 6],'-fa F -acontr 1 -2 1 Alice_Tamil -amean 1 alice1 -amean 2 Tamil -amean 3 alice2 -bucket FTnew');

% permute t contrast
prefix1='seg8M210';prefix2='seg10M210';prefix3='seg12M210';
[critF,critClustSize]=alicePermuteAnova2contr(prefix1,prefix2,prefix3,[2 2.5 3 3.5 4 4.5 5 5.5 6],['-fa F -acontr 1 -2 1 Alice_Tamil -amean 1 alice1 -amean 2 Tamil -amean 3 alice2 -bucket ','A2_',prefix1,'_',prefix2,'_',prefix3],'-acontr 1 -2 1 TTnew');
prefix1='seg8M210LRdif';prefix2='seg10M210LRdif';prefix3='seg12M210LRdif'
[critF,critClustSize]=alicePermuteAnova2contr(prefix1,prefix2,prefix3,[2 2.5 3 3.5 4 4.5 5 5.5 6],['-fa F -acontr 1 -2 1 Alice_Tamil -amean 1 alice1 -amean 2 Tamil -amean 3 alice2 -bucket ','A2_',prefix1,'_',prefix2,'_',prefix3],'-acontr 1 -2 1 TTnew');
prefix1='seg2M210';prefix2='seg20M210';prefix3='seg4M210';
[critF,critClustSize]=alicePermuteAnova2contr(prefix1,prefix2,prefix3,[2 2.5 3 3.5 4 4.5 5 5.5 6],['-fa F -acontr 1 -2 1 Alice_WBW -amean 1 alice1 -amean 2 WBW -amean 3 alice2 -bucket ','A2_',prefix1,'_',prefix2,'_',prefix3],'-acontr 1 -2 1 TTnew');
prefix1='seg2M210LRdif';prefix2='seg20M210LRdif';prefix3='seg4M210LRdif';
[critF,critClustSize]=alicePermuteAnova2contr(prefix1,prefix2,prefix3,[2 2.5 3 3.5 4 4.5 5 5.5 6],['-fa F -acontr 1 -2 1 Alice_WBW -amean 1 alice1 -amean 2 WBW -amean 3 alice2 -bucket ','A2_',prefix1,'_',prefix2,'_',prefix3],'-acontr 1 -2 1 TTnew');

% 4
prefix1='seg8M210';prefix2='seg10M210';prefix3='seg12M210';
[critF,critClustSize]=alicePermute4Anova2contr(prefix1,prefix2,prefix3,[2 2.5 3 3.5 4 4.5 5 5.5 6],['-fa F -acontr 1 -2 1 Alice_Tamil -amean 1 alice1 -amean 2 Tamil -amean 3 alice2 -bucket ','A2_',prefix1,'_',prefix2,'_',prefix3,'_4'],'-acontr 1 -2 1 TTnew');