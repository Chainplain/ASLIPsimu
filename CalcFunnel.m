clear all;
RppL = cell(6, 1);
RvvL = cell(6, 1);
TppL = cell(6, 1);
TvvL = cell(6, 1);

TppL4CurveFit = zeros(1200,1);
RppL4CurveFit = zeros(1200,1);
Tv_Rv_4CurveFit = zeros(1200,1);

Count = 0;

for i =1:6
load (strcat("Height-0.", num2str(i+3),".mat"));
Equal_1 = out.D(:,2) ==1;
Equal_0 = out.D(:,2) ==0;

Equal_0_star = [0;Equal_0];
Equal_0_star1 = Equal_0_star(1:end-1);

End = find(Equal_1 + Equal_0_star1 > 1);
Start = find(Equal_1 + Equal_0_star1 < 1);

Startreal = Start(3:2:end-1);
Endreal = End(4:2:end);

SizeofEndreal = size(Endreal,1);

Rpp = cell(SizeofEndreal, 1);
Rvv = cell(SizeofEndreal, 1);
Tpp = cell(SizeofEndreal, 1);
Tvv = cell(SizeofEndreal, 1);

% figure;

for j = 1: SizeofEndreal
    Rpp{j}= out.RP(Startreal(j)+200:Endreal(j)-300,2);
    Rvv{j}= out.RV(Startreal(j)+200:Endreal(j)-300,2);
    Tpp{j}= out.TP(Startreal(j)+200:Endreal(j)-300,2);
    Tvv{j}= out.TV(Startreal(j)+200:Endreal(j)-300,2);
    %plot(Rpp{j});
    SizeofRpps = size(Tvv{j},1);
    
    Randnum = randi(SizeofRpps, 20,1);
%     plot(Rpp{j}(Randnum),Tpp{j}(Randnum),'.');
    
    Calc = ((Count + j)*20-19:(Count + j)*20);
    
    TppL4CurveFit(Calc) = Tpp{j}(Randnum);
    RppL4CurveFit(Calc) = Rpp{j}(Randnum);
    Tv_Rv_4CurveFit(Calc) = Tvv{j}(Randnum)./Rvv{j}(Randnum);
    
    
%     hold on;
end

Count = Count + SizeofEndreal;

RppL{i} = Rpp;
RvvL{i} = Rvv;
TppL{i} = Tpp;
TvvL{i} = Tvv;


end
Great = find(RppL4CurveFit > pi*2/5);
Less  = find(RppL4CurveFit <= pi*2/5);

% plot(RppL4CurveFit(Great),TppL4CurveFit(Great),'.k','LineWidth',2);
ForeRppL4CurveFit = RppL4CurveFit(Less);
ForeTppL4CurveFit = TppL4CurveFit(Less);
ForeTv_Rv_4CurveFit = Tv_Rv_4CurveFit(Less);

HindRppL4CurveFit = RppL4CurveFit(Great);
HindTppL4CurveFit = TppL4CurveFit(Great);
HindTv_Rv_4CurveFit = Tv_Rv_4CurveFit(Great);

ForeFit_a = fit(ForeRppL4CurveFit,ForeTppL4CurveFit,'poly3');
ForeFit_b = fit(ForeRppL4CurveFit,ForeTv_Rv_4CurveFit,'poly3');

HindFit_a = fit(HindRppL4CurveFit,HindTppL4CurveFit,'poly3');
HindFit_b = fit(HindRppL4CurveFit,HindTv_Rv_4CurveFit,'poly3');

figure; 
% ForeGenerate_a = val
plot(ForeFit_a,'r', ForeRppL4CurveFit,ForeTppL4CurveFit,'k.');
hold on;
plot(HindFit_a,'r', HindRppL4CurveFit,HindTppL4CurveFit,'k.');
xlabel('Stance angle (rad)');ylabel('Position (m)');

figure;
% ForeGenerate_a = val
plot(ForeFit_b,'r', ForeRppL4CurveFit,ForeTv_Rv_4CurveFit,'k.');
hold on;
plot(HindFit_b,'r', HindRppL4CurveFit,HindTv_Rv_4CurveFit,'k.');
xlabel('Stance angle (rad)');ylabel('Relative Velocity (m/rad)');