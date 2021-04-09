close all
clear all
clc

%% Read Original data and save average
if 1
FileName = './data/speed.xlsx';
Speed = {'Sheet9','Sheet1','Sheet2','Sheet3','Sheet4','Sheet5','Sheet6','Sheet7','Sheet8'};
% Speed = {'Sheet1','Sheet2','Sheet3','Sheet4','Sheet5'};
SpeedColumn = 'A:A';

SpeedData = cell(size(Speed));


for i = 1:size(Speed,2)
    
 SpeedData{i}=(xlsread(FileName,Speed{i},SpeedColumn))/2.5;
 
 MeanSpeedData(i,:) = mean(SpeedData{i});
 
MeanAllSpeedData(i) = mean(MeanSpeedData(i,:));

StdSpeedData(i) = std( SpeedData{i})/sqrt(5);

end

hb(1) = errorbar(MeanAllSpeedData,StdSpeedData,'r','linewidth',2);

set(gca,'XTickLabel',{'0I','1/4PI','1/2PI','3/4PI','PI','5/4PI','3/2PI','7/4PI','2PI'},...
    'XTick',[1 2 3 4 5 6 7 8 9]);

xlabel('Phase difference')
ylabel('Speed, (cm/s)')

%% Save Data

fid=fopen('./data/MeanSpeed.txt','wt');
[m,n]=size(MeanAllSpeedData);
 for i=1:1:m
    for j=1:1:n
       if j==n
         fprintf(fid,'%g\n',MeanAllSpeedData(i,j));
      else
        fprintf(fid,'%g\t',MeanAllSpeedData(i,j));
       end
    end
end
fclose(fid);

fid=fopen('./data/StdSpeed.txt','wt');
[m,n]=size(StdSpeedData);
 for i=1:1:m
    for j=1:1:n
       if j==n
         fprintf(fid,'%g\n',StdSpeedData(i,j));
      else
        fprintf(fid,'%g\t',StdSpeedData(i,j));
       end
    end
end
fclose(fid);

end

%% plot
%clear all
CouzinColor=[235 45 46;
                       241 161 43;
                       0 170 79;
                       0 174 239;
                       35 31 32]/255;
PD = 1:9;

MeanSpeed=load('./data/MeanSpeed.txt');
StdSpeed=load('./data/StdSpeed.txt');

StdSpeed = StdSpeed/MeanSpeed(1);
MeanSpeed = MeanSpeed/MeanSpeed(1);

iPD=1:0.1:9;
iMeanSpeed=interp1(PD,MeanSpeed,iPD,'pchip');
iStdSpeed = interp1(PD,StdSpeed,iPD,'pchip');

shadedErrorBar(iPD,iMeanSpeed, iStdSpeed,{'linewidth',1.2,'Color',CouzinColor(1,:)},1);