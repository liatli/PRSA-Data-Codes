classdef LLDataView
    properties
        
    end
    methods (Static)
        %% Plot Fish swimming Information
        function PlotFishInfo(t,Leader,Follower,Fish,paras)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %input t
            %input Leader as struct; Leader.A  (amplitude); Leader.phase
            %(Phase); Leader.Am_filter; Follower.Am_filter;
            %Follower.min_Am; Follower.max_Am
            %input the descriptions between Leader and Follower, Fish.lrd,
            %Fish.fbd;Fish.pd
            
            
            switch nargin
                case 4
                    paras.FigResults.sub1.yPosition = [-0.18 0.05 -1];
                    paras.FigResults.sub1.text.x = 2.9;
                    paras.FigResults.sub1.text.y = -0.0737;
                    paras.FigResults.sub1.LegendPosition = [0.1162    0.9406    0.3162    0.0349];
                    
                    
                    paras.FigResults.sub2.yPosition = [-0.1800    0.05   -1.0000];
                    paras.FigResults.sub2.text.x = 2.9;
                    paras.FigResults.sub2.text.y = -0.0484;
                    paras.FigResults.sub2.LegendPosition = [0.1089    0.7806    0.4602    0.0349];
                    
                    paras.FigResults.sub3.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub3.text.x = 2.8877;
                    paras.FigResults.sub3.text.y = 0.9806;
                    paras.FigResults.sub3.LegendPosition = [0.7772    0.6642    0.1658    0.0349];
                    
                    paras.FigResults.sub4.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub4.text.x = 2.9;
                    paras.FigResults.sub4.text.y = 2.2197;
                    paras.FigResults.sub4.LegendPosition = [ 0.1066    0.4756    0.1705    0.0344];
                    
                    paras.FigResults.sub5.yPosition = [-0.18 0.5 -1];
                    paras.FigResults.sub5.text.x = 2.9;
                    paras.FigResults.sub5.text.y = 0.3818;
                    paras.FigResults.sub5.LegendPosition = [0.1073    0.3246    0.1896    0.0347];
                    
                    paras.FigResults.sub6.yPosition = [-0.18 0.25 -1];
                    paras.FigResults.sub6.text.x = 2.9;
                    paras.FigResults.sub6.text.y = 0.1710;
                    paras.FigResults.sub6.LegendPosition = [0.1066    0.1808    0.2000    0.0347];
                    
                    paras.FigPDvsFBD.text.x = 1.4962;
                    paras.FigPDvsFBD.text.y= 0.35;
                    paras.FigPDvsFBD.LegendPosition = [0.2088    0.3726    0.4554    0.1631];
                    
                    paras.FigFFT.sub1.text.x = 40;
                    paras.FigFFT.sub1.text.y = 5;
                    paras.FigFFT.sub2.text.x = 40;
                    paras.FigFFT.sub2.text.y = 5;
                    
                otherwise
                    disp('check input')
            end
            
            
            % close all
            nf = findobj('Name','RealFishResults');
            if isempty(nf )
                nf = figure('Name','RealFishResults');
            else
                figure(nf);
                clf
            end
            
            CouzinColor=[235 45 46;
                241 161 43;
                0 170 79;
                0 174 239;
                35 31 32;
                255 127 0]/255;
            TV = 28; %字体12
            LV = 3.5; % LineWidth
            
            % nf = 100;   %%%%设定figure的值
            % % PlotValue =figure('Name','MaxPowerCost','NumberTitle','off');
            % hf(nf) =figure(nf);
            % set(hf(nf),'Name','RealFishResults','NumberTitle','off'); %%%%设定值
            
            
            Col = 1;  %%%%设定值，几列图片
            Row =6; %%%%设定值，几行图片
            figure_num = Col*Row; %作图个数
            space_bottom=0.08;  % 底部间�? %%%%设定值
            space_top=0.02;%顶部间�?  %%%%设定值
            space_left=0.1;%左间�?  %%%%设定值
            space_right=0.05;%�?�间�?  %%%%设定值
            space_UD=0.02;%图片上下间�?  %%%%设定值
            space_LR = 0.09; % 图片左�?�间�?  %%%%设定值
            space_legend=0 ;  %图和标注之间的�?离设置  %%%%设定值
            FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; %%%%设定值
            FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col;  %设置图片的 %%%%设定值
            
            WidthSubFig = 6 ; % �?图宽度为5 %%%%设定值
            HighSubFig = 0.3*WidthSubFig;   %%%%设定值
            
            set(nf,'Units', 'centimeters','Position',[27.0228   11.9239   50.9411   35.0661], 'WindowStyle','normal' )
            
            % set(hf(nf),'Units', 'centimeters','Position',[2064 67 924 916])
            
            StrLS={'^','s','d','p'};  % 设定绘制曲线的symbols
            
            
            StrLegend = {'Power Cost of Left Robotic Fish', ...
                'Power Cost of Right Robotic Fish', ...
                'Swimming Speed of Schooling fish',...
                'Swimming Speed of alone fish'};  % 设定 Legend 的字符
            
            f =1 ;
            % 绘制
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Leader.A,'Color',CouzinColor(1,:),'LineWidth',LV)
            hold on
            plot(t,Follower.A,'Color',CouzinColor(4,:),'LineWidth',LV)
            
            
            Temp_Ylim  = [
                min(min(Leader.A),min(Follower.A))
                max(max(Leader.A),max(Follower.A))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$A~ [BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub1.yPosition);
            hl(f) = legend('$L_t$ of the Leader','$L_t$ of the Follower');
            set(hl(f),'Interpreter','latex','Orientation','horizontal','Position',paras.FigResults.sub1.LegendPosition);
            ht(f) = text(paras.FigResults.sub1.text.x,paras.FigResults.sub1.text.y,'(a)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            legend boxoff
            
            
            f = 2;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            plot(t,Follower.A,'Color',CouzinColor(4,:),'LineWidth',LV);
            hold on
            plot(t,Follower.Am_filter,'Color',CouzinColor(6,:),'LineWidth',LV);
            % hold on
            plot(Follower.min_Am(:,1), Follower.min_Am(:,2), 'g*','MarkerSize',10);
            % hold on
            plot(Follower.max_Am(2:end,1), Follower.max_Am(2:end,2), 'r*','MarkerSize',10);
            
            Temp_Ylim  = [
                min(min(Follower.A),min(Follower.A))
                max(max(Follower.A),max(Follower.A))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$A~ [BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub2.yPosition);
            hl(f) = legend('$L_t$ of the Follower','filtered $L_t$','the valley','the peak','Location','NorthWest');
            set(hl(f),'Interpreter','latex','Orientation','horizontal','Position',paras.FigResults.sub2.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub2.text.x,paras.FigResults.sub2.text.y,'(b)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            
            f = 3;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            plot(t,Leader.phase,'Color',CouzinColor(1,:),'LineWidth',LV);
            hold on
            plot(t,Follower.phase,'Color',CouzinColor(4,:),'LineWidth',LV);
            
            Temp_Ylim  = [
                min(min(Leader.phase),min(Follower.phase)),
                1.05*max(max(Leader.phase),1.05*max(Follower.phase))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0 pi 2*pi],...
                'YTickLabel',{'0', '\pi', '2\pi'},'XColor',[1,1,1]);
            box off;
            hy(f)=ylabel('$\phi~ [rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub3.yPosition);
            hl(f)= legend('Leader','Follower');
            set(hl(f),'Orientation','horizontal','Interpreter','latex','Position',[paras.FigResults.sub3.LegendPosition]);
            legend boxoff
            ht(f) = text(paras.FigResults.sub3.text.x,paras.FigResults.sub3.text.y,'(c)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            f = 4;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Fish.pd,'color',CouzinColor(3,:),'LineWidth',LV);
            
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',[min(Fish.pd) 1.05*max(Fish.pd)],'YTick',[0 pi 2*pi 3*pi],...
                'YTickLabel',{'0', '\pi', '2\pi', '3\pi'},'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$\Phi~[rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub4.yPosition)
            hl(f)= legend('Phase difference $\Phi$');
            set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub4.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub4.text.x,paras.FigResults.sub4.text.y,'(d)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            f = 5;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t, Fish.lrd, 'Color',CouzinColor(2,:),'LineWidth',LV)
            Temp_Ylim  = [
                min(min(Fish.lrd),min(Fish.lrd))
                max(max(Fish.lrd),max(Fish.lrd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            set(gca,'FontSize',TV);
            box off;
            hy(f) = ylabel('$G ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub5.yPosition)
            hl(f)= legend('Left-right distance $G$');
            set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub5.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub5.text.x,paras.FigResults.sub5.text.y,'(e)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            f = 6;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            % shadedErrorBar(PD,MeanEfficiencyAll, StdEfficiencyAll,{'linewidth',1.2,'Color',CouzinColor(4,:)},1);
            % set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
            %     'XTick',[1 2 3 4 5 6 7 8 9]);
            plot(t, Fish.fbd, 'Color',CouzinColor(5,:),'LineWidth',LV)
            Temp_Ylim  = [
                min(min(Fish.fbd),min(Fish.fbd))
                max(max(Fish.fbd),max(Fish.fbd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            % set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0.05 0.15 0.25],'YTickLabel',{'0.05','0.15','0.25'});
            set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim);
            set(gca,'FontSize',TV);
            box off;
            hy(f) = ylabel('$D ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub6.yPosition)
            xlabel('t [s]','FontSize',TV);
            hl(f)= legend('Front-back distance $D$','Location','NorthWest');
            set(hl(f),'Interpreter','latex','position',paras.FigResults.sub6.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub6.text.x,paras.FigResults.sub6.text.y,'(f)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
        end
        
        
        
        %% Plot Fish swimming Information
        function PlotFishInfoPDexplain(t,Leader,Follower,Fish,paras)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %input t
            %input Leader as struct; Leader.A  (amplitude); Leader.phase
            %(Phase); Leader.Am_filter; Follower.Am_filter;
            %Follower.min_Am; Follower.max_Am
            %input the descriptions between Leader and Follower, Fish.lrd,
            %Fish.fbd;Fish.pd
            
            
            switch nargin
                case 4
                    paras.FigResults.sub1.yPosition = [-0.18 0.05 -1];
                    paras.FigResults.sub1.text.x = 2.9;
                    paras.FigResults.sub1.text.y = -0.0737;
                    paras.FigResults.sub1.LegendPosition = [0.1162    0.9406    0.3162    0.0349];
                    
                    
                    paras.FigResults.sub2.yPosition = [-0.1800    0.05   -1.0000];
                    paras.FigResults.sub2.text.x = 2.9;
                    paras.FigResults.sub2.text.y = -0.0484;
                    paras.FigResults.sub2.LegendPosition = [0.1089    0.7806    0.4602    0.0349];
                    
                    paras.FigResults.sub3.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub3.text.x = 2.8877;
                    paras.FigResults.sub3.text.y = 0.9806;
                    paras.FigResults.sub3.LegendPosition = [0.7772    0.6642    0.1658    0.0349];
                    
                    paras.FigResults.sub4.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub4.text.x = 2.9;
                    paras.FigResults.sub4.text.y = 2.2197;
                    paras.FigResults.sub4.LegendPosition = [ 0.1066    0.4756    0.1705    0.0344];
                    
                    paras.FigResults.sub5.yPosition = [-0.18 0.5 -1];
                    paras.FigResults.sub5.text.x = 2.9;
                    paras.FigResults.sub5.text.y = 0.3818;
                    paras.FigResults.sub5.LegendPosition = [0.1073    0.3246    0.1896    0.0347];
                    
                    paras.FigResults.sub6.yPosition = [-0.18 0.25 -1];
                    paras.FigResults.sub6.text.x = 2.9;
                    paras.FigResults.sub6.text.y = 0.1710;
                    paras.FigResults.sub6.LegendPosition = [0.1066    0.1808    0.2000    0.0347];
                    
                    paras.FigPDvsFBD.text.x = 1.4962;
                    paras.FigPDvsFBD.text.y= 0.35;
                    paras.FigPDvsFBD.LegendPosition = [0.2088    0.3726    0.4554    0.1631];
                    
                    paras.FigFFT.sub1.text.x = 40;
                    paras.FigFFT.sub1.text.y = 5;
                    paras.FigFFT.sub2.text.x = 40;
                    paras.FigFFT.sub2.text.y = 5;
                    
                otherwise
                    disp('check input')
            end
            
            
            % close all
            nf = findobj('Name','RealFishResults');
            if isempty(nf )
                nf = figure('Name','RealFishResults');
            else
                figure(nf);
                clf
            end
            
            CouzinColor=[235 45 46;
                241 161 43;
                0 170 79;
                0 174 239;
                35 31 32;
                255 127 0]/255;
            TV = 28; %字体12
            LV = 3.5; % LineWidth
            
            % nf = 100;   %%%%设定figure的值
            % % PlotValue =figure('Name','MaxPowerCost','NumberTitle','off');
            % hf(nf) =figure(nf);
            % set(hf(nf),'Name','RealFishResults','NumberTitle','off'); %%%%设定值
            
            
            Col = 1;  %%%%设定值，几列图片
            Row =6; %%%%设定值，几行图片
            figure_num = Col*Row; %作图个数
            space_bottom=0.08;  % 底部间�? %%%%设定值
            space_top=0.02;%顶部间�?  %%%%设定值
            space_left=0.1;%左间�?  %%%%设定值
            space_right=0.05;%�?�间�?  %%%%设定值
            space_UD=0.02;%图片上下间�?  %%%%设定值
            space_LR = 0.09; % 图片左�?�间�?  %%%%设定值
            space_legend=0 ;  %图和标注之间的�?离设置  %%%%设定值
            FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; %%%%设定值
            FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col;  %设置图片的 %%%%设定值
            
            WidthSubFig = 6 ; % �?图宽度为5 %%%%设定值
            HighSubFig = 0.3*WidthSubFig;   %%%%设定值
            
            set(nf,'Units', 'centimeters','Position',[27.0228   11.9239   50.9411   35.0661], 'WindowStyle','normal' )
            
            % set(hf(nf),'Units', 'centimeters','Position',[2064 67 924 916])
            
            StrLS={'^','s','d','p'};  % 设定绘制曲线的symbols
            
            
            StrLegend = {'Power Cost of Left Robotic Fish', ...
                'Power Cost of Right Robotic Fish', ...
                'Swimming Speed of Schooling fish',...
                'Swimming Speed of alone fish'};  % 设定 Legend 的字符
            
            f =1 ;
            % 绘制
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Leader.A,'Color',CouzinColor(1,:),'LineWidth',LV)
            hold on
            plot(t,Follower.A,'Color',CouzinColor(4,:),'LineWidth',LV)
            
            
            Temp_Ylim  = [
                min(min(Leader.A),min(Follower.A))
                max(max(Leader.A),max(Follower.A))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$A~ [BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub1.yPosition);
            hl(f) = legend('$L_t$ of the Leader','$L_t$ of the Follower');
            set(hl(f),'Interpreter','latex','Orientation','horizontal','Position',paras.FigResults.sub1.LegendPosition);
            ht(f) = text(paras.FigResults.sub1.text.x,paras.FigResults.sub1.text.y,'(a)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            legend boxoff
            
            

            
            
            f = 2;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Leader.phase,'Color',CouzinColor(1,:),'LineWidth',LV);
            hold on
            plot(t,Follower.phase,'Color',CouzinColor(4,:),'LineWidth',LV);
            
            Temp_Ylim  = [
                min(min(Leader.phase),min(Follower.phase)),
                1.05*max(max(Leader.phase),1.05*max(Follower.phase))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0 pi 2*pi],...
                'YTickLabel',{'0', '\pi', '2\pi'},'XColor',[1,1,1]);
            box off;
            hy(f)=ylabel('$\phi~ [rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub3.yPosition);
            hl(f)= legend('Leader','Follower');
            set(hl(f),'Orientation','horizontal','Interpreter','latex','Position',[paras.FigResults.sub3.LegendPosition]);
            legend boxoff
            ht(f) = text(paras.FigResults.sub3.text.x,paras.FigResults.sub3.text.y,'(c)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            
            f = 3;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            tempPD = LLDataInfo.Peridic(Fish.pd);
            plot(t,tempPD,'Color',CouzinColor(4,:),'LineWidth',LV);
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$\Phi~ [rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub2.yPosition);
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0 pi 2*pi],...
                'YTickLabel',{'0', '\pi', '2\pi'},'XColor',[1,1,1]);
%             hl(f) = legend('$L_t$ of the Follower','filtered $L_t$','the valley','the peak','Location','NorthWest');
%             set(hl(f),'Interpreter','latex','Orientation','horizontal','Position',paras.FigResults.sub2.LegendPosition);
%             legend boxoff
%             ht(f) = text(paras.FigResults.sub2.text.x,paras.FigResults.sub2.text.y,'(b)');
%             set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            
            f = 4;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Fish.pd,'color',CouzinColor(3,:),'LineWidth',LV);
            
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',[min(Fish.pd) 1.05*max(Fish.pd)],'YTick',[0 pi 2*pi 3*pi],...
                'YTickLabel',{'0', '\pi', '2\pi', '3\pi'},'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$\Phi~[rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub4.yPosition)
            hl(f)= legend('Phase difference $\Phi$');
            set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub4.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub4.text.x,paras.FigResults.sub4.text.y,'(d)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            f = 5;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t, Fish.lrd, 'Color',CouzinColor(2,:),'LineWidth',LV)
            Temp_Ylim  = [
                min(min(Fish.lrd),min(Fish.lrd))
                max(max(Fish.lrd),max(Fish.lrd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            set(gca,'FontSize',TV);
            box off;
            hy(f) = ylabel('$G ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub5.yPosition)
            hl(f)= legend('Left-right distance $G$');
            set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub5.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub5.text.x,paras.FigResults.sub5.text.y,'(e)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            f = 6;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            % shadedErrorBar(PD,MeanEfficiencyAll, StdEfficiencyAll,{'linewidth',1.2,'Color',CouzinColor(4,:)},1);
            % set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
            %     'XTick',[1 2 3 4 5 6 7 8 9]);
            plot(t, Fish.fbd, 'Color',CouzinColor(5,:),'LineWidth',LV)
            Temp_Ylim  = [
                min(min(Fish.fbd),min(Fish.fbd))
                max(max(Fish.fbd),max(Fish.fbd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            % set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0.05 0.15 0.25],'YTickLabel',{'0.05','0.15','0.25'});
            set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim);
            set(gca,'FontSize',TV);
            box off;
            hy(f) = ylabel('$D ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub6.yPosition)
            xlabel('t [s]','FontSize',TV);
            hl(f)= legend('Front-back distance $D$','Location','NorthWest');
            set(hl(f),'Interpreter','latex','position',paras.FigResults.sub6.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub6.text.x,paras.FigResults.sub6.text.y,'(f)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
        end        
        
        function PlotFishInfoCombiningFilter(t,Leader,Follower,Fish,paras)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %input t
            %input Leader as struct; Leader.A  (amplitude); Leader.phase
            %(Phase); Leader.Am_filter; Follower.Am_filter;
            %Follower.min_Am; Follower.max_Am
            %input the descriptions between Leader and Follower, Fish.lrd,
            %Fish.fbd;Fish.pd
            
            
            switch nargin
                case 4
                    paras.FigResults.sub1.yPosition = [-0.18 0.05 -1];
                    paras.FigResults.sub1.text.x = 2.9;
                    paras.FigResults.sub1.text.y = -0.0737;
                    paras.FigResults.sub1.LegendPosition = [0.1162    0.9406    0.3162    0.0349];
                    
                    
                    paras.FigResults.sub2.yPosition = [-0.1800    0.05   -1.0000];
                    paras.FigResults.sub2.text.x = 2.9;
                    paras.FigResults.sub2.text.y = -0.0484;
                    paras.FigResults.sub2.LegendPosition = [0.1089    0.7806    0.4602    0.0349];
                    
                    paras.FigResults.sub3.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub3.text.x = 2.8877;
                    paras.FigResults.sub3.text.y = 0.9806;
                    paras.FigResults.sub3.LegendPosition = [0.7772    0.6642    0.1658    0.0349];
                    
                    paras.FigResults.sub4.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub4.text.x = 2.9;
                    paras.FigResults.sub4.text.y = 2.2197;
                    paras.FigResults.sub4.LegendPosition = [ 0.1066    0.4756    0.1705    0.0344];
                    
                    paras.FigResults.sub5.yPosition = [-0.18 0.5 -1];
                    paras.FigResults.sub5.text.x = 2.9;
                    paras.FigResults.sub5.text.y = 0.3818;
                    paras.FigResults.sub5.LegendPosition = [0.1073    0.3246    0.1896    0.0347];
                    
                    paras.FigResults.sub6.yPosition = [-0.18 0.25 -1];
                    paras.FigResults.sub6.text.x = 2.9;
                    paras.FigResults.sub6.text.y = 0.1710;
                    paras.FigResults.sub6.LegendPosition = [0.1066    0.1808    0.2000    0.0347];
                    
                    paras.FigPDvsFBD.text.x = 1.4962;
                    paras.FigPDvsFBD.text.y= 0.35;
                    paras.FigPDvsFBD.LegendPosition = [0.2088    0.3726    0.4554    0.1631];
                    
                    paras.FigFFT.sub1.text.x = 40;
                    paras.FigFFT.sub1.text.y = 5;
                    paras.FigFFT.sub2.text.x = 40;
                    paras.FigFFT.sub2.text.y = 5;
                    
                otherwise
                    disp('check input')
            end
            
            
            % close all
            nf = findobj('Name','RealFishResultsCombiningFilter');
            if isempty(nf )
                nf = figure('Name','RealFishResultsCombiningFilter','Position',[3081         606         1000         550]);
            else
                figure(nf);
                clf
            end
            
            alpha = 0.65 *255;
            CouzinColor=[235 45 46 alpha;
                241 161 43 alpha;
                0 170 79 alpha;
                0 174 239 255;
                35 31 32 alpha;
                255 127 0 alpha]/255;
            TV = 26; %字体12
            LV = 3; % LineWidth
            
            % nf = 100;   %%%%设定figure的值
            % % PlotValue =figure('Name','MaxPowerCost','NumberTitle','off');
            % hf(nf) =figure(nf);
            % set(hf(nf),'Name','RealFishResults','NumberTitle','off'); %%%%设定值
            
            
            Col = 1;  %%%%设定值，几列图片
            Row =5; %%%%设定值，几行图片
            figure_num = Col*Row; %作图个数
            space_bottom=0.12;  % 底部间�? %%%%设定值
            space_top=0.04;%顶部间�?  %%%%设定值
            space_left=0.1;%左间�?  %%%%设定值
            space_right=0.05;%�?�间�?  %%%%设定值
            space_UD=0.02;%图片上下间�?  %%%%设定值
            space_LR = 0.09; % 图片左�?�间�?  %%%%设定值
            space_legend=0 ;  %图和标注之间的�?离设置  %%%%设定值
            FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; %%%%设定值
            FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col;  %设置图片的 %%%%设定值
            
            WidthSubFig = 6 ; % �?图宽度为5 %%%%设定值
            HighSubFig = 0.3*WidthSubFig;   %%%%设定值
            
            %             set(nf,'Units', 'centimeters','Position',[27.0228   11.9239   50.9411   35.0661], 'WindowStyle','normal' )
            
            % set(hf(nf),'Units', 'centimeters','Position',[2064 67 924 916])
            
            StrLS={'^','s','d','p'};  % 设定绘制曲线的symbols
            
            
            StrLegend = {'Power Cost of Left Robotic Fish', ...
                'Power Cost of Right Robotic Fish', ...
                'Swimming Speed of Schooling fish',...
                'Swimming Speed of alone fish'};  % 设定 Legend 的字符
            
            f =1 ;
            % 绘制
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Leader.A,'Color',CouzinColor(1,:),'LineWidth',LV)
            hold on
            plot(t,Follower.A,'Color',CouzinColor(4,:),'LineWidth',LV)
            plot(t,Follower.Am_filter,'Color',CouzinColor(6,:),'LineWidth',LV);
            plot(Follower.min_Am(:,1), Follower.min_Am(:,2), 'g*','MarkerSize',6);
            disp('All the valley of the undulation of the follower')
            Valley_Follower = Follower.min_Am(:,1);
            % hold on
            plot(Follower.max_Am(2:end,1), Follower.max_Am(2:end,2), 'm*','MarkerSize',6);
            
            
            Temp_Ylim  = [
                min(min(Leader.A),min(Follower.A))
                max(max(Leader.A),max(Follower.A))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$L_t~ [BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub1.yPosition);
            hl(f) = legend('$L_t$ Leader','$L_t$ Follower','Filtered $L_t$ Follower','Valley','Peak');
            set(hl(f),'Interpreter','latex','Orientation','horizontal','Position',paras.FigResults.sub1.LegendPosition);
            ht(f) = text(paras.FigResults.sub1.text.x,paras.FigResults.sub1.text.y,'(a)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            legend boxoff
            
            
            %             f = 2;
            %             s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            %
            %                 plot(t,Follower.A,'Color',CouzinColor(4,:),'LineWidth',LV);
            %                 hold on
            %                 plot(t,Follower.Am_filter,'Color',CouzinColor(6,:),'LineWidth',LV);
            %                 % hold on
            %                 plot(Follower.min_Am(:,1), Follower.min_Am(:,2), 'g*','MarkerSize',10);
            %                 % hold on
            %                 plot(Follower.max_Am(2:end,1), Follower.max_Am(2:end,2), 'r*','MarkerSize',10);
            %
            %             Temp_Ylim  = [
            %                 min(min(Follower.A),min(Follower.A))
            %                 max(max(Follower.A),max(Follower.A))
            %                 ];
            %             Temp_Xlim = [min(t) max(t)] ;
            %             set(gca,'XTickLabel',{},'FontSize',TV,...
            %                 'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            %             box off;
            %             hy(f) = ylabel('$A~ [BL]$','FontSize',TV,'Rotation',90);
            %             set(hy(f),'Position',paras.FigResults.sub2.yPosition);
            %             hl(f) = legend('$L_t$ of the Follower','filtered $L_t$','the valley','the peak','Location','NorthWest');
            %             set(hl(f),'Interpreter','latex','Orientation','horizontal','Position',paras.FigResults.sub2.LegendPosition);
            %             legend boxoff
            %             ht(f) = text(paras.FigResults.sub2.text.x,paras.FigResults.sub2.text.y,'(b)');
            %             set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            
            f = 2;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            if strcmp( paras.PlotFlag, 'PhaseWithoutJump')
                hs = LLDataView.PhasePlotWithoutJump(t,Leader.phase);
                for ihs = 1:length(hs)
                    set(hs(ihs),'Color',CouzinColor(1,:),'LineWidth',LV) ;
                end
                hold on
                hs = LLDataView.PhasePlotWithoutJump(t,Follower.phase);
                for ihs = 1:length(hs)
                    set(hs(ihs),'Color',CouzinColor(4,:),'LineWidth',LV) ;
                end
            else
                plot(t,Leader.phase,'Color',CouzinColor(1,:),'LineWidth',LV);
                hold on
                plot(t,Follower.phase,'Color',CouzinColor(4,:),'LineWidth',LV);
            end
            
%             Temp_Ylim  = [
%                 min(min(Leader.phase),min(Follower.phase)),
%                 1.05*max(max(Leader.phase),1.05*max(Follower.phase))
%                 ];
            Temp_Ylim  = [
                0,
                1.05*max(max(Leader.phase),1.05*max(Follower.phase))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0 pi 2*pi],...
                'YTickLabel',{'0', '\pi', '2\pi'},'XColor',[1,1,1]);
            box off;
            hy(f)=ylabel('$\phi~ [rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub3.yPosition);
            hl(f)= legend(s(f).Children([10,1]),'$\phi$ Leader','$\phi$ Follower');
            set(hl(f),'Orientation','horizontal','Interpreter','latex','Position',[paras.FigResults.sub3.LegendPosition]);
            legend boxoff
            ht(f) = text(paras.FigResults.sub3.text.x,paras.FigResults.sub3.text.y,'(c)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            
            f = 3;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Fish.pd,'color',CouzinColor(3,:),'LineWidth',LV);
            
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',[0 1.05*max(Fish.pd)],'YTick',[0 1.5*pi 3*pi],...
                'YTickLabel',{'0', '1.5\pi', '3\pi'},'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$\Phi~[rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub4.yPosition)
            hl(f)= legend('Phase Difference $\Phi$');
            set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub4.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub4.text.x,paras.FigResults.sub4.text.y,'(d)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            f = 4;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t, Fish.lrd, 'Color',CouzinColor(2,:),'LineWidth',LV)
            Temp_Ylim  = [
                min(min(Fish.lrd),min(Fish.lrd))
                max(max(Fish.lrd),max(Fish.lrd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            set(gca,'FontSize',TV);
            box off;
            hy(f) = ylabel('$G ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub5.yPosition)
            hl(f)= legend('Left-Right Distance $G$');
            set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub5.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub5.text.x,paras.FigResults.sub5.text.y,'(e)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            f = 5;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            % shadedErrorBar(PD,MeanEfficiencyAll, StdEfficiencyAll,{'linewidth',1.2,'Color',CouzinColor(4,:)},1);
            % set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
            %     'XTick',[1 2 3 4 5 6 7 8 9]);
            plot(t, Fish.fbd, 'Color',CouzinColor(5,:),'LineWidth',LV)
            
            Temp_Ylim  = [
                0
                max(max(Fish.fbd),max(Fish.fbd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            % set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0.05 0.15 0.25],'YTickLabel',{'0.05','0.15','0.25'});
            set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim);
            set(gca,'FontSize',TV);
            set(gca,'YTickLabel',{'0','0.5','1'},...
                'YTick',[0 0.5 1]);
            box off;
            hy(f) = ylabel('$D ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub6.yPosition)
            xlabel('t [s]','FontSize',TV);
            hl(f)= legend('Front-Back Distance $D$','Location','NorthWest');
            set(hl(f),'Interpreter','latex','position',paras.FigResults.sub6.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub6.text.x,paras.FigResults.sub6.text.y,'(f)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
        end
        
        
       function PlotFishInfoOnlyFilter(t,Leader,Follower,Fish,paras)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %input t
            %input Leader as struct; Leader.A  (amplitude); Leader.phase
            %(Phase); Leader.Am_filter; Follower.Am_filter;
            %Follower.min_Am; Follower.max_Am
            %input the descriptions between Leader and Follower, Fish.lrd,
            %Fish.fbd;Fish.pd
            
            
            switch nargin
                case 4
                    paras.FigResults.sub1.yPosition = [-0.18 0.05 -1];
                    paras.FigResults.sub1.text.x = 2.9;
                    paras.FigResults.sub1.text.y = -0.0737;
                    paras.FigResults.sub1.LegendPosition = [0.1162    0.9406    0.3162    0.0349];
                    
                    
                    paras.FigResults.sub2.yPosition = [-0.1800    0.05   -1.0000];
                    paras.FigResults.sub2.text.x = 2.9;
                    paras.FigResults.sub2.text.y = -0.0484;
                    paras.FigResults.sub2.LegendPosition = [0.1089    0.7806    0.4602    0.0349];
                    
                    paras.FigResults.sub3.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub3.text.x = 2.8877;
                    paras.FigResults.sub3.text.y = 0.9806;
                    paras.FigResults.sub3.LegendPosition = [0.7772    0.6642    0.1658    0.0349];
                    
                    paras.FigResults.sub4.yPosition = [-0.18 pi -1];
                    paras.FigResults.sub4.text.x = 2.9;
                    paras.FigResults.sub4.text.y = 2.2197;
                    paras.FigResults.sub4.LegendPosition = [ 0.1066    0.4756    0.1705    0.0344];
                    
                    paras.FigResults.sub5.yPosition = [-0.18 0.5 -1];
                    paras.FigResults.sub5.text.x = 2.9;
                    paras.FigResults.sub5.text.y = 0.3818;
                    paras.FigResults.sub5.LegendPosition = [0.1073    0.3246    0.1896    0.0347];
                    
                    paras.FigResults.sub6.yPosition = [-0.18 0.25 -1];
                    paras.FigResults.sub6.text.x = 2.9;
                    paras.FigResults.sub6.text.y = 0.1710;
                    paras.FigResults.sub6.LegendPosition = [0.1066    0.1808    0.2000    0.0347];
                    
                    paras.FigPDvsFBD.text.x = 1.4962;
                    paras.FigPDvsFBD.text.y= 0.35;
                    paras.FigPDvsFBD.LegendPosition = [0.2088    0.3726    0.4554    0.1631];
                    
                    paras.FigFFT.sub1.text.x = 40;
                    paras.FigFFT.sub1.text.y = 5;
                    paras.FigFFT.sub2.text.x = 40;
                    paras.FigFFT.sub2.text.y = 5;
                    
                otherwise
                    disp('check input')
            end
            
            
            % close all
            nf = findobj('Name','RealFishResultsCombiningFilter');
            if isempty(nf )
                nf = figure('Name','RealFishResultsCombiningFilter','Position',[3081         606         1000         550]);
            else
                figure(nf);
                clf
            end
            
            alpha = 0.65 *255;
            CouzinColor=[235 45 46 alpha;
                241 161 43 alpha;
                0 170 79 alpha;
                0 174 239 255;
                35 31 32 alpha;
                255 127 0 alpha]/255;
            TV = 26; %字体12
            LV = 3; % LineWidth
            
            % nf = 100;   %%%%设定figure的值
            % % PlotValue =figure('Name','MaxPowerCost','NumberTitle','off');
            % hf(nf) =figure(nf);
            % set(hf(nf),'Name','RealFishResults','NumberTitle','off'); %%%%设定值
            
            
            Col = 1;  %%%%设定值，几列图片
            Row =5; %%%%设定值，几行图片
            figure_num = Col*Row; %作图个数
            space_bottom=0.12;  % 底部间�? %%%%设定值
            space_top=0.04;%顶部间�?  %%%%设定值
            space_left=0.1;%左间�?  %%%%设定值
            space_right=0.05;%�?�间�?  %%%%设定值
            space_UD=0.02;%图片上下间�?  %%%%设定值
            space_LR = 0.09; % 图片左�?�间�?  %%%%设定值
            space_legend=0 ;  %图和标注之间的�?离设置  %%%%设定值
            FigHigh=(1-space_top-space_bottom-(Row-1)*space_UD)/Row; %%%%设定值
            FigWidth=(1-space_left-space_right-space_legend-space_LR*(Col-1))/Col;  %设置图片的 %%%%设定值
            
            WidthSubFig = 6 ; % �?图宽度为5 %%%%设定值
            HighSubFig = 0.3*WidthSubFig;   %%%%设定值
            
            %             set(nf,'Units', 'centimeters','Position',[27.0228   11.9239   50.9411   35.0661], 'WindowStyle','normal' )
            
            % set(hf(nf),'Units', 'centimeters','Position',[2064 67 924 916])
            
            StrLS={'^','s','d','p'};  % 设定绘制曲线的symbols
            
            
            StrLegend = {'Power Cost of Left Robotic Fish', ...
                'Power Cost of Right Robotic Fish', ...
                'Swimming Speed of Schooling fish',...
                'Swimming Speed of alone fish'};  % 设定 Legend 的字符
            
            f =1 ;
            % 绘制
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Leader.Am_filter,'Color',CouzinColor(1,:),'LineWidth',LV)
            hold on
            plot(t,Follower.Am_filter,'Color',CouzinColor(4,:),'LineWidth',LV)
%             plot(t,Follower.Am_filter,'Color',CouzinColor(6,:),'LineWidth',LV);
            plot(Follower.min_Am(:,1), Follower.min_Am(:,2), 'b.','MarkerSize',26);
            disp('All the valley of the undulation of the follower')
            Valley_Follower = Follower.min_Am(:,1);
            % hold on
            plot(Follower.max_Am(2:end,1), Follower.max_Am(2:end,2), 'm.','MarkerSize',26);
            
            
            Temp_Ylim  = [
                min(min(Leader.A),min(Follower.A))
                max(max(Leader.A),max(Follower.A))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$L_t~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub1.yPosition);
            hl(f) = legend('Leader','Follower','Valley','Peak');
            set(hl(f),'Orientation','horizontal','Position',paras.FigResults.sub1.LegendPosition,'FontName','Helvetica');
            ht(f) = text(paras.FigResults.sub1.text.x,paras.FigResults.sub1.text.y,'(a)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica');
%             text(0,0,'$L_t$','interpreter','latex','fontsize',20);
            legend boxoff
            
            
            %             f = 2;
            %             s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            %
            %                 plot(t,Follower.A,'Color',CouzinColor(4,:),'LineWidth',LV);
            %                 hold on
            %                 plot(t,Follower.Am_filter,'Color',CouzinColor(6,:),'LineWidth',LV);
            %                 % hold on
            %                 plot(Follower.min_Am(:,1), Follower.min_Am(:,2), 'g*','MarkerSize',10);
            %                 % hold on
            %                 plot(Follower.max_Am(2:end,1), Follower.max_Am(2:end,2), 'r*','MarkerSize',10);
            %
            %             Temp_Ylim  = [
            %                 min(min(Follower.A),min(Follower.A))
            %                 max(max(Follower.A),max(Follower.A))
            %                 ];
            %             Temp_Xlim = [min(t) max(t)] ;
            %             set(gca,'XTickLabel',{},'FontSize',TV,...
            %                 'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            %             box off;
            %             hy(f) = ylabel('$A~ [BL]$','FontSize',TV,'Rotation',90);
            %             set(hy(f),'Position',paras.FigResults.sub2.yPosition);
            %             hl(f) = legend('$L_t$ of the Follower','filtered $L_t$','the valley','the peak','Location','NorthWest');
            %             set(hl(f),'Interpreter','latex','Orientation','horizontal','Position',paras.FigResults.sub2.LegendPosition);
            %             legend boxoff
            %             ht(f) = text(paras.FigResults.sub2.text.x,paras.FigResults.sub2.text.y,'(b)');
            %             set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            
            f = 2;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            if strcmp( paras.PlotFlag, 'PhaseWithoutJump')
                hs = LLDataView.PhasePlotWithoutJump(t,Leader.phase);
                for ihs = 1:length(hs)
                    set(hs(ihs),'Color',CouzinColor(1,:),'LineWidth',LV) ;
                end
                hold on
                hs = LLDataView.PhasePlotWithoutJump(t,Follower.phase);
                for ihs = 1:length(hs)
                    set(hs(ihs),'Color',CouzinColor(4,:),'LineWidth',LV) ;
                end
            else
                plot(t,Leader.phase,'Color',CouzinColor(1,:),'LineWidth',LV);
                hold on
                plot(t,Follower.phase,'Color',CouzinColor(4,:),'LineWidth',LV);
            end
            
%             Temp_Ylim  = [
%                 min(min(Leader.phase),min(Follower.phase)),
%                 1.05*max(max(Leader.phase),1.05*max(Follower.phase))
%                 ];
            Temp_Ylim  = [
                0,
                1.05*max(max(Leader.phase),1.05*max(Follower.phase))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0 pi 2*pi],...
                'YTickLabel',{'0', '\pi', '2\pi'},'XColor',[1,1,1]);
            box off;
            hy(f)=ylabel('$\phi~ [rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub3.yPosition);
%             hl(f)= legend(s(f).Children([10,1]),'Leader','Follower');
%             set(hl(f),'Orientation','horizontal','Interpreter','latex','Position',[paras.FigResults.sub3.LegendPosition]);
%             legend boxoff
            ht(f) = text(paras.FigResults.sub3.text.x,paras.FigResults.sub3.text.y,'(c)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            
            f = 3;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t,Fish.pd,'color',CouzinColor(3,:),'LineWidth',LV);
            
            set(gca,'XTickLabel',{},'FontSize',TV,...
                'YLim',[0 1.05*max(Fish.pd)],'YTick',[0 1.5*pi 3*pi],...
                'YTickLabel',{'0', '1.5\pi', '3\pi'},'XLim',Temp_Xlim,'XColor',[1,1,1]);
            box off;
            hy(f) = ylabel('$\Phi~[rad]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub4.yPosition)
%             hl(f)= legend('Phase Difference $\Phi$');
%             set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub4.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub4.text.x,paras.FigResults.sub4.text.y,'(d)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            f = 4;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            
            
            plot(t, Fish.lrd, 'Color',CouzinColor(2,:),'LineWidth',LV)
            Temp_Ylim  = [
                min(min(Fish.lrd),min(Fish.lrd))
                1.1*max(max(Fish.lrd),max(Fish.lrd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            set(gca,'XTickLabel',{},'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'XColor',[1,1,1]);
            set(gca,'FontSize',TV);
            box off;
            hy(f) = ylabel('$G ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub5.yPosition)
%             hl(f)= legend('Left-Right Distance $G$');
%             set(hl(f),'Interpreter','latex','Position',paras.FigResults.sub5.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub5.text.x,paras.FigResults.sub5.text.y,'(e)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
            f = 5;
            s(f) = subplot('Position',[space_left+(FigWidth+space_LR)*(rem(f-1,Col)),space_bottom+(Row-ceil(f/Col))*(FigHigh+space_UD),FigWidth,FigHigh]);
            % shadedErrorBar(PD,MeanEfficiencyAll, StdEfficiencyAll,{'linewidth',1.2,'Color',CouzinColor(4,:)},1);
            % set(gca,'XTickLabel',{'0','1/4\pi','1/2\pi','3/4\pi','\pi','5/4\pi','3/2\pi','7/4\pi','2\pi'},...
            %     'XTick',[1 2 3 4 5 6 7 8 9]);
            plot(t, Fish.fbd, 'Color',CouzinColor(5,:),'LineWidth',LV)
            
            Temp_Ylim  = [
                0
                max(max(Fish.fbd),max(Fish.fbd))
                ];
            Temp_Xlim = [min(t) max(t)] ;
            % set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim,'YTick',[0.05 0.15 0.25],'YTickLabel',{'0.05','0.15','0.25'});
            set(gca,'FontSize',TV,'YLim',Temp_Ylim,'XLim',Temp_Xlim);
            set(gca,'FontSize',TV);
            set(gca,'YTickLabel',{'0','0.5','1'},...
                'YTick',[0 0.5 1]);
            box off;
            hy(f) = ylabel('$D ~[BL]$','FontSize',TV,'Rotation',90);
            set(hy(f),'Position',paras.FigResults.sub6.yPosition)
            xlabel('t [s]','FontSize',TV);
%             hl(f)= legend('Front-Back Distance $D$','Location','NorthWest');
%             set(hl(f),'Interpreter','latex','position',paras.FigResults.sub6.LegendPosition);
            legend boxoff
            ht(f) = text(paras.FigResults.sub6.text.x,paras.FigResults.sub6.text.y,'(f)');
            set(ht(f),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            
        end
        
        
        function SaveFigure(h,name,format)
            switch nargin
                case 2
                    %         filter_para = [3 23];
                    format = 'pdf';
                case 0
                    disp('check input')
            end
            set(h,'Units', 'centimeters', 'PaperUnits','centimeters');
            Temp_p = get(h,'position');
            set(h,'PaperPosition',[0,0,Temp_p(3:4)],'Papersize',Temp_p(3:4));
            print(h,'-PPDF Printer',[name '.' format], ['-d' format], '-r600') ;
        end
        
        function PlotPDvsFBD4Paper(pd,fbd,T_fbd,ratio,constant)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Input phase difference PD and Front-back distance D
            %Input theoratical parameters including T_pd{}, T_fbd{}, ratio and
            %constant(1~3)
            
            
            LV = 3;
            TV = 32;
            
            paras.FigPDvsFBD.text.x = [2.9,2.9];
            paras.FigPDvsFBD.text.y= [0.3236,0.347241529482857];
            paras.FigPDvsFBD.LegendPosition = [0.60709547738696 0.279335751295337 0.455399999999999 0.1631];
            is = find(fbd<=1);
            x = pd(is);
            y = fbd(is);
            
            if isempty(findobj('Name','PDvsFBD4Paper'))
                figure('Name','PDvsFBD4Paper','position',[1481         356         620         492]);
            else
                figure(findobj('Name','PDvsFBD4Paper'));
                clf
            end
            
            scatter(y,x,120,'filled','MarkerEdgeColor',[80 80 80]/255,'MarkerFaceColor',[148 150 153]/255,'linewidth',LV);
            hold on
            for i_temp = 1:length(constant)
                T_pd{1,i_temp} = ratio * T_fbd{1,i_temp} + constant{i_temp};
                plot(T_fbd{1,i_temp},T_pd{1,i_temp},'linewidth',LV,'color',[128 128 255]/255);
            end
            
%             plot(y([152,187]),x([152,187]),'o','Color',[0.6,0.4,0.8],'Markersize',10);
            
            % plot(y1,x1,'linewidth',2,'color',[128 128 255]/255);
            % set(gca,'fontsize',16,'FontName','Helvetica','XAxisLocation','top');
            set(gca,'fontsize',TV,'FontName','Helvetica');
            
            alpha(0.8);
            xlabel('Front-back distance $D$ [$BL$]');
            ylabel({'Non-dimentional', ['phase difference ' '$\Phi_{Nd}$']});
            %title('Lateral Space = 140 mm (0.3111 BL)')
            axis([ min(fbd)*0.9 max(fbd)*1.2 min(pd)*0.9 max(pd)*1.05]);
            set(gca,'XTick',[0 0.2 0.4 0.6 0.8 1.0 1.2 1.4],...
                'XTickLabel',{'0','0.2','0.4','0.6','0.8','1.0','1.2','1.4'},...
                'YTick',[0 0.2 0.4 0.6 0.8 1.0 1.2 1.4],...
                'YTickLabel',{'0','0.2','0.4','0.6','0.8','1.0','1.2','1.4'});
            [hl,icons,hpl]= legend('Experiment','Theory');
            legend boxoff
            set(hl,'Fontsize',TV,'FontName','Helvetica','Position',paras.FigPDvsFBD.LegendPosition);
            set(icons(3).Children,'MarkerSize',10,'LineWidth',LV);
            %             set(gca,'YDir','reverse');
            
            %             for i_temp = 1: length(constant)
            %                 ht(i_temp) = text(paras.FigPDvsFBD.text.x(i_temp),paras.FigPDvsFBD.text.y(i_temp), ['$\Phi^*=$' num2str(ratio) 'D+' num2str(constant(i_temp))  '$\pi$']);
            %                 set(ht(i_temp),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            %             end
        end
        
        
        function PlotPDvsFBD(pd,fbd,T_fbd,ratio,constant)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Input phase difference PD and Front-back distance D
            %Input theoratical parameters including T_pd{}, T_fbd{}, ratio and
            %constant(1~3)
            LV = 3;
            TV = 32;
            
            paras.FigPDvsFBD.text.x = [2.9,2.9];
            paras.FigPDvsFBD.text.y= [0.3236,0.347241529482857];
            paras.FigPDvsFBD.LegendPosition = [0.590709547738696 0.279335751295337 0.455399999999999 0.1631];
            x = pd;
            y = fbd;
            
            if isempty(findobj('Name','PDvsFBD'))
                figure('Name','PDvsFBD4Paper');
            else
                figure(findobj('Name','PDvsFBD4Paper'));
                clf
            end
            
            scatter(x,y,120,'filled','MarkerEdgeColor',[80 80 80]/255,'MarkerFaceColor',[148 150 153]/255,'linewidth',LV);
            hold on
            for i_temp = 1:length(constant)
                T_pd{1,i_temp} = ratio * T_fbd{1,i_temp} + constant{i_temp};
                plot(T_pd{1,i_temp},T_fbd{1,i_temp},'linewidth',LV,'color',[128 128 255]/255);
            end
            
            % plot(y1,x1,'linewidth',2,'color',[128 128 255]/255);
            % set(gca,'fontsize',16,'FontName','Helvetica','XAxisLocation','top');
            set(gca,'fontsize',TV,'FontName','Helvetica');
            
            alpha(0.8);
            ylabel('Front-back distance $D$ [$BL$]');
            xlabel('Phase Difference $\Phi$');
            %title('Lateral Space = 140 mm (0.3111 BL)')
            axis([min(pd)*0.9 max(pd)*1.05 min(fbd)*0.9 max(fbd)*1.05]);
            set(gca,'XTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5]*pi,...
                'XTickLabel',{'0','0.5\pi','\pi','1.5\pi','2\pi','2.5\pi','3\pi','3.5\pi','4\pi','4.5\pi','5\pi','5.5\pi'});
            [hl,icons,hpl]= legend('Real Fish Data','Theoretical prediction');
            legend boxoff
            set(hl,'Fontsize',TV,'FontName','Helvetica','Position',paras.FigPDvsFBD.LegendPosition);
            set(icons(3).Children,'MarkerSize',10,'LineWidth',LV);
            set(gca,'YDir','reverse');
            
            %             for i_temp = 1: length(constant)
            %                 ht(i_temp) = text(paras.FigPDvsFBD.text.x(i_temp),paras.FigPDvsFBD.text.y(i_temp), ['$\Phi^*=$' num2str(ratio) 'D+' num2str(constant(i_temp))  '$\pi$']);
            %                 set(ht(i_temp),'FontSize',TV,'FontName','Helvetica','FontWeight','bold');
            %             end
        end
        
        
        function SaveVideos(para)
            %%%%%%% parameters %%%%%%
            CouzinColor=[235 45 46;
                241 161 43;
                0 170 79;
                0 174 239;
                35 31 32;
                255 127 0;
                240,128,128]/255;
            
            % Read videos
            bo.name = para.bo.name;
            side.name = para.side.name;
            bo.hv = VideoReader(bo.name);
            side.hv = VideoReader(side.name);
            
            % set start frame and end frame
            i_start = para.i_start;
            i_end = para.i_end;
            
            % Because some videos donot math the tracking data, there is a gap
            % between them, here we set it as "i_gap"
            
            i_gap = para.i_gap;
            
            
            % parameter deterning how many frames to show in the first plot,
            % because there is a shift between the first one and the middle frames
            i_plot_gap = para.i_plot_gap;
            
            % Parameres for figure plots
            %     plots.ymin.Amplitude = -0.3;
            %     plots.ymax.Amplitude = 0.3;
            plots.ymin.Phase        =       para.plots.ymin.Phase;
            plots.ymax.Phase        =       para.plots.ymax.Phase;
            position.bo             =       para.position.bo;
            position.side           =       para.position.side;
            position.Amplitude      =       para.position.Amplitude;
            position.Phase          =       para.position.Phase;
            position.LR             =       para.position.LR;
            position.FB             =       para.position.FB;
            position.PDvsFB         =       para.position.PDvsFB;
            plots.FigurePosition    =       para.plots.FigurePosition;
            % set positions for texts
            plots.text.positions    =       para.plots.text.positions;
            plots.text.colors       =       para.plots.text.colors;
            plots.ylabels           =       para.plots.ylabels;
            plots.xlabels           =       para.plots.xlabels;
            FlowSpeedStr            =       para.FlowSpeedStr;
            % parameters for out put
            SaveVideo               =       para.SaveVideo;
            AddTheory               =       para.AddTheory;
            OutputVideoName         =       para.OutputVideoName;
            % Video source from PKU or MPIO, because videos from MPIO needs to flip
            VideoSource             =       para.VideoSource;
            % crop points determined based on two points, first point (top left),
            % second points (bottom right)
            bo.CropPoints           =       para.bo.CropPoints;
            side.CropPoints         =       para.side.CropPoints;
            bo.image   = [];
            side.image = [];
            t                       =       para.t;
            Fish_bo.centroid.x      =       para.Fish_bo.centroid.x;
            Fish_bo.centroid.y      =       para.Fish_bo.centroid.y;
            Fish_bo.tail.x          =       para.Fish_bo.tail.x;
            Fish_bo.tail.y          =       para.Fish_bo.tail.y;
            Fish_up.centroid.x      =       para.Fish_up.centroid.x ;
            Fish_up.centroid.y      =       para.Fish_up.centroid.y  ;
            Fish_up.tail.x          =       para.Fish_up.tail.x ;
            Fish_up.tail.y          =       para.Fish_up.tail.y ;
            
            if  ~isempty(bo.CropPoints)
                Fish_bo.centroid.x = Fish_bo.centroid.x     - bo.CropPoints(1);
                Fish_bo.centroid.y = Fish_bo.centroid.y     - bo.CropPoints(2);
                Fish_bo.tail.x     = Fish_bo.tail.x         - bo.CropPoints(1);
                Fish_bo.tail.y     = Fish_bo.tail.y         - bo.CropPoints(2);
                Fish_up.centroid.x = Fish_up.centroid.x     - bo.CropPoints(1);
                Fish_up.centroid.y = Fish_up.centroid.y     - bo.CropPoints(2);
                Fish_up.tail.x     = Fish_up.tail.x         - bo.CropPoints(1);
                Fish_up.tail.y     = Fish_up.tail.y         - bo.CropPoints(2);
            end
            
            Fish_bo.Amplitude       =       para.Fish_bo.Amplitude ;
            Fish_up.Amplitude       =       para.Fish_up.Amplitude ;
            Fish_bo.phase           =       para.Fish_bo.phase ;
            Fish_up.phase           =       para.Fish_up.phase ;
            Diff.LR                 =       para.Diff.LR;
            Diff.FB                 =       para.Diff.FB;
            Diff.PD                 =       para.Diff.PD;
            Diff.T_FB               =       para.Diff.T_FB;
            Diff.T_PD               =       para.Diff.T_PD;
            
            if ~isprop(para,'PDvsFBD_PosLegend')
               PDvsFBD_PosLegend = para.PDvsFBD_PosLegend;
            else
                PDvsFBD_PosLegend = [0.860681995133821 0.169741666666668 0.1624 0.0437499999999999];
            end
            % Set Body Length;
%             BL = para.BL;
            %%%%%%% End parameters %%%%%%
            if isempty(findobj('Name','Video'))
                hf = figure('Name','Video');
                set(hf,'Position',plots.FigurePosition,'Visible','on');
            else
                figure(findobj('Name','Video'))
            end
            
            if SaveVideo
                vwrite = VideoWriter(OutputVideoName,'MPEG-4');
                vwrite.FrameRate = 25;
                open(vwrite);
            end
            VideoStarted = false;
            bo.hv.CurrentTime = (i_gap+i_start-1)/bo.hv.FrameRate;
            if isfield(para,'i_side_bo_gap')
                side.hv.CurrentTime = (i_gap+i_start-1+para.i_side_bo_gap)/side.hv.FrameRate;
            else
                side.hv.CurrentTime = (i_gap+i_start-1)/side.hv.FrameRate;
            end
            if  length(i_end-i_start)< bo.hv.Duration * bo.hv.FrameRate
                i_start = 1;
                i_end = length(Diff.LR);
                PartialData = true;
            end
            for i_video = i_start: i_end%length(x)
                if ~VideoStarted  % the first frame to plot, and the continues frames will be draw by setting data
                    VideoStarted = true;
                    clf
                    %%%%%%% show images  %%%%%%%
                    if hasFrame(bo.hv)
                        bo.image = readFrame(bo.hv);
                        if isfield(bo,'CropPoints')
                            bo.image = bo.image(bo.CropPoints(2):bo.CropPoints(4),bo.CropPoints(1):bo.CropPoints(3),:);
                        end
                    end
                    
                    if hasFrame(side.hv)
                        side.image = readFrame(side.hv);
                        if VideoSource == 'MPIO'
                            for i = 1:3
                                side.image(:,:,i) = fliplr(side.image(:,:,i));
                            end
                        end
                        if isfield(side,'CropPoints')
                            side.image = side.image(side.CropPoints(2):side.CropPoints(4),side.CropPoints(1):side.CropPoints(3),:);
                        end
                    end
                    
                    bo.hs = subplot('Position',position.bo);
                    bo.hi = imshow(bo.image,'Border','tight');
                    ht = text(plots.text.positions(1,1),plots.text.positions(1,2),'Bottom View','FontSize',30,'Color',plots.text.colors(1,:));
                    hold on
                    [bo.imheight,bo.imwide]=size(bo.image);
                    bo.plot = plot(Fish_bo.centroid.x(i_video),Fish_bo.centroid.y(i_video),'.g',Fish_bo.tail.x(i_video),Fish_bo.tail.y(i_video),'.r',...
                        Fish_up.centroid.x(i_video),Fish_up.centroid.y(i_video),'.y',Fish_up.tail.x(i_video),Fish_up.tail.y(i_video),'.b',...
                        'MarkerSize',40);
                    side.hs = subplot('Position',position.side);
                    side.hi = imshow(side.image,'Border','tight');
                    ht = text(plots.text.positions(2,1),plots.text.positions(2,2),'Lateral View','FontSize',30,'Color',plots.text.colors(2,:));
                    text(plots.text.positions(3,1),plots.text.positions(3,2),'1/4 actual speed','FontSize',30,'Color',plots.text.colors(3,:));
                    text(plots.text.positions(4,1),plots.text.positions(4,2),FlowSpeedStr,'FontSize',30,'Color',plots.text.colors(4,:));
                    
                    i_sub_start = i_video;
                    i_sub_end = i_video+2*i_plot_gap;
                    
                    %%%% Amplitude %%%%%%
                    plots.hA = subplot('Position',position.Amplitude);
                    plots.ymin.Amplitude = min(min(Fish_up.Amplitude(i_sub_start:i_sub_end)),min(Fish_bo.Amplitude(i_sub_start:i_sub_end)));
                    plots.ymax.Amplitude = max(max(Fish_up.Amplitude(i_sub_start:i_sub_end)),max(Fish_bo.Amplitude(i_sub_start:i_sub_end)));
                    plots.Amplitude = plot(t(i_sub_start:i_sub_end),Fish_up.Amplitude(i_sub_start:i_sub_end),'b',...
                        t(i_sub_start:i_sub_end),Fish_bo.Amplitude(i_sub_start:i_sub_end),'r',...
                        [t(i_video) t(i_video)],[plots.ymin.Amplitude,plots.ymax.Amplitude],'k');
                    set(plots.hA,'YLim',[plots.ymin.Amplitude,plots.ymax.Amplitude],'XTick',[],'XColor',[1,1,1]);
                    hl(1)=legend(plots.hA,' fish1','fish2  Lateral distance of the tail tip');                    
                    set(hl(1),'Orientation','horizontal','position',[0.72009 0.9683 0.2412 0.0262],'fontname','Helvetica');
                    ylabel(plots.ylabels{1},'Interpreter','latex')
                    legend boxoff
                    box off
                    
                    %%%% Phase %%%%%%
                    plots.hP = subplot('Position',position.Phase);
                    plots.Phase = plot(t(i_sub_start:i_sub_end),Fish_up.phase(i_sub_start:i_sub_end),'bo',...
                        t(i_sub_start:i_sub_end),Fish_bo.phase(i_sub_start:i_sub_end),'ro',...
                        [t(i_video) t(i_video)],[plots.ymin.Phase,plots.ymax.Phase],'k');
                    set(plots.hP,'YLim',[plots.ymin.Phase,plots.ymax.Phase],'YTick',[0 pi 2*pi],...
                        'YTickLabel',{'0','\pi','2\pi'},'XTick',[],'XColor',[1,1,1])
                    
                    hl(2) = legend(plots.hP,'fish1','fish2');
                    set(hl(2),'Orientation','horizontal','position',[0.7008 0.8125 0.1745 0.0262],'fontname','Helvetica');
                    ylabel(plots.ylabels{2})
                    legend boxoff
                    box off
                    
                    
                    %%%% Left right distance  %%%%%%
                    plots.ymin.LR = min(Diff.LR(i_sub_start:i_sub_end));
                    plots.ymax.LR = max(Diff.LR(i_sub_start:i_sub_end));
                    plots.hLR = subplot('Position',position.LR);
                    plots.LR = plot(t(i_sub_start:i_sub_end),Diff.LR(i_sub_start:i_sub_end),'m',...
                        [t(i_video) t(i_video)],[plots.ymin.LR,plots.ymax.LR],'k');
                    set(plots.LR(1),'color',CouzinColor(4,:));
                    set(plots.hLR,'YLim',[plots.ymin.LR plots.ymax.LR],'XTick',[],'XColor',[1,1,1]);
                    hl(3) = legend(plots.LR,'Left-right distance');
                    set(hl(3),'position',[0.6965 0.6350 0.1745 0.0262])
                    ylabel(plots.ylabels{3})
                    legend boxoff
                    box off
                    
                    
                    %%%% Front Back distance  %%%%%%
                    plots.ymin.FB = min(Diff.FB(i_sub_start:i_sub_end));
                    plots.ymax.FB = max(Diff.FB(i_sub_start:i_sub_end));
                    plots.hFB = subplot('Position',position.FB);
                    plots.FB = plot(t(i_sub_start:i_sub_end),Diff.FB(i_sub_start:i_sub_end),'m',...
                        [t(i_video) t(i_video)],[plots.ymin.FB,plots.ymax.FB],'k');
                    set(plots.FB(1),'color',CouzinColor(6,:))
                    set(plots.hFB,'YLim',[plots.ymin.FB plots.ymax.FB]);
                    hl(4) = legend(plots.FB,'Front-back distance');
                    set(hl(4),'position',[0.6965 0.4717 0.1521 0.0233]);
                    ylabel(plots.ylabels{4})
                    xlabel(plots.xlabels{1})
                    legend boxoff
                    box off
                    
                    
                    %%%% Front Back distance vs Phase Difference  %%%%%%
                    plots.hPDvsFB = subplot('Position',position.PDvsFB);
                    if PartialData
                        plots.PDvsFB(1) = plot(Diff.FB(1:i_video),Diff.PD(1:i_video),'o','MarkerSize',8,'Color',[0.4,0.4,0.4]);
                        
                        axis([min(Diff.FB(1: i_end-i_start+1)) max(Diff.FB(1: i_end-i_start+1)) 0 2*pi]);
                    else
                        plots.PDvsFB(1) = plot(Diff.FB(i_start:i_video),Diff.PD(i_start:i_video),'o','MarkerSize',8);
                        axis([min(Diff.FB(i_start: i_end)) max(Diff.FB(i_start: i_end)) 0 2*pi]);
                    end
                    set(plots.hPDvsFB,'YTick',[0 0.5*pi pi 1.5*pi 2*pi],'YTickLabel',{'0','0.5\pi','\pi','1.5\pi','2\pi'})
                    box off
                    if AddTheory
%                         for ij = 1:size(Diff.T_FB,2)
%                             T_fbd = Diff.T_FB{ij};
%                             T_pd  = Diff.T_PD{ij};
%                             hold on;
%                             plots.PDvsFB(2) = plot(T_fbd,T_pd,'Color',[0.1,0.1,0.1]);
%                         end
                        
                        hold on
                        T_fbd = Diff.T_FB{1};
                        T_pd  = Diff.T_PD{1};
                        plots.PDvsFB(2) = plot(T_fbd(1:i_video),T_pd(1:i_video),'s','MarkerSize',8,'Color',[0.1,0.1,0.1]);
%                         plots.PDvsFB(2) = plot(T_fbd,T_pd,'Color',[0.1,0.1,0.1]);

                    end
                    
                    hl(5) = legend(plots.hPDvsFB.Children([2,1]),'Experiment','Theory');
                        %                         set(hl(5),'position',[0.8273 0.1708 0.1624 0.0233]);
%                     set(hl(5),'position',[0.820681995133821 0.169741666666668 0.1624 0.0437499999999999]);
                    set(hl(5),'position',PDvsFBD_PosLegend);
                    legend boxoff
                    ylabel(plots.ylabels{5})
                    xlabel(plots.xlabels{2})
                    
                else
                    if hasFrame(bo.hv)
                        bo.image = readFrame(bo.hv);
                        if isfield(bo,'CropPoints')
                            bo.image = bo.image(bo.CropPoints(2):bo.CropPoints(4),bo.CropPoints(1):bo.CropPoints(3),:);
                        end
                    end
                    
                    if hasFrame(side.hv)
                        side.image = readFrame(side.hv);
                        for i = 1:3
                            side.image(:,:,i) = fliplr(side.image(:,:,i));
                        end
                        if isfield(side,'CropPoints')
                            side.image = side.image(side.CropPoints(2):side.CropPoints(4),side.CropPoints(1):side.CropPoints(3),:);
                        end
                    end
                    
                    set(bo.hi,'CData',bo.image)
                    set(side.hi,'CData',side.image)
                    set(bo.plot(1),'XData',Fish_bo.centroid.x(i_video),'YData',Fish_bo.centroid.y(i_video))
                    set(bo.plot(2),'XData',Fish_bo.tail.x(i_video),'YData',Fish_bo.tail.y(i_video))
                    set(bo.plot(3),'XData',Fish_up.centroid.x(i_video),'YData',Fish_up.centroid.y(i_video))
                    set(bo.plot(4),'XData',Fish_up.tail.x(i_video),'YData',Fish_up.tail.y(i_video))
                    
                    if PartialData
                        set(plots.PDvsFB(2),'XData',Diff.FB(1:i_video),'YData',Diff.T_PD{1}(1:i_video));
                        set(plots.PDvsFB(1),'XData',Diff.FB(1:i_video),'YData',Diff.PD(1:i_video));
                    else
                        set(plots.PDvsFB(1),'XData',Diff.FB(i_start:i_video),'YData',Diff.PD(i_start:i_video));
                    end
                    
                    if i_video <=i_plot_gap  %  head
                        set(plots.Amplitude(3),'XData',[t(i_video),t(i_video)]);
                        set(plots.Phase(3),'XData',[t(i_video),t(i_video)]);
                        set(plots.LR(2),'XData',[t(i_video),t(i_video)]);
                        set(plots.FB(2),'XData',[t(i_video),t(i_video)]);
                        
                    elseif i_video <= i_end-i_plot_gap % body
                        i_sub_start = i_video-i_plot_gap;
                        i_sub_end = i_video+i_plot_gap;
                        
                        
                        %%%% Amplitude %%%%%%
                        set(plots.Amplitude(1),'XData',t(i_sub_start:i_sub_end),'YData',Fish_up.Amplitude(i_sub_start:i_sub_end));
                        set(plots.Amplitude(2),'XData',t(i_sub_start:i_sub_end),'YData',Fish_bo.Amplitude(i_sub_start:i_sub_end));
                        plots.ymin.Amplitude = min(min(Fish_up.Amplitude(i_sub_start:i_sub_end)),min(Fish_bo.Amplitude(i_sub_start:i_sub_end)));
                        plots.ymax.Amplitude = max(max(Fish_up.Amplitude(i_sub_start:i_sub_end)),max(Fish_bo.Amplitude(i_sub_start:i_sub_end)));
                        set(plots.Amplitude(3),'XData',[t(i_video),t(i_video)],'YData',[plots.ymin.Amplitude,plots.ymax.Amplitude]);
                        set(plots.hA,'YLim',[plots.ymin.Amplitude,plots.ymax.Amplitude],'XLim',[t(i_sub_start),t(i_sub_end)])
                        
                        
                        
                        %%%% Phase %%%%%%
                        set(plots.Phase(1),'XData',t(i_sub_start:i_sub_end),'YData',Fish_up.phase(i_sub_start:i_sub_end));
                        set(plots.Phase(2),'XData',t(i_sub_start:i_sub_end),'YData',Fish_bo.phase(i_sub_start:i_sub_end));
                        set(plots.Phase(3),'XData',[t(i_video),t(i_video)]);
                        set(plots.hP,'XLim',[t(i_sub_start),t(i_sub_end)])
                        
                        
                        %%%% Left right distance  %%%%%%
                        set(plots.LR(1),'XData',t(i_sub_start:i_sub_end),'YData',Diff.LR(i_sub_start:i_sub_end));
                        plots.ymin.LR = min(Diff.LR(i_sub_start:i_sub_end));
                        plots.ymax.LR = max(Diff.LR(i_sub_start:i_sub_end));
                        set(plots.LR(2),'XData',[t(i_video),t(i_video)],'YData',[plots.ymin.LR,plots.ymax.LR]);
                        set(plots.hLR,'YLim',[plots.ymin.LR plots.ymax.LR],'XLim',[t(i_sub_start),t(i_sub_end)]);
                        
                        
                        %%%% Front Back distance  %%%%%%
                        set(plots.FB(1),'XData',t(i_sub_start:i_sub_end),'YData',Diff.FB(i_sub_start:i_sub_end));
                        plots.ymin.FB = min(Diff.FB(i_sub_start:i_sub_end));
                        plots.ymax.FB = max(Diff.FB(i_sub_start:i_sub_end));
                        set(plots.FB(2),'XData',[t(i_video),t(i_video)],'YData',[plots.ymin.FB,plots.ymax.FB]);
                        set(plots.hFB,'YLim',[plots.ymin.FB plots.ymax.FB],'XLim',[t(i_sub_start),t(i_sub_end)]);
                        
                        
                    else   % tail
                        
                        set(plots.Amplitude(3),'XData',[t(i_video),t(i_video)]);
                        set(plots.Phase(3),'XData',[t(i_video),t(i_video)]);
                        set(plots.LR(2),'XData',[t(i_video),t(i_video)]);
                        set(plots.FB(2),'XData',[t(i_video),t(i_video)]);
                    end
                    drawnow
                end
                
                if SaveVideo
                    temp_frame = getframe(findobj('Name','Video'));
                    ImName = ['Testtt',num2str(i_video)];
                    %                     LLDataView.SaveFigure(findobj('Name','Video'),ImName,'png')
                    writeVideo(vwrite,temp_frame);
                end
                
            end
            
            if SaveVideo
                close(vwrite);
            end
        end
        
        
        
        function CheckVideos(para)
            iStart = para.iStart;
            iEnd = para.iEnd;
            clx = para.clx;
            cly = para.cly;
            
            %     v = VideoReader('test_auto_volt068_20170721_140332.21797353.mp4');
            %     v = VideoReader('/Volumes/ODYSSEY/GoldenFish/Selected/goldenfish_speed2_bls_20171014_155241.21797353/goldenfish_speed2_bls_20171014_155241.21797353.mp4');
            v = VideoReader(para.VideoFile);
            tStart = (iStart-1)/v.FrameRate;
            tEnd = (iEnd-1)/v.FrameRate;
            if para.SaveVideo
                vwrite = VideoWriter(['Valid_Movie_GodenFish_' num2str(iStart) '-' num2str(iEnd) 's'],'MPEG-4');
                vwrite.FrameRate = 25;
                open(vwrite);
            end
            
            v.CurrentTime = tStart;
            k = iStart;
            while hasFrame(v) && v.CurrentTime <= tEnd
                clf
                image = readFrame(v);
                imshow(image,'Border','tight')
                text(1700,200,'Speed x 0.25','fontsize',30)
                hold on
                plot(clx(:,k,1),cly(:,k,1),'b',clx(:,k,2),cly(:,k,2),'r');
                pause(0.2);
                if para.SaveVideo
                    frame = getframe(gcf);
                    writeVideo(vwrite,frame);
                end
                k = k + 1;
            end
            if para.SaveVideo
                close(vwrite);
            end
        end
        
        function ImageCheckFishTracker(PathImage,PathTrackingData)
            close all
            CouzinColor=[235 45 46;
                241 161 43;
                0 170 79;
                0 174 239;
                35 31 32;
                255 127 0;
                240,128,128]/255;
            im      = imread(PathImage);
            data    = load(PathTrackingData) ;
            imshow(im,'Border','tight');
            hold on
            for ii = 1:3
                for ifish = 1:2
                    plot(data.X{ifish,1}(:,ii),size(im,1)-data.Y{ifish,1}(:,ii),'m','color',CouzinColor(end,:))
                end
            end
            % Tail tip point
            plot(data.X{1,1}(1,2),size(im,1)-data.Y{1,1}(1,2),'.','color',CouzinColor(4,:),'MarkerSize',40)
            % Central point
            plot(data.X{1,1}(20,2),size(im,1)-data.Y{1,1}(20,2),'.','color',CouzinColor(4,:),'MarkerSize',40)
            % Tail tip point
            plot(data.X{2,1}(1,2),size(im,1)-data.Y{2,1}(1,2),'.','color',CouzinColor(1,:),'MarkerSize',40)
            % Central point
            plot(data.X{2,1}(20,2),size(im,1)-data.Y{2,1}(20,2),'.','color',CouzinColor(1,:),'MarkerSize',40)
            
        end
        
        function hs = PhasePlotWithoutJump(pt,phase)
            ip = find(abs(diff(phase))>1.8*pi);    
            iss = [1, ip+1];
            ies = [ip,length(phase)];     

            for ip = 1:length(iss)
               hs(ip) = plot(pt(iss(ip):ies(ip)),phase(iss(ip):ies(ip)));
                hold on
            end
            
        end
        
    end
end