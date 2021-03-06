function [cohLR,coh,freq,data]=talCohH(subs,foi,pat,chCmb,cond)
% chCmb can be 'LR' or 'AntPost'
% [cohLR,freq,data]=cohTal({'quad01'},[1:50]);
try
    if isempty(chCmb)
        chCmb='LR';
    end
catch
    chCmb='LR';
end

if ~exist('pat','var')
    pat=[];
end
if isempty(pat)
    pat='/media/Elements/MEG/tal';
end
patR=[pat(1:(end-3)),'talResults'];
PWD=pwd;
cd (pat)
for subi=1:length(subs)
    sub=subs{subi};
    display(['BEGGINING WITH ',sub]);
    indiv=talIndivPathH(sub,cond,pat);
    numRep=1;
    if strcmp('rest',cond)
        numRep=2;
    end
    for i=1:numRep % two eyes closed per subject
        eval(['cd (indiv.path',num2str(i),')']);
        eval(['source=indiv.source',num2str(i),';'])
        % converting MarkerFile to trl
        trg=textread([cond,'MarkerFile.mrk'],'%s');
        if strcmp('rest',cond)
            startTrg=find(strcmp('eyesClosed',trg))+14;
        elseif strcmp('timeProd',cond)
            startTrg=find(strcmp([cond,'32'],trg))+14;
        end
        numTrg=trg(startTrg-10);
        numTrg=str2num(numTrg{1,1});
        endTrg=startTrg+numTrg*2-2;
        trl=[];
        trli=1;
        for trgi=startTrg:2:endTrg
            trl(trli,1)=round(str2num(trg{trgi})*1017.25);
            trli=trli+1;
        end
        trl(:,2)=trl(:,1)+1017;
        trl(:,3)=0;
        cfg=[];
        cfg.dataset=source;
        cfg.trialdef.poststim=0.2;
        cfg.trialfun='trialfun_beg';
        cfg1=[];
        cfg1=ft_definetrial(cfg);
        cfg1.trl=trl
        cfg1.channel={'MEG','-A74','-A204'}
        cfg1.blc='yes';
        cfg1.export='';
        data=ft_preprocessing(cfg1);
        % fft
        cfg3           = [];
        cfg3.method    = 'mtmfft';
        cfg3.output    = 'fourier';
        cfg3.tapsmofrq = 1;
        cfg3.foi=foi;
        freq          = ft_freqanalysis(cfg3, data);
        % Coherence
        %chansL={'A229' 'A232' 'A215' 'A236' 'A123' 'A126' 'A129' 'A132' 'A135' 'A39' 'A43' 'A47'};
        %chansR={'A248' 'A245' 'A225' 'A241' 'A151' 'A148' 'A145' 'A142' 'A139' 'A59' 'A55' 'A51'};
        %chanCmbLR=chansL';
        %chanCmbLR(:,2)=chansR';
        
        cfg4           = [];
        cfg4.method    = 'coh';
        if strcmp(chCmb,'LR')
            load ~/ft_BIU/matlab/files/LRpairs
            cfg4.channelcmb=LRpairs;
            cohLR          = ft_connectivityanalysis(cfg4, freq);
            load ([patR,'/tempCoh']);
            cohspctrm=ones(246,50);
            
            for cmbi=1:113
                chi=find(strcmp(cohLR.labelcmb{cmbi,1},data.label));
                cohspctrm(chi,:)=cohLR.cohspctrm(cmbi,1:50);
                chi=find(strcmp(cohLR.labelcmb{cmbi,2},data.label));
                cohspctrm(chi,:)=cohLR.cohspctrm(cmbi,1:50);
            end
            coh=tempCoh;
            coh.powspctrm=cohspctrm;
            coh.freq=1:50;
            sufix='';
        else
            sufix='AP';
            load /media/Elements/MEG/tal/chansAntPost
            %cfg4.channelcmb=AntPostPairs;
            for listi=1:5
                chan4ft={};
                eval(['chan=chan',num2str(listi),';']);
                for chani=1:length(chan)
                    for chanj=1:length(chan);
                        chan4ft{(chani-1).*length(chan)+chanj,1}=['A',num2str(chan(chani))];
                        chan4ft{(chani-1).*length(chan)+chanj,2}=['A',num2str(chan(chanj))];
                    end
                end
                eval(['ch4ft',num2str(listi),'=chan4ft;'])
            end
            cfg4.channelcmb=ch4ft1;
            coh.cohLL = ft_connectivityanalysis(cfg4, freq);
            cfg4.channelcmb=ch4ft2;
            coh.cohL = ft_connectivityanalysis(cfg4, freq);
            cfg4.channelcmb=ch4ft3;
            coh.cohC = ft_connectivityanalysis(cfg4, freq);
            cfg4.channelcmb=ch4ft4;
            coh.cohR = ft_connectivityanalysis(cfg4, freq);
            cfg4.channelcmb=ch4ft5;
            coh.cohRR = ft_connectivityanalysis(cfg4, freq);
        end
        eval(['coh',num2str(i),'=coh;'])
    end
    
    
    %         cfg.channelcmb={'all' 'all'};
    %         cfg.channel=chansL;
    %         cohL           = ft_connectivityanalysis(cfg, freq);
    %         cfg.channel=chansR;
    %         cohR           = ft_connectivityanalysis(cfg, freq);
    %         figure;
    %         plot(round(cohLR.freq),cohLR.cohspctrm(6:9,:));
    %         legend('A126','A129','A132','A135')
    %         title(sub)
    if strcmp(cond,'rest')
        save([patR,'/Coh/',sub,sufix],'coh1','coh2')
    else
        if ~exist([patR,'/',cond,'Coh'],'dir')
            mkdir([patR,'/',cond,'Coh']);
        end
        save([patR,'/',cond,'Coh/',sub,sufix],'coh1')
end
cd(PWD);
end
