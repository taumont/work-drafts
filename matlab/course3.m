fileName='c,rfhp0.1Hz';

cfg=[];
cfg.dataset=fileName; % change file name or path+name
cfg.trialdef.eventtype='TRIGGER';
%cfg.trialdef.eventvalue= 102; % 
cfg.trialdef.prestim=0.1;
cfg.trialdef.poststim=0.3;
cfg.trialdef.offset=-0.1;
cfg.trialfun='BIUtrialfun';
cfg.trialdef.eventvalue= 104;
cfg1=definetrial(cfg);
raw=ft_preprocessing(cfg1);
rawAvg=ft_timelockanalysis([],raw);
cfg1.blc='yes';
blc=ft_preprocessing(cfg1);
blcAvg=ft_timelockanalysis([],blc);
cfg2=[];
cfg2.interactive='yes';
cfg.layout='4D248.lay';
ft_multiplotER([],rawAvg,blcAvg);


cfg1.continuous='yes';
cfg1.blcwindow=[-0.1,0];
cfg1.bpfilter='yes';
cfg1.bpfreq=[3 35];
cfg1.channel={'MEG','MEGREF'}
dataorig=ft_preprocessing(cfg1);
hdr=ft_read_headerOLD('c,rfhp0.1Hz');
dataorig.grad=ft_convert_units(hdr.grad,'mm');
leftIndSom=timelockanalysis([],dataorig);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             