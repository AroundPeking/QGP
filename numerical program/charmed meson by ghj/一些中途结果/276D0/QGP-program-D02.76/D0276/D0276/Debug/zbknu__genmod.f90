        !COMPILER-GENERATED INTERFACE MODULE: Sun Oct 23 14:56:51 2022
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZBKNU__genmod
          INTERFACE 
            SUBROUTINE ZBKNU(ZR,ZI,FNU,KODE,N,YR,YI,NZ,TOL,ELIM,ALIM)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: ZR
              REAL(KIND=8) :: ZI
              REAL(KIND=8) :: FNU
              INTEGER(KIND=4) :: KODE
              REAL(KIND=8) :: YR(N)
              REAL(KIND=8) :: YI(N)
              INTEGER(KIND=4) :: NZ
              REAL(KIND=8) :: TOL
              REAL(KIND=8) :: ELIM
              REAL(KIND=8) :: ALIM
            END SUBROUTINE ZBKNU
          END INTERFACE 
        END MODULE ZBKNU__genmod
