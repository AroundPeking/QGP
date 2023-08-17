        !COMPILER-GENERATED INTERFACE MODULE: Tue Feb 14 14:31:50 2023
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE INTEGRAL_1D__genmod
          INTERFACE 
            SUBROUTINE INTEGRAL_1D(FNX,A,B,DEL,SUMF)
              REAL(KIND=8) :: FNX
              EXTERNAL FNX
              REAL(KIND=8) :: A
              REAL(KIND=8) :: B
              REAL(KIND=8) :: DEL
              REAL(KIND=8) :: SUMF
            END SUBROUTINE INTEGRAL_1D
          END INTERFACE 
        END MODULE INTEGRAL_1D__genmod
