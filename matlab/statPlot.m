function stat=statPlot(data1,data2,xlim,zlim,ttype);
% independent sample ttest (two groups)
%  stat=statPlot('cohLRv1pre_DM','cohLRv1pre_CM',[10 10],[],'ttest2')


if ~exist('ttype','var')
    ttype=[];
end
if isempty(ttype)
    ttype='paired-ttest';
end
cfg=[];
if exist('zlim','var')
    cfg.zlim=zlim;
else
    cfg.zlim=[];
end
if isempty(cfg.zlim)
    cfg.zlim='maxmin';
end
if ischar(data1)
    title1=data1;title2=data2;
    load(data1)
    eval(['data1=',data1])
    load(data2)
    eval(['data2=',data2])
else
    title1=inputname(1);
    title2=inputname(2);
end
if isfield(data1,'individual')
    dataMat='individual';
elseif isfield(data1,'powspctrm')
    dataMat='powspctrm';
else
    error('needs data.individual or data.powspctrm')
end
cfg.xlim=xlim;
cfg.layout = '4D248.lay';


cfgs=[];

cfgs.method='stats';
cfgs.statistic=ttype;
if strcmp(ttype,'paired-ttest')
    eval(['cfgs.design = [ones(1,size(data1.',dataMat,',1)) ones(1,size(data1.',dataMat,',1))*2];']);
else
    eval(['cfgs.design = [ones(1,size(data1.',dataMat,',1)) ones(1,size(data2.',dataMat,',1))*2];'])
end
if isfield(data1,'powspctrm')
    cfgs.frequency=xlim;
    [stat] = ft_freqstatistics(cfgs, data1,data2);
else
    cfgs.latency=xlim;
    [stat] = ft_timelockstatistics(cfgs, data1,data2);
end

datadif=data1;
if isfield(data1,'powspctrm')
    if strcmp(ttype,'paired-ttest')
        datadif.powspctrm=data1.powspctrm-data2.powspctrm;
    else
        datadif.powspctrm=mean(data1.powspctrm,1)-mean(data2.powspctrm,1);
    end
else
    datadif.individual=data1.individual-data2.individual;
end
cfg.highlight = 'labels';
cfg.highlightchannel = find(stat.prob<0.05);
%cfg.zlim='maxmin';
%cfg.marker='labels';
% figure;ft_topoplotER(cfg,data1)
% colorbar;
% title(strrep(title1,'_',' '));
% figure;ft_topoplotER(cfg,data2)
% colorbar;
% title(strrep(title2,'_',' '));
% figure;ft_topoplotER(cfg, datadif);
% colorbar;
% title(strrep([title1,' - ',title2],'_',' '));
figure;
subplot(1,2,1)
ft_topoplotER(cfg,data1)
title(strrep(title1,'_',' '));
subplot(1,2,2)
ft_topoplotER(cfg,data2)
title(strrep(title2,'_',' '));
end