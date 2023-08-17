
	EXTERNAL F
	DIMENSION Y(3),Z(3,11),D(3),A(3)
	DOUBLE PRECISION Y,Z,D,T,H,X,A
	T=0.0
	Y(1)=-1.0
	Y(2)=0.0
	Y(3)=1.0
	H=0.1
	M=3
	N=11
	CALL GWITY(T,Y,M,H,N,Z,F,D,A)
	WRITE(*,*)
	DO 10 I=1,N
	  X=(I-1)*H
	  WRITE(*,20) X
	  WRITE(*,30) (Z(J,I),J=1,M)
	  WRITE(*,*)
10	CONTINUE
20	FORMAT(1X,'T=',F5.2)
30	FORMAT(1X,'Y(1)=',D13.6,3X,'Y(2)=',D13.6,
     *         3X,'Y(3)=',D13.6)
	END

	SUBROUTINE F(T,Y,M,D)
	DIMENSION Y(M),D(M)
	DOUBLE PRECISION Y,D,T
	D(1)=Y(2)
	D(2)=-Y(1)
	D(3)=-Y(3)
	RETURN
	END

