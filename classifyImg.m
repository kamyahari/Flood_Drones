function I = classifyImg(myNet)

addpath('C:\Users\Kamya\Documents\Research\Pragyan\extra');

picture1 = imread('test1.jpg'); %Reading the  first picture
picture1 = imresize(picture1,[227,227]); %Resizing the image
label1 = classify(myNet, picture1);  % Classifying the image into flooded 
% and non flooded regions
picture2 = imread('test2.jpg'); %Reading the  first picture
picture2 = imresize(picture2,[227,227]); %Resizing the image
label2 = classify(myNet, picture2);
figure
subplot(1,2,1)
imshow(picture1); % displaying the image
title(label1)
subplot(1,2,2)
imshow(picture2); % displaying the image
title(label2)
end
