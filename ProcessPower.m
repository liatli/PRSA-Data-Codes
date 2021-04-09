close all
clear all
clc

%% Two fish with different phase differences
if 1
    
    FileName = './data/TwoFishPower.xlsx';
    % for different phases
    Speed = {'Sheet1','Sheet2','Sheet3','Sheet4','Sheet5','Sheet6','Sheet7','Sheet8','Sheet9'};
    Fish1VColumn = 'A:E';
    Fish1IColumn = 'F:J';
    Fish2VColumn = 'L:P';
    Fish2IColumn = 'Q:U';
    Fish1VData = cell(size(Speed));
    Fish1IData = cell(size(Speed));
    Fish2IData = cell(size(Speed));
    Fish2VData = cell(size(Speed));
    
    for i = 1:size(Speed,2)
        
        Fish1VData{i}=(xlsread(FileName,Speed{i},Fish1VColumn)*2.027-0.0386);
        Fish1IData{i}=(xlsread(FileName,Speed{i},Fish1IColumn)*8.7819-14.4109);
        Fish2VData{i}=(xlsread(FileName,Speed{i},Fish2VColumn)*2.027-0.0386);
        Fish2IData{i}=(xlsread(FileName,Speed{i},Fish2IColumn)*8.7819-14.4109);

        
        Fish1PowerData{i}=Fish1VData{i}.*Fish1IData{i};
        Fish2PowerData{i}=Fish2IData{i}.*Fish2VData{i};
        
        
        MeanFish1VData(i,:) = mean(Fish1VData{i});
        MeanFish1IData(i,:) = mean(Fish1IData{i});
        MeanFish2IData(i,:) = mean(Fish2IData{i});
        MeanFish2VData(i,:) = mean(Fish2VData{i});
        
        MeanFish1PowerData(i,:)=mean(Fish1PowerData{i});
        MeanFish2PowerData(i,:)=mean(Fish2PowerData{i});
        
        
        
        MeanAllFish1VData(i) = mean(MeanFish1VData(i,:));
        MeanAllFish1IData(i) = mean(MeanFish1IData(i,:));
        MeanAllFish2IData(i) = mean(MeanFish2IData(i,:));
        MeanAllFish2VData(i) = mean(MeanFish2VData(i,:));
        
        
        MeanAllFish1PowerData(i)=mean( MeanFish1PowerData(i,:));
        MeanAllFish2PowerData(i)=mean(MeanFish2PowerData(i,:));
        
        
        StdFish1VData(i) = std(MeanFish1VData(i,:))/sqrt(5);
        StdFish1IData(i) = std(MeanFish1IData(i,:))/sqrt(5);
        StdFish2VData(i) = std(MeanFish2VData(i,:))/sqrt(5);
        StdFish2IData(i) = std(MeanFish2IData(i,:))/sqrt(5);
        StdFish1PowerData(i)=std(MeanFish1PowerData(i,:))/sqrt(5);
        StdFish2PowerData(i)=std(MeanFish2PowerData(i,:))/sqrt(5);

    end
    
    
    %% Save data
    FileNames = {'MeanPowerLeft.txt', 'MeanPowerRight.txt', 'StdPowerLeft.txt', 'StdPowerRight.txt', 'PowerLeft.txt','PowerRight.txt'};
    
    WriteTxt(['./data/',FileNames{1}],MeanAllFish1PowerData);
    WriteTxt(['./data/',FileNames{3}],StdFish1PowerData);
    WriteTxt(['./data/',FileNames{2}],MeanAllFish2PowerData);
    WriteTxt(['./data/',FileNames{4}],StdFish2PowerData);
    WriteTxt(['./data/',FileNames{5}],MeanFish1PowerData);
    WriteTxt(['./data/',FileNames{6}],MeanFish2PowerData);
    
    
end

%% Read one fish power
if 1
    FileName = './data/single-fish.xlsx';
    % for different phases
    Sheets = {'Sheet1','Sheet2'};
    VColumn = 'A:E';
    IColumn = 'F:J';
    FishVData = cell(size(Sheets));
    FishIData = cell(size(Sheets));
    FishIData = cell(size(Sheets));
    FishVData = cell(size(Sheets));
    
    for i = 1:size(Sheets,2)
        
        FishVData{i}=(xlsread(FileName,Sheets{i},VColumn)*2.027-0.0386);
        
        FishIData{i}=(xlsread(FileName,Sheets{i},IColumn)*8.7819-14.4109);
    
        FishPowerData{i}=FishVData{i}.*FishIData{i};
        
        
        FishPowerData{i} = FishPowerData{i}(all(~isnan(FishPowerData{i}),2),:);
        
        MeanFishPowerData(i,:)=mean(FishPowerData{i});

        MeanAllFishPowerData(i)=mean( MeanFishPowerData(i,:));
        StdFishPowerData(i)=std(MeanFishPowerData(i,:))/sqrt(5);
    end
    
    
        %% Save data
    FileNames = {'MeanPowerAlone.txt',  'StdPowerAlone.txt', 'PowerAlone.txt'};
    
    WriteTxt(['./data/',FileNames{1}],mean(MeanAllFishPowerData));
    WriteTxt(['./data/',FileNames{3}],MeanFishPowerData);
    WriteTxt(['./data/',FileNames{2}],StdFishPowerData);
    
    
end

    

    

%% swimming alone for the left and right fish
if 1
    
    SingleLeft = xlsread('./data/single-fish.xlsx','Sheet1','A:J') ;
    SingleRight= xlsread('./data/single-fish.xlsx','Sheet2','A:J') ;
    
    SinglePowerLeft  = (SingleLeft(:,1:5)*1.762-1.938)*2 .* (SingleLeft(:,6:10)*9.123-14.9);
    xlswrite('./data/single-fish-out.xlsx','Sheet1','A:J');
    SinglePowerRight = (SingleRight(:,1:5)*1.762-1.938)*2 .* (SingleRight(:,6:10)*9.123-14.9);
    xlswrite('./data/single-fish-out.xlsx','Sheet2','A:J');
    SinglePowerLeft(isnan(SinglePowerLeft))   = [];
    SinglePowerRight(isnan(SinglePowerRight)) = [];
    MSinglePowerLeft  = mean(mean(SinglePowerLeft));
    MSinglePowerRight = mean(mean(SinglePowerRight));
    
end
