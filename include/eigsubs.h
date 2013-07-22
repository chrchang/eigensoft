#ifndef _EIGSUBS_
#define _EIGSUBS_

#include <stdio.h>
#include <limits.h>
#include <math.h>  

void eigvals(double *mat, double *evals, int n) ;
void eigvecs(double *mat, double *evals, double *evecs, int n) ;
void eigb(double *lam, double *a, double *b, int n) ;           
void eigc(double *lam, double *a, double *b, int n) ;           
void chdecomp(double *mat, int n) ;
void inverse(double *mat, int n) ;
void solve(double *mat, double *b, double *v, int n) ;
void geneigsolve(double *pmat, double *qmat, double *evec, double *eval, int n);
double twestxx(double *lam, int m, double *pzn,  double *pzvar) ;  

typedef struct {
  int vecno ; 
  double score ; 
} OUTLINFO ;; 

#endif
