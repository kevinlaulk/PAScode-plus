#!/usr/bin/python
# -*- coding: UTF-8 -*-
'''
Created on 2017-8-26
@author: kevin

'''
import os
from readxml import readxml
from readxml import cropimg


class fileread(object):
    def __init__(self):
        self.datapath = '../data/'
        self.scriptpath = ''
        self.Annotations = '../data/Annotations/'
        self.JPEGImages = '../data/JPEGImages/'
        print(self.Annotations)

    def Annoread(self):
        # 检查Annotations是否存在
        if not os.path.exists(self.Annotations):
            print('the Annotations is not exis')
        else:
            self.Annolist = os.listdir(self.Annotations)
            print('the amount is :%s' % len(self.Annolist))
            print(self.Annolist)

    def JPEGread(self, *cdir):
        if not cdir:
            # 检查Annotations是否存在
            if not os.path.exists(self.JPEGImages):
                print('the JPEGimages is not exis')
            else:
                JPEGlist = os.listdir(self.JPEGImages)
                print('the amount is :%s' % len(JPEGlist))
                print(JPEGlist)
                self.JPEGlistdir = []
                self.JPEGlistname = []
            for x in JPEGlist:
                if os.path.splitext(x)[1] == '':
                    print('there are childdir: %s' % x)
                    childdir = os.path.join(self.JPEGImages, x)
                    # self.JPEGread(childdir)  # 递归无法实现
                    JPEGlist_child = os.listdir(childdir)
                    for childitem in JPEGlist_child:
                        self.JPEGlistname.append(
                            os.path.splitext(childitem)[0])  # 不含扩展名列表
                        self.JPEGlistdir.append(
                            os.path.join(childdir, childitem))  # 相对路径列表
                    print('the amount is :%s' % len(JPEGlist_child))
                    print(JPEGlist_child)
                else:
                    self.JPEGlistname.append(os.path.splitext(x)[0])  # 不含扩展名列表
                    self.JPEGlistdir.append(
                        os.path.join(self.JPEGImages, x))  # 相对路径列表
        print(len(self.JPEGlistname))
        print(len(self.JPEGlistdir))
        for item in self.JPEGlistname:
            print(item)
            print(self.JPEGlistdir[self.JPEGlistname.index(item)])

    def Anno_JPEG(self):
        for itemxml in self.Annolist:
            item = os.path.splitext(itemxml)[0]  # 得到文件名不包含.xml
            if item in self.JPEGlistname:
                p = self.JPEGlistname.index(item)  # 图片路径名索引
                print('Have found : %s' % self.JPEGlistdir[p])  # 图片路径名
                Annoindex = readxml(os.path.join(
                    self.Annotations, itemxml))  # 数据提取
                print('Annote the data...')
                print(Annoindex)
                cropimg(self.JPEGlistdir[p], item, Annoindex[0], Annoindex[1],
                        Annoindex[2], Annoindex[3], Annoindex[4])
            else:
                print('the Annotations: %s is not in JPEGImages' % item)


if __name__ == '__main__':
    file = fileread()
    file.Annoread()
    file.JPEGread()
    file.Anno_JPEG()
