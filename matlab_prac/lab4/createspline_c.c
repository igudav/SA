#include "matrix.h"
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {

    int n = mxGetN(prhs[0]) - 1;
    mxDouble *x = mxGetDoubles(prhs[0]);
    mxDouble *a = mxGetDoubles(prhs[1]);

    for (int i = 0; i < nlhs; ++i) {
        plhs[i] = mxCreateDoubleMatrix(1, n, mxREAL);
    }

    mxDouble *b = mxGetDoubles(plhs[1]);
    mxDouble c[n + 1];
    mxDouble *d = mxGetDoubles(plhs[3]);
    mxDouble h[n];

    for (int i = 0; i < n; ++i) {
        h[i] = x[i + 1] - x[i];
    }

    mxDouble A[n];
    for (int i = 1; i < n; ++i) {
        A[i] = 3 / h[i] * (a[i + 1] - a[i]) - 3 / h[i - 1] * (a[i] - a[i - 1]);
    }

    mxDouble l[n + 1], m[n], z[n + 1];
    l[0] = 1; 
    m[0] = z[0] = 0;

    for (int i = 1; i < n; ++i) {
        l[i] = 2 * (x[i + 1] - x[i - 1]) - h[i - 1] * m[i - 1];
        m[i] = h[i] / l[i];
        z[i] = (A[i] - h[i - 1] * z[i - 1]) / l[i];
    }

    l[n] = 1;
    z[n] = c[n] = 0;
    for (int j = n - 1; j >= 0; --j) {
        c[j] = z[j] - m[j] * c[j + 1];
        b[j] = (a[j + 1] - a[j]) / h[j] - h[j] * (c[j + 1] + 2 * c[j]) / 3;
        d[j] = (c[j + 1] - c[j]) / (3 * h[j]);
    }

    mxDouble *out_a = mxGetDoubles(plhs[0]);
    mxDouble *out_c = mxGetDoubles(plhs[2]);
    for (int i = 0; i < n; ++i) {
        out_a[i] = a[i];
        out_c[i] = c[i];
    }
}
