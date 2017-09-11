%2017.06.17 by masaaki
%根据Annotations 的xml 截图 JPEGImages 的jpg     ->    根据标签存放至不同文件目录

%%
clc,clear
close all
path_image='../data/VOC2007/JPEGImages/MACOSX/';%jpg文件存放路径
path_label='../data/VOC2007/Annotations/MACOSX';%txt文件存放路径
path_xml='../data/VOC2007/Annotations/';%xml文件存放路径
sreenshot=strcat(path_image,'../screenshot'); %sreenshot文件存放路径
mkdir(sreenshot);
files_all=dir([path_xml,'*.xml']);
for j=1:length(files_all)
    
    filename=files_all(j).name;
    % read xml
    xmlDoc = xmlread([path_xml filename ]);
    % read image
    image = imread([path_image filename(1:end-4) '.jpg']);
    figure,imshow(image)
    hold on
    % name node
    object_array = xmlDoc.getElementsByTagName('object');
    name_array = xmlDoc.getElementsByTagName('name');
    xmin_array = xmlDoc.getElementsByTagName('xmin');
    ymin_array = xmlDoc.getElementsByTagName('ymin');
    xmax_array = xmlDoc.getElementsByTagName('xmax');
    ymax_array = xmlDoc.getElementsByTagName('ymax');
    object_num=object_array.getLength;
    name_num=name_array.getLength;
    xmin_num=xmin_array.getLength;
    ymin_num=ymin_array.getLength;
    xmax_num=xmax_array.getLength;
    ymax_num=ymax_array.getLength;
    for i=0:object_num-1   
        name = char(name_array.item(i+1).getTextContent());
        xmin = str2num(char(xmin_array.item(i).getTextContent()));
        ymin = str2num(char(ymin_array.item(i).getTextContent()));
        xmax = str2num(char(xmax_array.item(i).getTextContent()));
        ymax = str2num(char(ymax_array.item(i).getTextContent()));
        if exist(strcat(sreenshot,'/',name,'/'),'file')==0
            mkdir(strcat(sreenshot,'/',name,'/'))
        end
        rectangle('position',[xmin,ymin,xmax-xmin,ymax-ymin],'EdgeColor','r')
        filestring=strcat(sreenshot,'/',name,'/',filename(1:end-4),'_',name,'_',num2str(i),'.jpg');
        imwrite(image(ymin:ymax,xmin:xmax),filestring)
    end
    hold off
    pause(0.1)
    close all
end