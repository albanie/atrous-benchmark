% useful stuff
run ~/coding/src/zvision/matlab/zv_setup ;

% ---------------------------
% Standard vgg-vd-16
% ---------------------------
modelPath = fullfile(vl_rootnn, 'data', 'models', 'imagenet-vgg-verydeep-16.mat') ;
vggNet = dagnn.DagNN.fromSimpleNN(load(modelPath), 'CanonicalNames', true) ;
vggNet.mode = 'test' ;

fprintf('-----------------------\n') ;
fprintf(' standard vgg-vd-16    \n') ;
fprintf('-----------------------\n') ;
% print out the total memory cost of the params
table = vggNet.print() ;
str = table(strfind(table, 'total'):end) ;
fprintf('\nParam memory: %s', str) ;

table = vggNet.print({'input', [224 224 3 10]}) ;
str = table(strfind(table, 'total'):end) ;
fprintf('Total var + param memory when processing a batch of size (224x24x3x10): %s', str) ;

% ---------------------------
% Atrous vgg-vd-16
% ---------------------------
modelPath = fullfile(vl_rootnn, 'data', 'models-import', 'vgg-vd-16-reduced.mat') ;
atrousNet = dagnn.DagNN.fromSimpleNN(load(modelPath), 'CanonicalNames', true) ;
atrousNet.mode = 'test' ;

fprintf('-----------------------\n') ;
fprintf(' atrous vgg-vd-16    \n') ;
fprintf('-----------------------\n') ;

% print out the total memory cost of the params
table = atrousNet.print() ;
str = table(strfind(table, 'total'):end) ;
fprintf('\nParam memory: %s', str) ;

% print out the total memory cost of the params
table = atrousNet.print({'input', [224 224 3 10]}) ;
str = table(strfind(table, 'total'):end) ;
fprintf('Total var + param memory when processing a batch of size (224x24x3x10): %s', str) ;
