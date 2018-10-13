function [scores, maxlabel] = classification_demo(im, use_gpu)

if exist('../+head', 'dir') %dir-path assigned
  addpath('..');
else
  error('Please stop');
end


if exist('use_gpu', 'var') && use_gpu
  caffe.set_mode_gpu();
  gpu_id = 2; 
  caffe.set_device(gpu_id);
else
  caffe.set_mode_cpu();
end


model_dir = '../../head_count/';
net_model = [model_dir 'deploy.prototxt'];
net_weights = [model_dir 'bvlc_reference_caffenet.caffemodel'];
phase = 'test'; 

if ~exist(net_weights, 'file')
  error('Please download CaffeNet from Model Zoo before you run this demo');
end

% Initialize a network
net = caffe.Net(net_model, net_weights, phase);

if nargin < 1

  fprintf('using caffe/examples/images/cat.jpg as input image\n');
  im = imread('../../images/head_count.jpg');
end


input_data = {prepare_image(im)};
toc;



scores = net.forward(input_data);
toc;

scores = scores{1};
scores = mean(scores, 2);  % take average scores over 10 heads

[~, maxlabel] = max(scores);


caffe.reset_all();

tains mean_data that

d = load('../+headcount/ilsvrc_2012_mean.mat');
mean_data = d.mean_data;
IMAGE_DIM = 256;
CROPPED_DIM = 227;


im_data = im(:, :, [3, 2, 1]); 
im_data = permute(im_data, [2, 1, 3]);  
im_data = single(im_data);  
im_data = imresize(im_data, [IMAGE_DIM IMAGE_DIM], 'bilinear');  
im_data = im_data - mean_data;  % subtract mean_data (already in W x H x C, BGR)


crops_data = zeros(CROPPED_DIM, CROPPED_DIM, 3, 10, 'single');
indices = [0 IMAGE_DIM-CROPPED_DIM] + 1;
n = 1;
for i = indices
  for j = indices
    crops_data(:, :, :, n) = im_data(i:i+CROPPED_DIM-1, j:j+CROPPED_DIM-1, :);
    crops_data(:, :, :, n+5) = crops_data(end:-1:1, :, :, n);
    n = n + 1;
  end
end
center = floor(indices(2) / 2) + 1;
crops_data(:,:,:,5) = ...
  im_data(center:center+CROPPED_DIM-1,center:center+CROPPED_DIM-1,:);
crops_data(:,:,:,10) = crops_data(end:-1:1, :, :, 5);
