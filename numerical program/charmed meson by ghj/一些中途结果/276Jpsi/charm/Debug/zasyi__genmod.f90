        !COMPILER-GENERATED INTERFACE MODULE: Sat Oct 22 19:50:05 2022
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZASYI__genmod
          INTERFACE 
            SUBROUTINE ZASYI(ZR,ZI,FNU,KODE,N,YR,YI,NZ,RL,TOL,ELIM,ALIM)
              REAL(KIND=8) :: ZR
              REAL(KIND=8) :: ZI
              REAL(KIND=8) :: FNU
              INTEGER(KIND=4) :: KODE
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: YR(1)
              REAL(KIND=8) :: YI(1)
              INTEGER(KIND=4) :: NZ
              REAL(KIND=8) :: RL
              REAL(KIND=8) :: TOL
              REAL(KIND=8) :: ELIM
              REAL(KIND=8) :: ALIM
            END SUBROUTINE ZASYI
          END INTERFACE 
        END MODULE ZASYI__genmod
