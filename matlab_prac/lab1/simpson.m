function z = simpson(x,y,dim)

perm = []; nshifts = 0;
if nargin == 3 % trapz(x,y,dim)
  if ~isscalar(dim) || ~isnumeric(dim) || (dim ~= floor(dim))
      error(message('matlab:getdimarg:dimensionmustbepositiveinteger'));
  end
  dim = min(ndims(y)+1, dim);
  perm = [dim:max(ndims(y),dim) 1:dim-1];
  y = permute(y,perm);
  m = size(y,1);
elseif nargin == 2 && isscalar(y) % trapz(y,dim)
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
else % trapz(y) or trapz(x,y)
  if nargin < 2
      y = x;
      x = 1;
  end
  [y,nshifts] = shiftdim(y);
  m = size(y,1);
end
if ~isscalar(x)
  error(message('matlab:simpson:xnotscalar:dealyourselfwithnonuniformspacing'));
end
if mod(m, 2) ~= 1
    error(message('matlab:simpson:lengthmismatchy'));
end

% the output size for [] is a special case when dim is not given.
if isempty(perm) && isequal(y,[])
  z = zeros(1,class(y));
  return;
end

% trapezoid sum computed with vector-matrix multiply.

z = y(1, :) + 2 * sum(y(3:2:end - 2, :), 1) + 4 * sum(y(2:2:end - 1, :), 1) + y(end, :);
z = z * x / 3;

siz = size(y);
siz(1) = 1;
z = reshape(z,[ones(1,nshifts),siz]);
if ~isempty(perm) && ~isscalar(z)
    z = ipermute(z,perm);
end
