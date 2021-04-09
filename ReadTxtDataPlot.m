%% Read data and plot for paper
% initialisation
clear all
close all
clc

set(0,'defaulttextinterpreter','tex')

CouzinColor=[235 45 46;
    241 161 43;
    0 170 79;
    0 174 239;
    35 31 32]/255;
PD = 1:9;
TV = 20; % for font 
% Read power cost
FileNames = {'MeanPowerLeft.txt', 'MeanPowerRight.txt', 'StdPowerLeft.txt', 'StdPowerRight.txt','PowerLeft.txt','PowerRight.txt','Speed.txt'};

MeanPowerLeft = load(['./data/',FileNames{1}]);
MeanPowerRight = load(['./data/',FileNames{2}]);
StdPowerLeft = load(['./data/',FileNames{3}]);
StdPowerRight = load(['./data/',FileNames{4}]);
PowerLeft = load(['./data/',FileNames{5}]);
PowerRight = load(['./data/',FileNames{6}]);
Speed = load(['./data/',FileNames{7}]);

% read speed
MeanSpeed=load('./data/MeanSpeed.txt');
StdSpeed=load('./data/StdSpeed.txt');


%%%%%%% power value from the output of "ReadOriTxtAndCalculate.m"
Power_alone = load(['./data/','MeanPowerAlone.txt']);
FishAlone = Power_alone/(mean([MeanPowerRight(1),MeanPowerLeft(1)])); 

StdPowerLeft = StdPowerLeft/MeanPowerLeft(1);
MeanPowerLeft=MeanPowerLeft/MeanPowerLeft(1);
StdPowerRight = StdPowerRight/MeanPowerRight(1);
MeanPowerRight = MeanPowerRight/MeanPowerRight(1);


% Data are from the speedprocess.m file

speed_fish_alone = 22.8;

% Normalise the swimming speed 
SingleSpeed = speed_fish_alone/MeanSpeed(1);

% The speed
StdSpeed = StdSpeed/MeanSpeed(1);
MeanSpeed = MeanSpeed/MeanSpeed(1);

SingleEfficiency = SingleSpeed/FishAlone ; % use the left fish in the single case 


% interpolation
iPD=1:0.1:9;
iStdPowerLeft=interp1(PD,StdPowerLeft,iPD,'pchip');
iMeanPowerLeft = interp1(PD,MeanPowerLeft,iPD,'pchip');
iStdPowerRight=interp1(PD,StdPowerRight,iPD,'pchip');
iMeanPowerRight = interp1(PD,MeanPowerRight,iPD,'pchip');


iPD=1:0.1:9;
iMeanSpeed=interp1(PD,MeanSpeed,iPD,'pchip');
iStdSpeed = interp1(PD,StdSpeed,iPD,'pchip');
for i = 1:size(Speed,2)
    iSpeed(:,i) = interp1(PD,Speed(:,i),iPD,'pchip');
    iPowerLeft(:,i) = interp1(PD,PowerLeft(:,i),iPD,'pchip');
    iPowerRight(:,i) = interp1(PD,PowerRight(:,i),iPD,'pchip');
end

