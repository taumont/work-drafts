function rsEEG = resampEEG4MEG(eegData, offset, srEEG, srMEG, lengthMEG)

% this function resamples the EEG data to match the samples of the MEG data
% it is recommended to sample the EEG in a higher sampling rate. we used
% 1017.25 for the MEG and 1024 for the EEG.
% inputs:
% eegData - rows = channels. columns = samples. 
% offset - time difference between the beginning of the MEG and EEG
% recordings (start MEG time - start EEG time)
% srEEG - "official" sampling rate of the EEG (1000, 1024 etc)
% srMEG - sampling rate of the MEG calculated according to the time
% difference between 2 triggers (NOTE: do not use with the "official
% sampling rate). to fit 1017.25 srMEG to 1024 srEEG we got an actual srMEG
% = 1017.2776374

sEEGoffset = round(offset*srEEG);
sMEG = 1 : lengthMEG;
sEEG = sEEGoffset+round(sMEG/srMEG*srEEG);
rsEEG = eegData(:,sEEG);
end
