function benchmarkModel(net, batch, benchCPU, benchGPU, gpu)

if benchGPU
    assert(nargin > 4, 'Gpu device must be selected to run gpu benchmark') ;
end

inputs = {net.getInputs, batch} ;
batchSize = size(batch, 4) ;

bench_str = 'CPU benchmark average (current) speed %d: %.1f (%.1f) Hz' ;
numCPUBatches = 10 ; 

if benchCPU
    for t = 1:numCPUBatches
        net.eval(inputs) ;

        % timing
        time = toc(start) ;
        batchTime = time - stats.time ;
        stats.time = time ;
        currentSpeed = batchSize / batchTime ;
        averageSpeed = (t * batchSize) / time ;

        % print speed benchmark stats
        disp(sprintf(bench_str, t, averageSpeed, currentSpeed)) ;
    end
end

numWarmupBatches = 20 ;
if benchGPU
    gpu = 1 ;
    g = gpuDevice(gpu) ;

    bench_str = 'GPU benchmark average (current) speed %d: %.1f (%.1f) Hz' ;
    inputs{2} = gpuArray(inputs{2}) ;
    net.move('gpu') ;
    numGPUBatches = 100 ; 
    start = tic ;
    stats.time = 0 ;

    for t = 1:numGPUBatches
        net.eval(inputs) ;

        % only start timer on the 10th pass

        if t == numWarmupBatches
            start = tic ;
            stats.time = 0 ;
        end

        if t > numWarmupBatches
            % timing
            time = toc(start) ;
            batchTime = time - stats.time ;
            stats.time = time ;
            currentSpeed = batchSize / batchTime ;
            averageSpeed = ((t - numWarmupBatches)* batchSize) / time ;

            % print speed benchmark stats
            disp(sprintf(bench_str, t, averageSpeed, currentSpeed)) ;
        end
    end
    net.move('cpu') ;
    reset(g) ;
end
