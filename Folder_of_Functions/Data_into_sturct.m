function sturct_of_images = ....
    Data_into_sturct(...
    raw_name, seg_name, distal_name)
% I - the names of the raw, seg and distal images
% O - a sturct of the images to compute the tapering measurmet
%This stage we will load the images from the database - I'm assumes all
%paths are added

%% Getting the data
raw_header_file = niftiinfo(raw_name);
raw_image = niftiread(raw_header_file);

%Getting the segmented image
orginal_complete_segmentation = niftiread(seg_name);

%Creating distal points
DistalPoints(seg_name,distal_name,0)

%% Need to perform the distance tramsfrom
%I'm using matlabs inmplmentation as it was not posiable to use the Nifty
%software in matlab on the cluster
[start_image,~] = bwdist(~logical(orginal_complete_segmentation),'euclidean');
%Most of the software requires things to be double otherwise things could
%break
start_image = double(start_image);

%% Updating the sturct
sturct_of_images.raw_image = raw_image;
sturct_of_images.raw_header = raw_header_file;
sturct_of_images.seg_image = double(logical(orginal_complete_segmentation));
sturct_of_images.start_image = start_image;
sturct_of_images.distal_image = distal_image;

name_compoennts = Name_component_with_file_extension(raw_name);

%UPdating the image patient
sturct_of_images.patient = [name_compoennts{2} '_' name_compoennts{3}];

%UPdating the parameters that we are testing
sturct_of_images.file_name = raw_name;

end

