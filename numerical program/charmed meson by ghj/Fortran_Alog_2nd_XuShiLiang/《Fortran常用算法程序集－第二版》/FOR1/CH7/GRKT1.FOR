
	SUBROUTINE GRKT1(T,Y,M,H,N,Z,F,D,B)
	DIMENSION Y(M),D(M),Z(M,N),A(4),B(M)
	DOUBLE PRECISION Y,D,Z,A,B,T,H,X,TT
	A(1)=H/2.0
	A(2)=A(1)
	A(3)=H
	A(4)=H
	DO 5 I=1,M
5	Z(I,1)=Y(I)
	X=T
	DO 100 J=2,N
	  CALL F(T,Y,M,D)
	  DO 10 I=1,M
10	  B(I)=Y(I)
	  DO 30 K=1,3
	    DO 20 I=1,M
	      Y(I)=Z(I,J-1)+A(K)*D(I)
	      B(I)=B(I)+A(K+1)*D(I)/3.0
20	    CONTINUE
	    TT=T+A(K)
	    CALL F(TT,Y,M,D)
30	  CONTINUE
	  DO 40 I=1,M
40	  Y(I)=B(I)+H*D(I)/6.0
	  DO 50 I=1,M
50	  Z(I,J)=Y(I)
	  T=T+H
100	CONTINUE
	T=X
	RETURN
	END

