function z = rectangles(x, y, dim)

perm = []; nshifts = 0;
if nargin == 3 % retangles(x,y,dim)
  if ~isscalar(dim) || ~isnumeric(dim) || (dim ~= floor(dim))
      error(message('matlab:getdimarg:dimensionmustbepositiveinteger'));
  end
  dim = min(ndims(y)+1, dim);
  perm = [dim:max(ndims(y),dim) 1:dim-1];
  y = permute(y,perm);
  m = size(y,1);
elseif nargin == 2 && isscalar(y) % rectangles(y,dim)
  dim = y;
  y = x;
  x = 1;
  if ~isscalar(dim) || ~isnumeric(dim) || (dim ~= floor(dim))
      error(message('matlab:getdimarg:dimensionmustbepositiveinteger'));
  end
  dim = min(ndims(y)+1, dim);
  perm = [dim:max(ndims(y),dim) 1:dim-1];
  y = permute(y,perm);
  m = size(y,1);
else % rectangles(y) or rectangles(x,y)
  if nargin < 2
      y = x;
      x = 1;
  end
  [y,nshifts] = shiftdim(y);
  m = size(y,1);
end
if ~isvector(x)
  error(message('matlab:rectangles:xnotvector'));
end
x = x(:);
if ~isscalar(x) && length(x) ~= m
    error(message('matlab:rectangles:lengthxmismatchy'));
end

% the output size for [] is a special case when dim is not given.
if isempty(perm) && isequal(y,[])
  z = zeros(1,class(y));
  return;
end

% rectangle sum computed with vector-matrix multiply.
if isscalar(x)
    z = x * sum(y, 1);
else
    z = diff(x,1,1).' * y;
end

siz = size(y);
siz(1) = 1;
z = reshape(z,[ones(1,nshifts),siz]);
if ~isempty(perm) && ~isscalar(z)
    z = ipermute(z,perm);
end
