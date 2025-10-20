nonDimerFname = "../runs/outputNonDimer.txt";

[nonDimerPrvec,nonDimerPocc]=getPolymerStats(nonDimerFname);

fullfig = figure('units','centimeters','position',[5,5,45,30]);hold on;
tiles = tiledlayout(1,2,'TileSpacing','tight','Padding','none');

nexttile
xvals=1:length(nonDimerPrvec(1,:));
scatter(xvals,log10((nonDimerPrvec(1,:)).*6.1503*10^7),'filled','MarkerFaceColor','blue')
hold on
prtheory=log10(( ( 3./(2*pi.*xvals.*(1^2)) ).^(3/2)) .*6.1503*10^7 );
plot(xvals,prtheory,'LineWidth',2)
scatter(xvals,log10((nonDimerPrvec(2,:)).*6.1503*10^7),'filled','MarkerFaceColor','blue')
title("Local effective concentration")
xlabel('Distance from binding site to FH2')
ylabel('log_{10} Local effective concentration (uM^{-1})')
legend(["simulation","theory"])

nexttile
scatter(1:length(nonDimerPrvec(1,:)),nonDimerPrvec(1,:),'filled','MarkerFaceColor','blue')
hold on
scatter(1:length(nonDimerPrvec(1,:)),nonDimerPrvec(2,:),'filled','MarkerFaceColor','blue')
title("Occlusion probability")
xlabel('Distance from binding site to FH2')
ylabel('Occlusion probability')

saveas(fullfig,"../runs/polymerCodeVisualQuick.png");

function [prvec,pocc]= getPolymerStats(fname)
    outputStruct=getOutputControl(fname);

    prvec=outputStruct.Prvec0;
    pocc=outputStruct.POcclude;

end
