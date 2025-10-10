nonDimerFname = "../src/PolymerCode/outputNonDimer.txt";
dimerFname = "../src/PolymerCode/outputDimer.txt";

[nonDimerPrvec,nonDimerPocc]=getPolymerStats(nonDimerFname);
[dimerPrvec,dimerPocc]=getPolymerStats(dimerFname);

fullfig = figure('units','centimeters','position',[5,5,45,30]);hold on;
tiles = tiledlayout(1,2,'TileSpacing','tight','Padding','none');

nexttile
scatter(1:length(dimerPrvec(1,:)),(dimerPrvec(1,:)./nonDimerPrvec(1,:)))
hold on
scatter(1:length(dimerPrvec(1,:)),(dimerPrvec(2,:)./nonDimerPrvec(2,:)))
title("Change in local effective concentration (dimerized/nondimerized)")
xlabel('Distance from binding site to FH2')
ylabel('Local effective concentration ratio')

nexttile
scatter(1:length(dimerPrvec(1,:)),dimerPocc(1,:)./nonDimerPocc(1,:))
hold on
scatter(1:length(dimerPrvec(1,:)),dimerPocc(2,:)./nonDimerPocc(2,:))
title("Change in occlusion probability (dimerized/nondimerized)")
xlabel('Distance from binding site to FH2')
ylabel('Occlusion probability ratio')

saveas(fullfig,"../src/PolymerCode/polymerCodeVisual.png");

function [prvec,pocc]= getPolymerStats(fname)
    outputStruct=getOutputControl(fname);

    prvec=outputStruct.Prvec0;
    pocc=outputStruct.POcclude;

end