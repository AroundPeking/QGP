
	SUBROUTINE GWITY(T,Y,M,H,N,Z,F,D,A)
	DIMENSION Y(M),D(M),Z(M,N),A(M)
	DOUBLE PRECISION Y,D,Z,T,H,X,A
	DO 10 I=1,M
10	Z(I,1)=Y(I)
	CALL F(T,Y,M,D)
	DO 40 J=2,N
	  DO 20 I=1,M
20	  A(I)=Z(I,J-1)+H*D(I)/2.0
	  X=T+(J-1.5)*H
	  CALL F(X,A,M,Y)
	  DO 30 I=1,M
	    D(I)=2.0*Y(I)-D(I)
	    Z(I,J)=Z(I,J-1)+H*Y(I)
30	  CONTINUE
40	CONTINUE
	RETURN
	END

