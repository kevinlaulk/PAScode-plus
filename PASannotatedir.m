%%
%ÈÝ´í³Ø 013955434_K2219725_331_1_05.jpg
%%
% function PASannotatedir
  classfilename='PASclasses.txt';
  PASdir='../data/';
  DATdir='VOCself/';
  DATstr='The Caltech database';
%   IMGdir='MACOSX1/';
  IMGdir='';
  ORGlabel='JointsRear';
  PNGdir=[PASdir,DATdir,'JPEGImages/',IMGdir];
  % PNGdir=[PASdir,DATdir,'JPEGImages/'];
  ANNdir=[PASdir,DATdir,'Annotations/',IMGdir];
  % ANNdir=[PASdir,DATdir,'Annotations/'];
  mkdir(ANNdir);
  d=dir([PNGdir,'/*.jpg']);
  for i=1:length(d),
    img=imread([PNGdir,d(i).name]);
    fprintf('-- Now annotating %s --\n',d(i).name);
    record=PASannotateimg(img,classfilename);
    record.imgname=[DATdir,'JPEGImages/',IMGdir,d(i).name];
    %record.imgname=[DATdir,'JPEGImages/',d(i).name];
    record.database=DATstr;
    
    for j=1:length(record.objects),
      record.objects(j).orglabel=ORGlabel;
    end;
    
    [path,name,ext]=fileparts(d(i).name);
    annfile=[ANNdir,name,'.txt'];
    comments={}; % Extra comments = array of cells (one per line)
    PASwriterecord(annfile,record,comments);
%    if (~PAScmprecords(record,PASreadrecord(annfile)))
%       PASerrmsg('Records do not match','');
%    end;
  end
% return