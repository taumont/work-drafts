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
[cfg1,probplot,cfg2,statplot]=ambMonte('M350','subp','domp',0.995);

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


%% M170 main effect for hemisphere
% merge sub and dom
ambMergeSources('m170','pow');
%    % get the pretrigger noise value
ambGrAvg1([1:25],'m170','noise');

%    % merge the two noise conditions
ambMergeSources('m170','noise');

%    % change noise field to pow
load m170domsubN
for subi=1:25;
    m170domsubN.trial(1,subi).pow=m170domsubN.trial(1,subi).noise;
    %[M350domsubN.trial(1,subi)]=rmfield(M350domsubN.trial(1,subi),'noise');
end
save m170domsubN m170domsubN

% fix pos

load template_grid_10mm
load m170domsubp
m170domsubp.pos=template_grid.pos;
m170domsubp=rmfield(m170domsubp,'transform');
save m170domsubp m170domsubp
load m170domsubN
m170domsubN.pos=template_grid.pos;
m170domsubN=rmfield(m170domsubN,'transform');
save m170domsubN m170domsubN
 %  I was unable to remove noise field, identical to pow now.
% interpolate sources
% load m170domsubN.mat
% load m170domsubp.mat
% load sMRI
% cfg = [];
% cfg.parameter = 'pow';
% %cfg10.interpmethod  = 'spline';%'cubic' 'linear';
% M170domsubN=ft_sourceinterpolate(cfg,m170domsubN,sMRI);

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_m170_ME','m170domsubp','m170domsubN',0.95,0.01);
load Cl01_m170_MEstat
stat=rmfield(stat,'transform');
load template_grid_10mm
stat.pos=template_grid.pos;
load sMRI
cfg=[];
cfg.parameter = {'prob','stat'};
stat=ft_sourceinterpolate(cfg,stat,sMRI)
save Cl01_M170_MEstat stat
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl01_M170_ME','','',0.95,0.01);

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl005_m170_ME','m170domsubp','m170domsubN',0.95,0.005);
load Cl005_m170_MEstat
stat=rmfield(stat,'transform');
load template_grid_10mm
stat.pos=template_grid.pos;
load sMRI
cfg=[];
cfg.parameter = {'prob','stat'};
stat=ft_sourceinterpolate(cfg,stat,sMRI)
save Cl005_M170_MEstat stat
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl005_M170_ME','','',0.95,[]);

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl0001_m170_ME','m170domsubp','m170domsubN',0.95,0.0001);
load Cl0001_m170_MEstat
%stat=rmfield(stat,'transform');
load template_grid_10mm
stat.pos=template_grid.pos;
load sMRI
cfg=[];
cfg.parameter = {'prob','stat'};
stat=ft_sourceinterpolate(cfg,stat,sMRI)
save Cl0001_M170_MEstat stat
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl0001_M170_ME','','',0.95,[]);
cfg2.funcolorlim=[-7 7];
ft_sourceplot(cfg2,statplot)

[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl0005_m170_ME','m170domsubp','m170domsubN',0.95,0.0005);
load Cl0005_m170_MEstat
%stat=rmfield(stat,'transform');
load template_grid_10mm
stat.pos=template_grid.pos;
load sMRI
cfg=[];
cfg.parameter = {'prob','stat'};
stat=ft_sourceinterpolate(cfg,stat,sMRI)
save Cl0005_M170_MEstat stat
[cfg1,probplot,cfg2,statplot]=ambMonteClust('Cl0005_M170_ME','','',0.95,[]);
cfg2.funcolorlim=[-7 7];
ft_sourceplot(cfg2,statplot)


% 
% 
% load Cl005_m170_MEstat
% stat=rmfield(stat,'transform');