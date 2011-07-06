function res = minus(this, arg)
%MINUS Overload the minus operator for image object
%
%   output = minus(input)
%
%   Example
%   minus
%
%   See also
% 
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-11-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

if isa(arg, 'Image')
    arg = arg.data;
end

newData = bsxfun(@minus, this.data, cast(arg, class(this.data)));

nd = ndims(this);
res = Image(nd, 'data', newData, 'parent', this);
