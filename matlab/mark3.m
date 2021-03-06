function mark3(toi,fPlot)

%toi=[-0.8 0];
if ~existAndFull('toi')
    toi=[-0.5 0];
end
if ~exist('fPlot','var')
    fPlot=false;
end
if ~exist('./sub1','dir')
    try
        cd /media/yuval/My_Passport/Mark_threshold_visual_detection/MEG_data/
    catch
        try
            cd /home/yuval/Data/mark
        catch
            error('cd to mark directory')
        end
    end
end

%% compute phase
if exist(['results',num2str(toi(1)),'.mat'],'file')
    load(['results',num2str(toi(1)),'.mat']);
else
    for subi=1:22
        clear corr*
        clear miss*
        folder=['sub',num2str(subi)];
        cd (folder)
        load datafinal
        s0=nearest(datafinal.time{1},toi(2));
        sBL=nearest(datafinal.time{1},toi(1));
        if subi==1;
            grad=datafinal.grad;
            [~,F]=fftBasic(datafinal.trial{1}(1,sBL:s0),678.17);
            F=F(F<31);
        else
            datafinal.grad=grad;
        end
        corri= find(datafinal.trialinfo(:,4)==2);
        missi= find(datafinal.trialinfo(:,4)==0);
        nTrl=min([length(corri),length(missi)]);
        corri=corri(1:nTrl);missi=missi(1:nTrl);
        %for foii=1:length(F)
        for trli=1:length(corri)
            f=fftBasic(datafinal.trial{corri(trli)}(:,sBL:s0),678.17);
            corrF=f(:,1:length(F));
            f=fftBasic(datafinal.trial{missi(trli)}(:,sBL:s0),678.17);
            missF=f(:,1:length(F));
            for chani=1:248
                
                corrPh(chani,trli,1:length(F))=mod(phase(corrF(chani,:)),2*pi);
                missPh(chani,trli,1:length(F))=mod(phase(missF(chani,:)),2*pi);
                
            end
        end
        for foii=1:length(F)
            MissPh(1:248,subi,foii) = circ_mean(missPh(:,:,foii),[],2);
            MissR(1:248,subi,foii) = circ_r(missPh(:,:,foii), [],[], 2);
            %MissF(1:248,subi)=mean(missF(:,:),2);
            %MissPSD(1:248,subi)=mean(missPSD(:,:),2);
            CorrPh(1:248,subi,foii) = circ_mean(corrPh(:,:,foii),[],2);
            CorrR(1:248,subi,foii) = circ_r(corrPh(:,:,foii), [],[], 2);
            %CorrF(1:248,subi)=mean(corrF(:,:),2);
            %CorrPSD(1:248,subi)=mean(corrPSD(:,:),2);
        end
        % averaging
        %     cfg=[];
        %     cfg.trials=corri(:);
        %     corr=ft_timelockanalysis(cfg,datafinal);
        %     cfg.trials=missi(:);
        %     miss=ft_timelockanalysis(cfg,datafinal);
        disp(['done ',folder])
        cd ..
    end
    save (['results',num2str(toi(1)),'.mat'],'F','toi','CorrR','CorrPh','MissR','MissPh')
end

for foii=1:length(F)
    for chani=1:248
        prC(chani) = circ_rtest(CorrPh(chani,:,foii));
    end
    for chani=1:248
        prM(chani) = circ_rtest(MissPh(chani,:,foii));
    end
    nSigC(foii)=sum(prC<0.05);
    nSigM(foii)=sum(prM<0.05);
end
figure;
disp('done')
plot(F,nSigC)
hold on
plot(F,nSigM,'r')
legend('correct','miss')
figure;
plot(F,squeeze(mean(mean(CorrR,1),2)))
hold on
plot(F,squeeze(mean(mean(MissR,1),2)),'r')
legend('correct','miss')

%[~,pr]=ttest(CorrR(:,:,5)',MissR(:,:,5)');

if fPlot
    fi=nearest(F,fPlot)
    
    for chani=1:248
        prC(chani) = circ_rtest(CorrPh(chani,:,fi));
    end
    for chani=1:248
        prM(chani) = circ_rtest(MissPh(chani,:,fi));
    end
    cfg=[];
    cfg.zlim=[0 max([max(mean(MissR(:,:,fi),2)) max(mean(CorrR(:,:,fi),2)) ])];
    cfg.highlight='labels';
    cfg.highlightchannel=find(prM<0.05);
    figure;topoplot248(mean(MissR(:,:,fi),2),cfg);title('Miss')
    colorbar
    cfg.highlightchannel=find(prC<0.05);
    figure;topoplot248(mean(CorrR(:,:,fi),2),cfg);title('Correct')
    colorbar
end
