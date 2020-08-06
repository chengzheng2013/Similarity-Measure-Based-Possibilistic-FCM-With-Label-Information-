clc 
close all 
clear variables

filepath = './20Normals_T1_brain/';
is_image = 1;
is_IBSR = 1;
cluster_n = 4;

if is_image == 1
    if is_IBSR == 1
        n = 10;
        seg_file = './20Normals_T1_seg/';
        [seg_raw, img_raw] = IBSRread(seg_file, filepath, n);
        img = img_raw(51:end-50, 41:end-51, 20);
        seg = seg_raw(51:end-50, 41:end-51, 20); 
        figure;imshow(img,[])
        figure;imshow(seg,[])
        [m, n] = size(img);
        img_vec = reshape(im2double(img), [], 1);
        options = [NaN, NaN, NaN, NaN, NaN, NaN, 10, NaN, m, n];
        [U, T, obj_fcn] = sim_pfcm_l(img_vec, cluster_n, options);
        [~, i] = max(U, [], 1);
        figure
        imshow(reshape(i, m, n), [])
        title('Proposed method output')
    else
        img = imread(filepath);
        img = imresize(img, 0.5);
        [m, n] = size(img);
        img_vec = reshape(im2double(img), [], 1);
        options = [NaN, NaN, NaN, NaN, NaN, NaN, 5, NaN, m, n];
        [U, T, obj_fcn] = sim_pfcm_l(img_vec, cluster_n, options);
        [~, i] = max(U, [], 1);
        figure
        imshow(reshape(i, m, n), [])
        title('Proposed method output')
    end
else
    mat = txt2mat(filepath);
    options = [NaN, NaN, NaN, NaN, NaN, NaN, 50, NaN, 0, 0];
    [U, T, obj_fcn] = sim_pfcm_l(mat(:, 1:2), cluster_n, options);
    [~, i] = max(U, [], 1);
    figure
    gscatter(mat(:,1), mat(:,2), i')
    title('Proposed method output')
end

