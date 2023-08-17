        !COMPILER-GENERATED INTERFACE MODULE: Sun Jun 13 11:55:12 2021
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE INTEGRAL_2D__genmod
          INTERFACE 
            SUBROUTINE INTEGRAL_2D(FNX,PT,IDP1,IDP2,IDP3,CENTR,SUMF)
              REAL(KIND=8) :: FNX
              EXTERNAL FNX
              REAL(KIND=8) :: PT
              INTEGER(KIND=4) :: IDP1
              INTEGER(KIND=4) :: IDP2
              INTEGER(KIND=4) :: IDP3
              REAL(KIND=8) :: CENTR
              REAL(KIND=8) :: SUMF
            END SUBROUTINE INTEGRAL_2D
          END INTERFACE 
        END MODULE INTEGRAL_2D__genmod
