clc;  
allImages = imageDatastore('dataset', 'IncludeSubfolders', true,...
    'LabelSource', 'foldernames');
%% Split data into training and test sets 
[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');
 
%% Load Pre-trained Network (AlexNet)
% AlexNet is a pre-trained network trained on 1000 object categories.
alex = alexnet; 
%% Review Network Architecture 
layers = alex.Layers 
%% Modify Pre-trained Network 
% AlexNet was trained to recognize 1000 classes, we need to modify it to
% recognize just 2 classes. 
layers(23) = fullyConnectedLayer(2); 
layers(25) = classificationLayer
%% Perform Transfer Learning
% For transfer learning we want to change the weights of the network ever so slightly. How
% much a network is changed during training is controlled by the learning
% rates. 
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001,...
    'MaxEpochs', 20, 'MiniBatchSize', 64);
%% Set custom read function 
trainingImages.ReadFcn = @readFunctionTrain;
%% Train the Network 
myNet = trainNetwork(trainingImages, layers, opts);
%% Test Network Performance
testImages.ReadFcn = @readFunctionTrain;
predictedLabels = classify(myNet, testImages); 
accuracy = mean(predictedLabels == testImages.Labels)