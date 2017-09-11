#!/usr/bin/python
# -*- coding: UTF-8 -*-
'''
Created on 2017-8-26
@author: kevin

'''
'''
This script is used to crop the img which has been annoted before
the file structure is like below:
   --|data
      ---|Annotatioins
          ---|ABC.xml
      ---|JPEGImages
          ---|ABC.jpg
          OR
          ---|xxfile
              ---|ABC.jpg
   --|script
      ---|fileindex
      ---|README
      ---|readxml
the progrom need the modul as follow:
pip install lxml
pip install Pillow

Open cmd and go to `script <#script>`__ directory

.. code::

    python fileindex.py
OR
    py -3 fileindex.py

'''