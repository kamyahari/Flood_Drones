function I = classifyVideo(myNet)

videoReader = vision.VideoFileReader('C:\Users\Kamya\Documents\Research\Pragyan Drone\flood drone.mp4');
videoPlayer = vision.DeployableVideoPlayer;
position1 = [35 185];
position2 = [185 35];

while ~isDone(videoReader)
    frame = step(videoReader);
    im = im2uint8(imresize(frame, [227 227], 'bilinear'));
    [label,score] = classify(myNet,im);
    RGB = insertText(frame,position1,char(label),'FontSize',18,'TextColor','white','BoxColor','black');
    RGB = insertText(RGB,position2,sprintf('%.2f',round(max(score),2)),'FontSize',18,'TextColor','white','BoxColor','green');
    step(videoPlayer,RGB);
end 
release(videoReader);
release(videoPlayer);



