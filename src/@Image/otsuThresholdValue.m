function value = otsuThresholdValue(img, varargin)
%OTSUTHRESHOLDVALUE Compute the value for threshold using Otsu method
%
%   BIN = otsuThresholdValue(IMG)
%   Computes the threshold value for segmenting image IMG, based on
%   Otsu's method.
%
%   ... = otsuThresholdValue(IMG, ROI)
%   Computes Otsu threshold value using only the pixelsor voxels in the
%   given Region of interest. 
%   ROI is a binary image the same size as the input image.
%   
%
%   Example
%     % Compute threshold value on coins image
%     img = Image.read('coins.png');
%     figure; show(img);
%     V = otsuThresholdValue(img);
%     figure; show(img > V);
%
%   Note
%   Only implemented for grayscale image coded on uint8.
%
%
%   See also
%   otsuThreshold, histogram
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-01-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% compute normalized histogram
h = histogram(img, varargin{:})';
h = h / sum(h);

% number of gray levels
L = 256;

% just a vector of indices
li = 1:L;

% average value within image
mu = sum(h .* li);

% allocate memory
sigmab = zeros(1, L);
sigmaw = zeros(1, L);

for t = 1:256
    % linear indices for each class
    ind0 = 1:t;
    ind1 = t+1:L;
    
    % probabilities associated with each class
    p0 = sum(h(ind0));
    p1 = sum(h(ind1));
    
    % average value of each class
    mu0 = sum(h(ind0) .* li(ind0)) / p0;
    mu1 = sum(h(ind1) .* li(ind1)) / p1;
    
    % inner variance of each class
    var0 = sum( h(ind0) .* (li(ind0) - mu0) .^ 2) / p0;
    var1 = sum( h(ind1) .* (li(ind1) - mu1) .^ 2) / p1;
    
    % between (inter) class variance
    sigmab(t) = p0 * (mu0 - mu) ^ 2 + p1 * (mu1 - mu) ^ 2;
    
    % within (intra) class variance
    sigmaw(t) = p0 * var0 + p1 * var1;
end

% compute threshold value
[mini, ind] = min(sigmaw); %#ok<ASGLU>
value = ind - 1;
