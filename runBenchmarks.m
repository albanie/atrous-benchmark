% load models and print out stats
startup ;

% generate a sample batch for benchmarking
im = im2single(imread('peppers.png')) ;
batch = repmat(im, 1, 1, 1, 10) ;
batchSize = size(batch, 4) ;

% set gpu device
gpuId = 1 ;

% run both CPU and GPU tests
benchCPU = false ;
benchGPU = true ;

fprintf('----------------------------------\n') ;
fprintf('Benchmarks for standard vgg-vd-16:\n') ;
fprintf('----------------------------------\n') ;
benchmarkModel(vggNet, batch, benchCPU, benchGPU, gpuId) ;

fprintf('----------------------------------\n') ;
fprintf('Benchmarks for atrous vgg-vd-16:\n') ;
fprintf('----------------------------------\n') ;
benchmarkModel(atrousNet, batch, benchCPU, benchGPU, gpuId) ;
