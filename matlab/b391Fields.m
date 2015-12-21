cd /home/yuval/Data/epilepsy/b391
load('VS.mat')
load peaks

fields=zeros(248,9);
cfg=[];
cfg.dataset='3/0_c,rfhp0.1Hz,ee';
cfg.bpfilter='yes';
cfg.bpfreq=[20,70];
cfg.padding=0.5;
cfg.demean='yes';
cfg.baselinewindow=[-0.15 -0.05];
cfg.channel='MEG';
for vsi=1:9
    pik=peaks{vsi}';
    pik=pik(pik<ends(5));
    pik=pik(pik>ends(4));
    pik=pik-ends(4);
    pik=pik(3:end-2);
    cfg.trl=[pik-500,pik+500];
    cfg.trl(:,3)=-500;
    data=ft_preprocessing(cfg);
    avg=ft_timelockanalysis([],data);
    fields(:,vsi)=avg.avg(:,501);
end

figure;topoplot248(fields(:,2))
%%

times={};
for vsi=[2,4,5,6,7,8,9]
    pik=peaks{vsi,2};
    for vsj=[2,4,5,6,7,8,9] 
        times{vsi,1}{vsj}=[];
        count=0;
        for peaki=1:length(pik)
            if pik(peaki)>1018
                peri=find(abs(pik(peaki)-peaks{vsj})<2034);
                if ~isempty(peri)
                    times{vsi,1}{vsj}=[times{vsi,1}{vsj},peaks{vsj}(peri)-pik(peaki)];
                    count=count+1;
                end
            end
        end
    end   
end




t1=0;
edges=[t1:2034.5/20:2034.5];
time=round((diff(edges)./2+edges(1:end-1))/2034.5*1000);
vsc=[2,4,5,6,7,8,9];

for vsi=1:7
    timeMat=[];
    for vsj=1:7
        if vsi==vsj
            timeMat(vsj,1:length(time))=0;
        else
            binedData=histc(times{vsc(vsi)}{vsc(vsj)},edges);
            binedData(end-1)=binedData(end-1)+binedData(end);
            binedData(end)=[];
            timeMat(vsj,1:length(time))=binedData;
        end
%         bar(time,binedData); xlim([-1000 1000])
%         title(['timelock on ',num2str(vsi),', spikes on ',num2str(vsj)])
    end
    %timeMatSc=timeMat./max(timeMat(:));
    allTimes=sum(timeMat)./length(peaks{vsc(vsi),2});
    fig=figure;
    bar(time,allTimes)
%     fig=figure;
%     imagesc(timeMatSc);
%     imagesc(timeMatSc,[0 max(max(timeMatSc(:,1:end-1)))]);
    ax = gca;
%     set(ax,'Xtick',1:length(time),'XTickLabel',time);
    set(ax,'Ytick',1:7,'YTickLabel',vsc);
    title(['timelock on ',num2str(vsc(vsi)),', first spike ',num2str(length(peaks{vsc(vsi),2})),' times'])
    %set(fig,'Position',[400   674   756   259])
    colorbar
end




% t1=2034.5*1.025;
% edges=[-t1:2034.5/20:t1];
% time=round((diff(edges)./2+edges(1:end-1))/2034.5*1000);
% vsc=[2,4,5,6,7,8,9];
% 
% for vsi=1:7
%     for vsj=1:7
%         if vsi==vsj
%             timeMat(vsj,1:41)=0;
%         else
%             binedData=histc(times{vsc(vsi)}{vsc(vsj)},edges);
%             binedData(end-1)=binedData(end-1)+binedData(end);
%             binedData(end)=[];
%             timeMat(vsj,1:41)=binedData;
%         end
% %         bar(time,binedData); xlim([-1000 1000])
% %         title(['timelock on ',num2str(vsi),', spikes on ',num2str(vsj)])
%     end
%     timeMatSc=timeMat./max(timeMat(:));
%     fig=figure;
%     imagesc(timeMatSc);
%     imagesc(timeMatSc,[0 max(max(timeMatSc(:,1:end-1)))]);
%     ax = gca;
%     set(ax,'Xtick',1:41,'XTickLabel',time);
%     set(ax,'Ytick',1:7,'YTickLabel',vsc);
%     title(['timelock on ',num2str(vsc(vsi))])
%     set(fig,'Position',[400   674   756   259])
%     xlim([20,41])
% end
% 
% 
