
	SUBROUTINE GELR1(T,Y,M,H,N,Z,F,D)
	DIMENSION Y(M),Z(M,N),D(M)
	DOUBLE PRECISION Y,Z,D,T,H,X
	DO 10 I=1,M
10	Z(I,1)=Y(I)
	DO 50 J=2,N
	  X=T+(J-2)*H
	  CALL F(X,Y,M,D)
	  DO 20 I=1,M
20	  Y(I)=Z(I,J-1)+H*D(I)
	  X=T+(J-1)*H
	  CALL F(X,Y,M,D)
	  DO 30 I=1,M
30	  D(I)=Z(I,J-1)+H*D(I)
	  DO 40 I=1,M
	    Y(I)=(Y(I)+D(I))/2.0
	    Z(I,J)=Y(I)
40	  CONTINUE
50	CONTINUE
	RETURN
	END

