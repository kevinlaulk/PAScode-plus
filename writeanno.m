%writeanno.m
%path_image='threechannels/JPEGImages/';
%path_label='threechannels/labels/';%txt文件存放路径
path_image='../data/VOCself/JPEGImages/';%jpg文件存放路径
path_label='../data/VOCself/Annotations/';%txt文件存放路径
path_xml='../data/VOCself/Annotations/';%xml文件存放路径
files_all=dir(path_image);

for i = 4:length(files_all)
    try 
        msg = textread(strcat(path_label, '/',files_all(i).name(1:end-4),'.txt'),'%s');
    catch
        continue
    end
    clear rec;
    path = [path_xml files_all(i).name(1:end-4) '.xml'];
    fid=fopen(path,'w');
    rec.folder = 'VOC2007';%数据集名

    rec.filename = [files_all(i).name(1:end-4),'.jpg'];%图片名

    rec.source.database = 'The VOC2007 Database';%随便写
    rec.source.annotation = 'PASCAL VOC2007';%随便写
    rec.source.image = 'flickr';%随便写
    rec.source.flickrid = '0';%随便写

    rec.owner.flickrid = 'Masaaaki';%随便写
    rec.owner.name = 'Masaaki';%随便写

  %  img = imread(['./JPEGImages/' files_all(i).name]);
    img = imread([path_image, files_all(i).name]);
    rec.size.width = int2str(size(img,2));
    rec.size.height = int2str(size(img,1));
    rec.size.depth = int2str(size(img,3));
    
    rec.segmented = '0';%不用于分割
    %writexml(fid,rec,0);
%     for j = 1:num_obj
%         rec.annotation.object.name = msg{num};%类别名
%         rec.annotation.object.pose = 'Unspecified';%不指定姿态
%         rec.annotation.object.truncated = '0';%没有被删节
%         rec.annotation.object.difficult = '0';%不是难以识别的目标
%         rec.annotation.object.bndbox.xmin = msg{num+1};%坐标x1
%         rec.annotation.object.bndbox.ymin = msg{num+2};%坐标y1
%         rec.annotation.object.bndbox.xmax = msg{num+3};%坐标x2
%         rec.annotation.object.bndbox.ymax = msg{num+4};%坐标y2
%         num = num + 5;
%         writexml(fid,rec,0);
%     end
    fprintf(fid,'<%s>\n','annotation');
    writexml(fid,rec,1);
        
    num = 2;
    num_obj = str2num(msg{1});
    for j = 1:num_obj
        rec1.object.name = msg{num};%类别名
        rec1.object.pose = 'Unspecified';%不指定姿态
        rec1.object.truncated = '0';%没有被删节
        rec1.object.difficult = '0';%不是难以识别的目标
        rec1.object.bndbox.xmin = msg{num+1};%坐标x1
        rec1.object.bndbox.ymin = msg{num+2};%坐标y1
        rec1.object.bndbox.xmax = msg{num+3};%坐标x2
        rec1.object.bndbox.ymax = msg{num+4};%坐标y2
        num = num + 5;
        writexml(fid,rec1,1);
    end
    %rec.annotation.object = rec1.annotation.object;
    %writexml(fid,rec,0);
    fprintf(fid,'</%s>\n','annotation');
    fclose(fid);
end