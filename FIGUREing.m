
figure;

KK = size(out.RP(:,1));
Show = floor(KK(1)/4):floor(KK(1)*4/7);%Only show part of the data

subplot(3,1,1);
hold on;
[AX,Ha,Hb]=plotyy(out.RP(Show,1),out.RP(Show,2),out.RV(Show,1),out.RV(Show,2),'plot');
axis(AX(1),[-inf inf -inf inf]);
axis(AX(2),[-inf inf -inf inf]);
%axis([min(out.RV(Show,1)) max(out.RV(Show,1)) min(out.RP(Show,2)) max(out.RP(Show,2))]);
set(Ha,'linewidth',1,'color',[72/255,61/255,139/255]);
set(Hb,'linewidth',1,'color',[1,69/255,0]);
set(AX(1),'XColor','k','YColor',[72/255,61/255,139/255],'YTick',...
    Roundd(min(out.RP(Show,2)),1):0.2:Roundd(max(out.RP(Show,2)),1)); 
set(AX(2),'XColor','k','YColor',[1,69/255,0],'YTick',...
    Roundd(min(out.RV(Show,2)),1):5:Roundd(max(out.RV(Show,2)),2)); 
HH1=get(AX(1),'Ylabel');
set(HH1,'String','Rotation Angle (rad)','color',[72/255,61/255,139/255]); 
HH2=get(AX(2),'Ylabel');
set(HH2,'String',{'Rotation Angular';'Velocity (rad/s)'},'color',[1,69/255,0]);%
% set(gca,'color',[0.9,0.9,0.9]);
%plot(out.RP(:,1),out.RP(:,2));
%plot(out.RV(:,1),out.RV(:,2));

hold off;

subplot(3,1,2);
hold on;


plot(out.TP(Show,1),out.TP(Show,2),'linewidth',1);
plot(out.Pd(Show,1),out.Pd(Show,2),'linewidth',1);
% xlabel('Time(s)');
ylabel({'Prismatic Position (m)'});
legend('Real','Desire');
axis([-inf inf min([out.TP(Show,2);out.Pd(Show,2)]) max([out.TP(Show,2);out.Pd(Show,2)])]);
hold off;

subplot(3,1,3);
hold on;
%[AX,Ha,Hb]=plotyy(out.TV(Show,1),out.TV(Show,2),out.Vd(Show,1),out.Vd(Show,2),'plot');
plot(out.V_R(Show,1),out.V_R(Show,2),'linewidth',1);
plot(out.Vd(Show,1),out.Vd(Show,2),'linewidth',1);
axis([-inf inf -1 1]);%
set(gca,'XColor','k');
xlabel('Time(s)');
ylabel({'Prismatic Positional';'Velocity (m/s)'});
legend('Real','Desire');
% set(Ha,'linewidth',1);
% set(Hb,'linewidth',1);
% set(AX(1),'XColor','k');
% set(AX(2),'XColor','k'); 
% HH1=get(AX(1),'Ylabel');
% set(HH1,'String',{'Prismatic Positional';'Velocity (m/s)'}); 
% HH2=get(AX(2),'Ylabel');
% set(HH2,'String',{'Prismatic Positional';'Desired Velocity (m/s)'});%
hold off;
% 
figure;
ax = plot(out.TorsoX(:,2),out.TorsoZ(:,2)+0.7,'linewidth',1);
axis([0 18 0 0.8]);
set(gcf,'position',[500 500 600 200]);
xlabel('Torso CoM x Postion (m)');
ylabel('Torso CoM z Postion (m)');

function K=Roundd(Input, Wei)
         K = round(Input.* 10^Wei)./10^Wei;
end