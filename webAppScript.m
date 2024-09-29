function webAppScript
    % Create a UI figure
    fig = uifigure('Name', 'Image Processing Web App', 'Position', [100, 100, 800, 600]);

    % Create UI components
    imgInput = uiimage(fig, 'Position', [50, 400, 300, 100]);
    btnUpload = uibutton(fig, 'Text', 'Upload Image', 'Position', [50, 350, 150, 30], 'ButtonPushedFcn', @(btn, event) uploadImage(imgInput));
    btnProcess = uibutton(fig, 'Text', 'Process Image', 'Position', [210, 350, 150, 30], 'ButtonPushedFcn', @(btn, event) processImage(imgInput));

    % Callback functions
    function uploadImage(img)
        [filename, pathname] = uigetfile({'*.jpg;*.png;*.tif', 'Image files (*.jpg, *.png, *.tif)'; '*.*', 'All files (*.*)'});
        if ~isequal(filename, 0)
            fullpath = fullfile(pathname, filename);
            img.ImageSource = fullpath;
            img.UserData = fullpath; % Store the full path for processing later
        end
    end

    function processImage(img)
        if isfield(img, 'UserData')
            % Load the image and process it
            inputImage = imread(img.UserData);
            outputImage = processImage(inputImage);

            % Display the processed image
            uialert(fig, 'Image processed successfully!', 'Success');
            imshow(outputImage, 'Parent', uiaxes(fig, 'Position', [400, 50, 300, 300]));
        else
            uialert(fig, 'Please upload an image first.', 'Warning');
        end
    end
end
