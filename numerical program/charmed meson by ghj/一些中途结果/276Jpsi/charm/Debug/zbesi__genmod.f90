        !COMPILER-GENERATED INTERFACE MODULE: Sat Oct 22 19:50:05 2022
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ZBESI__genmod
          INTERFACE 
            SUBROUTINE ZBESI(ZR,ZI,FNU,KODE,N,CYR,CYI,NZ,IERR)
              REAL(KIND=8) :: ZR
              REAL(KIND=8) :: ZI
              REAL(KIND=8) :: FNU
              INTEGER(KIND=4) :: KODE
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: CYR(1)
              REAL(KIND=8) :: CYI(1)
              INTEGER(KIND=4) :: NZ
              INTEGER(KIND=4) :: IERR
            END SUBROUTINE ZBESI
          END INTERFACE 
        END MODULE ZBESI__genmod
