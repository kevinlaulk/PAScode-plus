clc,clear
close all
PASdir='../data/';
DATdir='VOC2007/';
DATstr='The Caltech database';
IMGdir='MACOSX/';
ORGlabel='JointsRear';
PNGdir=[PASdir,DATdir,'JPEGImages/',IMGdir];
% PNGdir=[PASdir,DATdir,'JPEGImages/'];
ANNdir=[PASdir,DATdir,'Annotations/',IMGdir];
% ANNdir=[PASdir,DATdir,'Annotations/'];
d=dir([PNGdir,'/*.jpg']);
for i=1:length(d)
    filename=strcat(PNGdir,d(i).name);
    img=imread(filename);
    img=imresize(img,[448,448]);
    imwrite(img,filename)
end
    