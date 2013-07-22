                SUBROUTINE EIGX(MAT, W, N)
                INTEGER N 
                DOUBLE PRECISION MAT(*), W(*)  
                CHARACTER  JOBZ, UPLO
                INTEGER    INFO, LDZ, I
                DOUBLE PRECISION Z(N,N), WORK(3*N)
                JOBZ = 'N'
                UPLO = 'L' 
                LDZ = N
 13             FORMAT(F9.3)
                CALL DSPEV  (JOBZ, UPLO, N, MAT, W, Z, LDZ, WORK, INFO )
                IF (INFO.EQ.0) RETURN
                WRITE(6,11) INFO
 11             FORMAT('INFO:',I6)  
                END

                SUBROUTINE EIGXV(MAT, W, Z, N)
                INTEGER N 
                DOUBLE PRECISION MAT(*), W(*)  , Z(N, N)
                CHARACTER  JOBZ, UPLO
                INTEGER    INFO, LDZ, I
                DOUBLE PRECISION WORK(3*N)
                JOBZ = 'V'
                UPLO = 'L' 
                LDZ = N
 13             FORMAT(F9.3)
                CALL DSPEV  (JOBZ, UPLO, N, MAT, W, Z, LDZ, WORK, INFO )
                IF (INFO.EQ.0) RETURN
                WRITE(6,11) INFO
 11             FORMAT('INFO:',I6)  
                END

                SUBROUTINE    HELLO
                 WRITE(6,101)
 101             FORMAT('hello world from fortran')  
                END


                SUBROUTINE CDC(MAT, N)
                IMPLICIT NONE
                INTEGER N, LDA, INFO
                DOUBLE PRECISION MAT(*)
                CHARACTER*1 UPLO 

                INTEGER I

                LDA = N
                UPLO = 'L'

                CALL DPOTRF(UPLO, N, MAT, LDA, INFO)

                IF ( INFO .LT. 0 ) THEN
                  WRITE(6,21) -INFO
                ELSE IF ( INFO .GT. 0 ) THEN
                  WRITE(6,31) INFO
                ENDIF

                RETURN
   21           FORMAT('error (CDC): illegal argument ', i2) 
   31           FORMAT('error (CDC): minor not positive definite', i2) 
                END

                SUBROUTINE INVERSE(MAT,N)
                IMPLICIT NONE
                DOUBLE PRECISION MAT(*)
                INTEGER N

                DOUBLE PRECISION WORK(N*N) 
                INTEGER IPIV(N), LWORK, INFO

                LWORK = N*N 

                CALL DGETRF( N, N, MAT, N, IPIV, INFO)

                IF ( INFO .LT. 0 ) THEN
                  WRITE(6,41) -INFO
                ELSE IF ( INFO .GT. 0 ) THEN
                  WRITE(6,51) INFO
                ENDIF

                CALL DGETRI(N, MAT, N, IPIV, WORK, LWORK, INFO)

                IF ( INFO .LT. 0 ) THEN
                  WRITE(6,41) -INFO
                ELSE IF ( INFO .GT. 0 ) THEN
                  WRITE(6,51) INFO
                ENDIF

                RETURN
   41           FORMAT('error (INVERSE): illegal argument ', i2) 
   51           FORMAT('error (INVERSE): singular matrix', i2) 
                END

                SUBROUTINE SOLVE(MAT, V, N)
                IMPLICIT NONE
                DOUBLE PRECISION MAT(*), V(*)
                INTEGER N, I

                DOUBLE PRECISION WORK(N*N)
                CHARACTER TRANS
                INTEGER IPIV(N), LWORK, INFO, NRHS, LDB

                LWORK = N*N
                TRANS = 'N'
                NRHS = 1
                LDB  = N

                CALL DGETRF( N, N, MAT, N, IPIV, INFO)

                IF ( INFO .LT. 0 ) THEN
                  WRITE(6,61) -INFO
                ELSE IF ( INFO .GT. 0 ) THEN
                  WRITE(6,71) INFO
                ENDIF

                CALL DGETRS(TRANS, N, NRHS, MAT, N, IPIV, V, LDB, INFO)

                IF ( INFO .LT. 0 ) THEN
                  WRITE(6,61) -INFO
                ENDIF

                RETURN
   61           FORMAT('error (SOLVE): illegal argument ', i2) 
   71           FORMAT('error (SOLVE): singular matrix', i2) 
                END

                SUBROUTINE GENEIGSOLVE(A, B, U, N)
                IMPLICIT NONE
                DOUBLE PRECISION A(*), B(*), U(*)
                INTEGER N

                DOUBLE PRECISION WORK(N*N)
                INTEGER LWORK, INFO

                LWORK = N*N

                CALL DSYGV(1, 'V', 'U', N, A, N, B, N, U, WORK, 
     +               LWORK, INFO)

                IF ( INFO .LT. 0 )  THEN
                  WRITE(6,81) -INFO
                ELSE IF ( INFO .GT. 0 .AND. INFO .LE. N ) THEN
                  WRITE(6,91) INFO
                ELSE IF ( INFO .GT. N .AND. INFO .LE. 2*N ) THEN
                  WRITE(6,101) INFO
                ENDIF

                RETURN
   81           FORMAT('error (GENEIGSOLVE): illegal argument ', i2)
   91           FORMAT('error (GENEIGSOLVE): failure to converge ', i2)
  101           FORMAT('error (GENEIGSOLVE): not positive definite', i2)
                END




















