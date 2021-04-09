clc
clear
close all




FileNames = {'PowerLeft.txt','PowerRight.txt','PowerAlone.txt'};

PowerLeft = load(['./data/',FileNames{1}]);
PowerRight = load(['./data/',FileNames{2}]);
PowerAlone = load(['./data/',FileNames{3}]);
PowerAlone = mean(PowerAlone,1);

%%

% alone
Powers = PowerAlone';
Cases   = repmat('      Alone       ',[5,1]);

% left
for ii = 1: 9
    
    Powers = cat(1,Powers,PowerLeft(ii,:)');
    formatSpec = '%.2f';
    Cases = cat(1,Cases,repmat(['Left_{PD}=',num2str((ii-1)*0.25,formatSpec),'\pi ' ],[5,1]));
end

% right
for ii = 1: 9
    Powers = cat(1,Powers,PowerRight(ii,:)');
    formatSpec = '%.2f';
    Cases = cat(1,Cases,repmat(['Right_{PD}=',num2str((ii-1)*0.25,formatSpec),'\pi' ],[5,1]));
end


% all
for ii = 1: 9
    Powers = cat(1,Powers,(PowerRight(ii,:)'+PowerLeft(ii,:)')/2 );
    formatSpec = '%.2f';
    Cases = cat(1,Cases,repmat([' All_{PD}=',num2str((ii-1)*0.25,formatSpec),'\pi ' ],[5,1]));
end

%%

[p,t,stats] = anova1(Powers,Cases,'off');
[c,m,h,gnames] = multcompare(stats,'CType','bonferroni');



%% plot as a heatmap
close all
len = length(gnames);
p_matrix = ones(len,len);

for ii = 1: length(c)
    p_matrix(c(ii,1),c(ii,2)) = c(ii,6);
end

for ii = 1: length(c)
    p_matrix(c(ii,2),c(ii,1)) = c(ii,6);
end


% h = HeatMap(p_matrix,'RowLabels',gnames,'ColumnLabels',gnames);

% h = HeatMap(p_matrix,'Colormap','jet','DisplayRange',1);

imagesc(p_matrix);

 
% hp = plot(h);

ticks = (1:len);
set(gca,'XAxisLocation','top','XTick',ticks,'XTickLabel',gnames,'XTickLabelRotation',45,...
'YTick',ticks,'YTickLabel',gnames,'YTickLabelRotation',45,'YDir','reverse','fontsize',12);
set(gca,'TickDir','out');

hc = colorbar;
hc.Label.String = 'p value';
hc.Label.FontSize = 12;

hold on;
for row = 1  : len+1
  hl = line([0.5, len+0.5], [row-0.5, row-0.5], 'Color', 'k');
  hl.Color(4) = 0.5;
end
for col = 1 : len+1
  hl = line([col-0.5, col-0.5], [0.5, len+0.5], 'Color', 'k');
  hl.Color(4) = 0.5;
end

set(gcf,'Position', [35.2425   17.0392   35.7717   30.0919]);
LLDataView.SaveFigure(gcf,'p_value');
    


%% swimming speed
FileNames = {'Speed.txt'};

speed_pair = load(['./data/',FileNames{1}]);
speed_alone = 22.8;


% alone
Speeds = speed_alone;
Cases   = repmat('   Alone     ',[1,1]);

% left
for ii = 1: 9
    
    Speeds = cat(1,Speeds,speed_pair(ii,:)');
    formatSpec = '%.2f';
    Cases = cat(1,Cases,repmat(['{PD}=',num2str((ii-1)*0.25,formatSpec),'\pi ' ],[5,1]));
end

%% 
[p,t,stats] = anova1(Speeds,Cases,'off');
[c,m,h,gnames] = multcompare(stats,'CType','bonferroni');

%% 
close all
len = length(gnames);
p_matrix = ones(len,len);

for ii = 1: length(c)
    p_matrix(c(ii,1),c(ii,2)) = c(ii,6);
end

for ii = 1: length(c)
    p_matrix(c(ii,2),c(ii,1)) = c(ii,6);
end


% h = HeatMap(p_matrix,'RowLabels',gnames,'ColumnLabels',gnames);

% h = HeatMap(p_matrix,'Colormap','jet','DisplayRange',1);

imagesc(p_matrix);

 
% hp = plot(h);

ticks = (1:len);
set(gca,'XAxisLocation','top','XTick',ticks,'XTickLabel',gnames,'XTickLabelRotation',45,...
'YTick',ticks,'YTickLabel',gnames,'YTickLabelRotation',45,'YDir','reverse','fontsize',12);
set(gca,'TickDir','out');

hc = colorbar;
hc.Label.String = 'p value';
hc.Label.FontSize = 12;

hold on;
for row = 1  : len+1
  hl = line([0.5, len+0.5], [row-0.5, row-0.5], 'Color', 'k');
  hl.Color(4) = 0.5;
end
for col = 1 : len+1
  hl = line([col-0.5, col-0.5], [0.5, len+0.5], 'Color', 'k');
  hl.Color(4) = 0.5;
end

% set(gcf,'Position', [35.2425   17.0392   35.7717   30.0919]);
% LLDataView.SaveFigure(gcf,'p_value');
