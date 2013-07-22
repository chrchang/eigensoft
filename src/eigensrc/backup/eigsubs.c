#include <stdio.h>
#include <limits.h>
#include <math.h>  
#include <nicklib.h> 
#include "eigsubs.h" 
/* ********************************************************************* */
void eigx_(double *pmat, double *ev, int *n) ;
void eigxv_(double *pmat, double *eval, double *evec, int *n) ;

void packsym(double *pmat, double *mat, int n) ;


void eigvals(double *mat, double *evals, int n) 
{
	 double *pmat ;  
         int len ; 

         len = n*(n+1) ; len /= 2 ;
	 ZALLOC(pmat, len, double) ;

	 vst(mat, mat, -1.0, n*n) ;
	 packsym(pmat, mat, n) ;
         eigx_(pmat, evals, &n) ;
	 free(pmat) ;
	 vst(mat, mat, -1.0, n*n) ;
	 vst(evals, evals, -1.0, n) ;
}
void eigvecs(double *mat, double *evals, double *evecs, int n) 
{
	 double *pmat ;  
         int len ; 

         len = n*(n+1) ; len /= 2 ;
	 ZALLOC(pmat, len, double) ;

	 vst(mat, mat, -1.0, n*n) ;
	 packsym(pmat, mat, n) ;

         eigxv_(pmat, evals, evecs, &n) ;
	 free(pmat) ;
	 vst(mat, mat, -1.0, n*n) ;
	 vst(evals, evals, -1.0, n) ;
}
   
void
packsym(double *pmat, double *mat, int n) 
	//  lapack L mode (fortran)
{ 
	int i, j, k = 0 ;
	for (i=0; i<n; i++)  {  
          for (j=i; j<n; j++) { 
             pmat[k] = mat[i*n+j] ;
	     ++k ;
	  }
	}
}

