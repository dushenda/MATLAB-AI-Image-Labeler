negativefactor=9.5;
load('cxk\data RGB\copy.mat','gTruth');
gTruth.LabelDefinitions
cxklabel = selectLabels(gTruth,'cxk2');
trainingData = objectDetectorTrainingData(cxklabel);
summary(trainingData)
acfDetector3 = trainACFObjectDetector(trainingData,'NegativeSamplesFactor',negativefactor);