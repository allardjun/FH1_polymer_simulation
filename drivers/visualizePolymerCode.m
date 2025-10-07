nonDimerFname = ../src/PolymerCode/outputNonDimer.txt;
dimerFname = ../src/PolymerCode/outputDimer.txt;

[nonDimerPrvec,nonDimerPocc]=getPolymerStats(nonDimerFname);
[dimerPrvec,dimerPocc]=getPolymerStats(dimerFname);

fullfig = figure('units','centimeters','position',[5,5,45,30]);hold on;
tiles = tiledlayout(2,1,'TileSpacing','tight','Padding','none');

nexttile
scatter(dimerPrvec(1,:)./nonDimerPrvec(1,:))
hold on
scatter(dimerPrvec(2,:)./nonDimerPrvec(2,:))
title("Change in local effective concentration (dimerized/nondimerized)")
xlabel('Distance from binding site to FH2')
ylabel('Local effective concentration ratio')

nexttile
scatter(dimerPocc(1,:)./nonDimerPocc(1,:))
hold on
scatter(dimerPocc(2,:)./nonDimerPocc(2,:))
title("Change in occlusion probability (dimerized/nondimerized)")
xlabel('Distance from binding site to FH2')
ylabel('Occlusion probability ratio')


function [prvec,pocc]= getPolymerStats(fname)
    outputStruct=getOutputControl(fname);

    typeName=fieldnames(outputStruct);

    nName=fieldnames(outputStruct.typeName);

    prvec=outputStruct.typeName.nName.Prvec0;
    pocc=outputStruct.typeName.nName.POcclude;

end