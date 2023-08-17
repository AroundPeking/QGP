        !COMPILER-GENERATED INTERFACE MODULE: Tue Jul  4 09:47:50 2023
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE INTEGRAL_D__genmod
          INTERFACE 
            SUBROUTINE INTEGRAL_D(FNX,A,B,DEL,Q,SUMF)
              REAL(KIND=8) :: FNX
              EXTERNAL FNX
              REAL(KIND=8) :: A
              REAL(KIND=8) :: B
              REAL(KIND=8) :: DEL
              REAL(KIND=8) :: Q
              REAL(KIND=8) :: SUMF
            END SUBROUTINE INTEGRAL_D
          END INTERFACE 
        END MODULE INTEGRAL_D__genmod
