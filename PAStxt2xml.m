%% 得到所有文件列表  
classfilename='PASclasses.txt';
  PASdir='../data/';
  DATdir='VOC2007/';
  DATstr='The Caltech database';
  IMGdir='MACOSX/';
  ORGlabel='JointsRear';
  PNGdir=[PASdir,DATdir,'JPEGImages/',IMGdir];
  % PNGdir=[PASdir,DATdir,'JPEGImages/'];
  ANNdir=[PASdir,DATdir,'Annotations/',IMGdir];
addpath('annotations');  %添加你存放标记文件的路径  
annotList = dir([ANNdir,'/*.txt']);  %得到该路径下的所有txt文件  
annotListLen = length(annotList); % txt文件的数目  
  
for i = 1:annotListLen  
    % 由 PASCAL Annotaions Ver. 1.00 工具读取数据  
    fn = strcat(ANNdir, annotList(i).name); %需要读取的文件名  
    record = PASreadrecord(fn); %读取数据  
      
    % 提取你所需的数据  
    imgname = record.imgname;  
    idx = regexp(imgname,'/');      
    imgsize = record.imgsize;  
    db = 'INRIA';   
    obj = record.objects;  
    object_num = length(obj);  
      
    % 建立一个xml文件，存储数据、  
    %这是你要存储的xml文件路径，比如我这个代码是存在当前工作目录下的‘Gen/Test/pos/文件名.xml’  
    path_data =  strcat(ANNdir, annotList(i).name(1:end-4));  
    path_data = strcat(path_data, '.xml');   
      
    %下面建立节点，我用缩进代表层级  
    %建立根节点，可以看作是第一级  
    annotation = com.mathworks.xml.XMLUtils.createDocument('annotation');  
    annotationRoot = annotation.getDocumentElement;  
      
        %建立子节点，可以看作是第二级  
        folder = annotation.createElement('folder');  
        folder.appendChild(annotation.createTextNode(db));  
        annotationRoot.appendChild(folder);  
  
        filename = annotation.createElement('filename');  
        filename.appendChild(annotation.createTextNode(imgname(idx(2)+1:end)));  
        annotationRoot.appendChild(filename);  
  
        source = annotation.createElement('source');  
        annotationRoot.appendChild(source);  
            %建立该点的子节点，建立时用根节点建立，但是要依附到父节点而不是根节点，这里可以看作第三级  
            database = annotation.createElement('database');%用根节点建立  
            database.appendChild(annotation.createTextNode(db));  
            source.appendChild(database);%依附到父节点  
            annotaion_src = annotation.createElement('annotation');  
            annotaion_src.appendChild(annotation.createTextNode('PASCAL Annotaion Version 1.00'));  
            source.appendChild(annotaion_src);%  
            image = annotation.createElement('image');  
            image.appendChild(annotation.createTextNode('null'));  
            source.appendChild(image);%  
            flickrid_src = annotation.createElement('flickrid');  
            flickrid_src.appendChild(annotation.createTextNode('null'));  
            source.appendChild(flickrid_src);%  
  
        owner = annotation.createElement('owner');  
        annotationRoot.appendChild(owner);  
            flickrid_own = annotation.createElement('flickrid');  
            flickrid_own.appendChild(annotation.createTextNode('null'));  
            owner.appendChild(flickrid_own);%  
            name = annotation.createElement('name');  
            name.appendChild(annotation.createTextNode('null'));  
            owner.appendChild(name);%  
  
        size = annotation.createElement('size');  
        annotationRoot.appendChild(size);  
            width = annotation.createElement('width');  
            width.appendChild(annotation.createTextNode(num2str(imgsize(1))));  
            size.appendChild(width);%  
            height = annotation.createElement('height');  
            height.appendChild(annotation.createTextNode(num2str(imgsize(2))));  
            size.appendChild(height);%  
            depth = annotation.createElement('depth');  
            depth.appendChild(annotation.createTextNode(num2str(imgsize(3))));  
            size.appendChild(depth);%  
  
        segmented = annotation.createElement('segmented');  
        segmented.appendChild(annotation.createTextNode('0'));  
        annotationRoot.appendChild(segmented);  
  
        for j = 1:object_num %%一张图中可能有多个目标，需要循环建立多个object标注  
            object = annotation.createElement('object');  
            annotationRoot.appendChild(object);  
                name_obj = annotation.createElement('name');  
                name_obj.appendChild(annotation.createTextNode('person'));  
                object.appendChild(name_obj);%  
                pose = annotation.createElement('pose');  
                pose.appendChild(annotation.createTextNode(obj(j).orglabel));  
                object.appendChild(pose);%  
                truncated = annotation.createElement('truncated');  
                truncated.appendChild(annotation.createTextNode('0'));  
                object.appendChild(truncated);%  
                difficult = annotation.createElement('difficult');  
                difficult.appendChild(annotation.createTextNode('0'));  
                object.appendChild(difficult);%  
                bndbox = annotation.createElement('bndbox');  
                object.appendChild(bndbox);%  
                    xmin = annotation.createElement('xmin');  
                    xmin.appendChild(annotation.createTextNode(num2str(obj(j).bbox(1))));  
                    bndbox.appendChild(xmin);%  
                    ymin = annotation.createElement('ymin');  
                    ymin.appendChild(annotation.createTextNode(num2str(obj(j).bbox(2))));  
                    bndbox.appendChild(ymin);%  
                    xmax = annotation.createElement('xmax');  
                    xmax.appendChild(annotation.createTextNode(num2str(obj(j).bbox(3))));  
                    bndbox.appendChild(xmax);%  
                    ymax = annotation.createElement('ymax');  
                    ymax.appendChild(annotation.createTextNode(num2str(obj(j).bbox(4))));  
                    bndbox.appendChild(ymax);%  
        end  
    xmlwrite(path_data,annotation); %% 写入xml文件  
end  