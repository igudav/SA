#include "matrix.h"
#include "mex.h"
#include <complex.h>
#include <math.h>

#define EPS 1e-10

void mexFunction(int nlhs, mxArray *plhs[],
        int nrhs, const mxArray *prhs[]) {

    enum {
        MAX_NLHS = 3,
    };

    if (nlhs < 2 || nlhs > 3) {
        mexErrMsgIdAndTxt("MATLAB:cubesolve:output_arguments", 
                "number of output arguments must be 2 or 3");
    }
    
    size_t mrows = mxGetM(prhs[0]);
    size_t ncols = mxGetN(prhs[0]);
    for (int i = 0; i < nlhs; ++i) {
        plhs[i] = mxCreateDoubleMatrix((mwSize) mrows, (mwSize) ncols, mxCOMPLEX);
    }

    mxComplexDouble *res[MAX_NLHS];
    for (int i = 0; i < nlhs; ++i) {
        res[i] = (mxComplexDouble *) mxGetComplexDoubles(plhs[i]);
    }

    mxComplexDouble *A, *B, *C;
    A = (mxComplexDouble *) mxGetComplexDoubles(prhs[0]);
    B = (mxComplexDouble *) mxGetComplexDoubles(prhs[1]);
    C = (mxComplexDouble *) mxGetComplexDoubles(prhs[2]);
    complex roots[] = {0, 0, 0};
    
    mexPrintf("%d\n", A);
    return;
    for (size_t i = 0; i < mrows * ncols; ++i) {
        if (A[i].real * A[i].real + A[i].imag * A[i].imag < EPS) {
            mexErrMsgIdAndTxt("MATLAB:cubesolve:null_coeff", 
                    "A must be not null");
        }
        
        complex p = (B[i].real + I * B[i].imag) / (A[i].real + I * A[i].imag);
        complex q = (C[i].real + I * C[i].imag) / (A[i].real + I * A[i].imag);
        complex w = csqrt(cpow(p / 3, 3.0) + cpow(q / 2, 2.0));
        complex alpha = cpow(-q / 2 + w, 1.0 / 3.0);
        complex beta = cpow(-q / 2 - w, 1.0 / 3.0);
        
        roots[0] = -0.5 * (alpha + beta) + I * sqrt(3) / 2.0 * (alpha - beta);
        roots[1] = -0.5 * (alpha + beta) - I * sqrt(3) / 2.0 * (alpha - beta);
        if (nlhs == 3) {
            roots[2] = alpha + beta;
        }

        for (int k = 0; k < nlhs; ++k) {
            res[k][i].real = creal(roots[k]);
            res[k][i].imag = cimag(roots[k]);
        }
    }
}
