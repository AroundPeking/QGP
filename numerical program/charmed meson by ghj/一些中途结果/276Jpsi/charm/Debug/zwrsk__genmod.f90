        !COMPILER-GENERATED INTERFACE MODULE: Sat Oct 22 19:50:05 2022
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZWRSK__genmod
          INTERFACE 
            SUBROUTINE ZWRSK(ZRR,ZRI,FNU,KODE,N,YR,YI,NZ,CWR,CWI,TOL,   &
     &ELIM,ALIM)
              REAL(KIND=8) :: ZRR
              REAL(KIND=8) :: ZRI
              REAL(KIND=8) :: FNU
              INTEGER(KIND=4) :: KODE
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: YR(1)
              REAL(KIND=8) :: YI(1)
              INTEGER(KIND=4) :: NZ
              REAL(KIND=8) :: CWR(2)
              REAL(KIND=8) :: CWI(2)
              REAL(KIND=8) :: TOL
              REAL(KIND=8) :: ELIM
              REAL(KIND=8) :: ALIM
            END SUBROUTINE ZWRSK
          END INTERFACE 
        END MODULE ZWRSK__genmod
