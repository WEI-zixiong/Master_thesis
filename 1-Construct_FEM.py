from abaqus import *
from abaqusConstants import *
import random
width = 100
length = 100
myModel = mdb.models["Model-1"] #create model
mySketch = mdb.models['Model-1'].ConstrainedSketch(name='sketch_1', sheetSize=200.0) #create sketch
mySketch.rectangle(point1=(0,0), point2=(length, width))
myPart = myModel.Part(name='Part-1', dimensionality=TWO_D_PLANAR, type=DEFORMABLE_BODY)
myPart.BaseShell(sketch=mySketch)
del myModel.sketches['sketch_1']
mySketch = myModel.ConstrainedSketch(name='sketch_2', sheetSize=200)
def interCheck(point,center,radius1,radius2):
    sign = True
    for p in center:
        if sqrt((point[0] - p[0]) ** 2 + (point[1] - p[1]) ** 2) <= (radius1+radius2):
            sign = False
            break
    return sign
count = 0
radius = 2
center = [[random.uniform(2, 98), random.uniform(2, 98)]]
while True:
    x = random.uniform(2, 98)
    y = random.uniform(2, 98)
    sign = interCheck([x,y],center,2,2)
    if sign:
        center.append([x,y])
    count += 1
    if count >= 110:
        break
for p in center:
    x,y = p[0], p[1]
    mySketch.CircleByCenterPerimeter(center=(x, y), point1=(x+radius, y))
myPart.PartitionFaceBySketch(faces=myPart.faces[0:1], sketch=mySketch)
del myModel.sketches['sketch_2']
