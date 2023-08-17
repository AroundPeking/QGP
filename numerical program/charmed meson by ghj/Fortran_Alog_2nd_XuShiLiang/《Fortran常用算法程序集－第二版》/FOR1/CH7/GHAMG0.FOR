
	EXTERNAL F
	DIMENSION Y(3),D(3),Z(3,11),B(4,3),U(3),BB(3),CC(3),GG(3)
	DOUBLE PRECISION Y,D,Z,A,T,H,B,U,BB,CC,GG
	A=0.0
	H=0.05
	Y(1)=1.0
	Y(2)=1.0
	Y(3)=1.0
	N=11
	M=3
	EPS=0.0001
	CALL GHAMG(A,H,N,Y,M,Z,F,D,EPS,B,U,BB,CC,GG)
	WRITE(*,*)
	DO 10 I=1,N
	  T=(I-1)*H
	  WRITE(*,20) T,(Z(J,I),J=1,M)
	  WRITE(*,*)
10	CONTINUE
20	FORMAT(1X,'T=',F6.3,3X,'Y1=',D13.6,3X,'Y2=',D13.6,
     *         3X,'Y3=',D13.6)
	END

	SUBROUTINE F(T,Y,M,D)
	DIMENSION Y(M),D(M)
	DOUBLE PRECISION Y,D,T
	D(1)=Y(2)
	D(2)=-Y(1)
	D(3)=Y(3)
	RETURN
	END

