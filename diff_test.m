% Create video input object.
if(exist('vid')) %#ok<EXIST>
    try
        stop(vid);
    catch err
        
    end
    try
        flushdata(vid);
    catch err
    
    end
    try
        delete(vid);
    catch err
    
    end
    
    clear vid;
end

vid = videoinput('linuxvideo');

% Set video input object properties for this application.
% Note that example uses both SET method and dot notation method.
set(vid,'TriggerRepeat',Inf);
vid.FrameGrabInterval = 1;
% Set value of a video source object property.
vid_src = getselectedsource(vid);
set(vid_src,'Tag','motion detection setup');
% Create a figure window.
figure(1337);
% Start acquiring frames.

start(vid);

segments=64;

% Calculate difference image and display it.
old_data = getdata(vid,1);
while(vid.FramesAcquired<=10000) % Stop after 100 frames
    try
        data = (getdata(vid,1));
        data = ycbcr2rgb(data);
        
%        seg_im = segments*round((data)/segments);
%        diff_im= old_data -data;
       
	grey = sum(data,3)/3;
 
 
%        fourier = fft2(sum(data,3));
%        fourier2= fft2(sum(seg_im,3));
        
	%subplot(1,2,1);
	showgrey(sqrt(imfilter(grey,fspecial('prewitt')).^2+imfilter(grey,fspecial('prewitt')).^2));

	%data_r = data(:,:,1);
	%data_g = data(:,:,2);
	%data_b = data(:,:,3);
	
	%print 'tries to plot'
	%subplot(1,2,2);scatter3(reshape(data_r,prod(size(data_r)),1),reshape(data_g,prod(size(data_g)),1),reshape(data_b,prod(size(data_b)),1),1);
	%print 'done'	

	%sobel_filter = [-1 0 1;-2 0 2;-1 0 1];
        %subplot(2,2,2);imshow(conv2(grey,sobel_filter+sobel_filter','same'));
       
	%subplot(2,2,3);
	%scatter3(data(:,1,1),data(:,1,2),data(:,1,3));

	%subplot(2,2,4);
	%imshow(diff_im);
        
        %subplot(2,2,3);showfs(real(fourier));
        %subplot(2,2,4);showfs(real(fourier2));
        
        
    catch err
	err.message
	error('got problems');
    end
    old_data = data;
end
stop(vid)
