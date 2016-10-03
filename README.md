This repo is a quick and dirty matconvnet speed comparison of the standard vgg-vd-16 
model and its atrous counterpart (originally described in the 
[Parsenet paper](https://arxiv.org/abs/1506.04579)). The *atrous* model 
was imported into matconvnet from its 
[caffe version](https://gist.github.com/weiliu89/2ed6e13bfd5b57cf81d6).

###Results 

GPU tests performed with a single Tesla M40
(should be considered rough approximations)

| Model              | CPU   | GPU    |
|--------------------|-------|--------|
| standard vgg-vd-16 | 1.5Hz | 44.5Hz |
| atrous vgg-vd-16   | 1.7Hz | 48.2Hz |


###NOTES
The original model was designed for 1000-way image classification, whereas
the Atrous model is designed to be used as the trunk in an object detection
framework (for instance, performing 21-way classification on Pascal VOC data).

The primary difference between the models is that the fully connected `fc6` 
layer in the original is exchanged for a dilated convolution layer.  The 
following layers are also fully convolutional, which dramatically reduces 
the number of parameters in the network (as can be seen in the table below)

###Memory Requirements

| Model              | Memory (params) | Memory (vars) |
|--------------------|-----------------|---------------|
| Standard vgg-vd-16 | 528MB           | 1.097GB       |
| Atrous vgg-vd-16   | 82MB            | 1.109GB       |

The second column lists the memory required to hold the variables used by the 
network to process a batch of ten *RGB* images each of dimension `224 x 224 x 3` 
stored in `single` precision.