%%%%%%%%%%%%%%%%%%%%%%% scaling based on swimming side-by-side %%%%%%%%%%%
EfficiencyLeft = Speed./PowerLeft;
EfficiencyRight = Speed./PowerRight;
MeanEfficiencyLeft = mean(EfficiencyLeft,2);
MeanEfficiencyRight = mean(EfficiencyRight,2);
StdEfficiencyLeft = std(EfficiencyLeft');
StdEfficiencyRight = std(EfficiencyRight');



iEfficiencyLeft = iSpeed./iPowerLeft;
iEfficiencyRight = iSpeed./iPowerRight;
iMeanEfficiencyLeft = mean(iEfficiencyLeft,2);
iMeanEfficiencyRight = mean(iEfficiencyRight,2);
iStdEfficiencyLeft = std(iEfficiencyLeft');
iStdEfficiencyRight = std(iEfficiencyRight');

% normalise accroding to first power cost 
StdEfficiencyLeft = StdEfficiencyLeft/MeanEfficiencyLeft(1);
StdEfficiencyRight = StdEfficiencyRight/MeanEfficiencyRight(1);
MeanEfficiencyLeft = MeanEfficiencyLeft/MeanEfficiencyLeft(1);
MeanEfficiencyRight = MeanEfficiencyRight/MeanEfficiencyRight(1);

iStdEfficiencyLeft = iStdEfficiencyLeft/iMeanEfficiencyLeft(1);
iStdEfficiencyRight = iStdEfficiencyRight/iMeanEfficiencyRight(1);
iMeanEfficiencyLeft = iMeanEfficiencyLeft/iMeanEfficiencyLeft(1);
iMeanEfficiencyRight = iMeanEfficiencyRight/iMeanEfficiencyRight(1);

% efficiency over all 
EfficiencyAll = Speed./(PowerLeft+PowerRight);
MeanEfficiencyAll = mean(EfficiencyAll,2);
StdEfficiencyAll = std(EfficiencyAll');


iEfficiencyAll = iSpeed./(iPowerLeft+iPowerRight);
iMeanEfficiencyAll = mean(iEfficiencyAll,2);
iStdEfficiencyAll = std(iEfficiencyAll');

% normalise
StdEfficiencyAll = StdEfficiencyAll/MeanEfficiencyAll(1);
MeanEfficiencyAll = MeanEfficiencyAll/MeanEfficiencyAll(1);

iStdEfficiencyAll = iStdEfficiencyAll/iMeanEfficiencyAll(1);
iMeanEfficiencyAll = iMeanEfficiencyAll/iMeanEfficiencyAll(1);


%% Plot power costs versus phase differences


% close
nf =3;   
hf(nf) =figure(nf);
clf
set(hf(nf),'Name','Power costs versus phase differences','NumberTitle','off');

% preset for figure
Col = 1; 
Row =1; 
figure_num = Col*Row; 
space_bottom=0.22;  
space_top=0.02;
space_left=0.12;
space_right=0.05;
space_UD=0.03;
space_LR = 0.09; 
space_legend=0 ;  
FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; 
FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col;  

WidthSubFig = 16 ; 
HighSubFig = 0.4*WidthSubFig; 




set(hf(nf),'Units', 'centimeters','Position',[57.9173   50.4246   WidthSubFig/FigWidth  HighSubFig/FigHigh], 'WindowStyle','normal' )



StrLS={'^','s','d','p'};
StrLegend = {'Power Cost of Left Robotic Fish', 'Power Cost of Right Robotic Fish', 'Swimming Speed of Schooling fish', 'Swimming Speed of alone fish'};

f =1 ;
% plot
s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);

sp1=shadedErrorBar(iPD,iMeanPowerLeft/FishAlone,iStdPowerLeft,{'linewidth',1.2,'Color',CouzinColor(1,:)},1);
hold on
plot(PD,MeanPowerLeft/FishAlone,'s','MarkerSize',10,'Color',CouzinColor(1,:));
hold on
ssp1 = plot(PD(1),MeanPowerLeft(1)/FishAlone,'-s','MarkerSize',10,'Color',CouzinColor(1,:),'LineWidth',1.2);
hold on
sp2 = shadedErrorBar(iPD,iMeanPowerRight/FishAlone,iStdPowerRight,{'linewidth',1.2,'Color',CouzinColor(3,:)},1);
hold on
plot(PD,MeanPowerRight/FishAlone,'^','MarkerSize',10,'Color',CouzinColor(3,:));
hold on
ssp2 = plot(PD(1),MeanPowerRight(1)/FishAlone,'-^','MarkerSize',10,'Color',CouzinColor(3,:),'LineWidth',1.2);
sp3=shadedErrorBar(iPD,(iMeanPowerLeft+iMeanPowerRight)/FishAlone/2,iStdPowerLeft+iStdPowerRight,{'linewidth',1.2,'Color',CouzinColor(4,:)},1);
hold on
plot(PD,(MeanPowerRight+MeanPowerLeft)/FishAlone/2,'o','MarkerSize',10,'Color',CouzinColor(4,:));
hold on
ssp3 = plot(PD(1),(MeanPowerRight(1)+MeanPowerLeft(1))/FishAlone/2,'-o','MarkerSize',10,'Color',CouzinColor(4,:),'LineWidth',1.2);

hold on
sp2 = plot([1,9],[FishAlone,FishAlone]/FishAlone,'--','LineWidth',1.2,'Color',CouzinColor(5,:));
set(gca,'XLim',[1 9],'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
    'XTick',[1 2 3 4 5 6 7 8 9],'FontSize',TV);
% set(gca,'YLim',[0 1.2],'XTickLabel',{},'FontSize',TV);
set(gca,'YLim',[0.4 1.45],'FontSize',TV)
box off;
ylabel('Power coefficient {\it P_{coe}}','FontSize',TV,'Rotation',90,'VerticalAlignment','middle','Position',[0.15 0.86]);
hl = legend([ssp1 ssp2 ssp3 sp2], 'Left','Right','(Left+Right)/2','Single');
set(hl, 'Box', 'off', 'Orientation','horizontal','Fontsize',TV,'Position',[0.2182    0.86    0.7037    0.0680]);
xlabel('Phase Difference [rad]','FontSize',TV)

if 1
    LLDataView.SaveFigure(gcf,'PowerAndSpeed');
    
end

%% Plot speeds versus phase differences

%  close
nf =4;   %%% figure numebr 

hf(nf) =figure(nf);
set(hf(nf),'Name','Speeds versus phase differences','NumberTitle','off'); 


Col = 1;  
Row =1; 
figure_num = Col*Row; 
space_bottom=0.22;  
space_top=0.04;
space_left=0.12;
space_right=0.05;
space_UD=0.03;
space_LR = 0.09; 
space_legend=0 ; 
FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row;
FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col; 

WidthSubFig = 16 ; 
HighSubFig = 0.4*WidthSubFig; 


set(hf(nf),'Units', 'centimeters','Position',[57.9173   10.4246   WidthSubFig/FigWidth  HighSubFig/FigHigh], 'WindowStyle','normal' )


StrLS={'^','s','d','p'};
StrLegend = {'Power Cost of Left Robotic Fish', 'Power Cost of Right Robotic Fish', 'Swimming Speed of Schooling fish', 'Swimming Speed of alone fish'};

f =1 ;

s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);

sp1=shadedErrorBar(iPD,iMeanSpeed/SingleSpeed,iStdSpeed,{'linewidth',1.2,'Color',CouzinColor(4,:)},1);
hold on
plot(PD,MeanSpeed/SingleSpeed,'s','MarkerSize',10,'Color',CouzinColor(4,:));
hold on
ssp1 = plot(PD(1),MeanSpeed(1)/SingleSpeed,'-s','MarkerSize',10,'Color',CouzinColor(4,:),'LineWidth',1.2);

hold on
sp2 = plot([1,9],[SingleSpeed,SingleSpeed]/SingleSpeed,'--','LineWidth',1.2,'Color',CouzinColor(5,:));
set(gca,'XLim',[1 9],'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
    'XTick',[1 2 3 4 5 6 7 8 9],'FontSize',TV);
box off;
ylabel('Speed coefficient {\it S_{coe}}','FontSize',TV,'Rotation',90,'VerticalAlignment','middle','Position',[0.15 1.07]);
hl = legend([ssp1 sp2], 'School','Single');
set(hl, 'Box', 'off', 'Orientation','horizontal','Fontsize',TV,'Position',[0.4382    0.9    0.7037    0.0680]);
xlabel('Phase Difference [rad]','FontSize',TV)
set(gca,'YLim',[0.9 1.3])

if 1
    LLDataView.SaveFigure(gcf,'SpeedOfPhase');
    
end

%% Plot efficiencies versus phase differences

%  close
nf =10;   

hf(nf) =figure(nf);
set(hf(nf),'Name','Efficiencies versus phase differences','NumberTitle','off'); 

Col = 1; 
Row =1; 
figure_num = Col*Row; 
space_bottom=0.22; 
space_top=0.04;
space_left=0.12;
space_right=0.05;
space_UD=0.03;
space_LR = 0.09; 
space_legend=0 ; 
FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; 
FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col; 

WidthSubFig = 16 ; 
HighSubFig = 0.4*WidthSubFig;


set(hf(nf),'Units', 'centimeters','Position',[57.9173   10.4246   WidthSubFig/FigWidth  HighSubFig/FigHigh], 'WindowStyle','normal' )


StrLS={'^','s','d','p'};
StrLegend = {'Power Cost of Left Robotic Fish', 'Power Cost of Right Robotic Fish', 'Swimming Speed of Schooling fish', 'Swimming Speed of alone fish'};

f =1 ;

s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
sp1=shadedErrorBar(iPD,iMeanEfficiencyLeft/SingleEfficiency,iStdEfficiencyLeft,{'linewidth',1.2,'Color',CouzinColor(1,:)},1);
hold on
plot(PD,MeanEfficiencyLeft/SingleEfficiency,'s','MarkerSize',10,'Color',CouzinColor(1,:));
hold on
ssp1 = plot(PD(1),MeanEfficiencyLeft(1)/SingleEfficiency,'-s','MarkerSize',10,'Color',CouzinColor(1,:),'LineWidth',1.2);
hold on
sp2 = shadedErrorBar(iPD,iMeanEfficiencyRight/SingleEfficiency,iStdEfficiencyRight,{'linewidth',1.2,'Color',CouzinColor(3,:)},1);
hold on
plot(PD,MeanEfficiencyRight/SingleEfficiency,'^','MarkerSize',10,'Color',CouzinColor(3,:));
hold on
ssp2 = plot(PD(1),MeanEfficiencyRight(1)/SingleEfficiency,'-^','MarkerSize',10,'Color',CouzinColor(3,:),'LineWidth',1.2);
sp3=shadedErrorBar(iPD,(iMeanEfficiencyLeft+iMeanEfficiencyRight)/SingleEfficiency/2,iStdEfficiencyLeft+iStdEfficiencyRight,{'linewidth',1.2,'Color',CouzinColor(4,:)},1);
hold on
plot(PD,(MeanEfficiencyLeft+MeanEfficiencyRight)/SingleEfficiency/2,'o','MarkerSize',10,'Color',CouzinColor(4,:));
hold on
ssp3 = plot(PD(1),(MeanEfficiencyLeft(1)+MeanEfficiencyRight(1))/SingleEfficiency/2,'-o','MarkerSize',10,'Color',CouzinColor(4,:),'LineWidth',1.2);

hold on
sp2 = plot([1,9],[SingleEfficiency,SingleEfficiency]/SingleEfficiency,'--','LineWidth',1.2,'Color',CouzinColor(5,:));
set(gca,'XLim',[1 9],'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
    'XTick',[1 2 3 4 5 6 7 8 9],'FontSize',TV);
set(gca,'YLim',[0.6 2.8],'FontSize',TV)
box off;
ylabel('Efficiency \eta','FontSize',TV,'Rotation',90,'VerticalAlignment','middle','Position',[0.2 1.6]);
hl = legend([ssp1 ssp2 ssp3 sp2], 'Left','Right','(Left+Right)/2','Single');
set(hl, 'Box', 'off', 'Orientation','horizontal','Fontsize',TV,'Position',[0.2182    0.86    0.7037    0.0680]);
xlabel('Phase Difference [rad]','FontSize',TV)

if 1
    LLDataView.SaveFigure(gcf,'Efficiency')
    
end

