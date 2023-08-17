
	SUBROUTINE OPLYS(A,N,B,M,X,L,P)
	DOUBLE PRECISION A(N),B(M),X(L),P(L)
	DOUBLE PRECISION Y,Z
	INTEGER T,S
	Y=A(N)
	DO 10 I=1,N
10	B(I)=A(I)/Y
	K=LOG(N-0.5)/LOG(2.0)+1
	NN=1
	DO 20 I=1,K
20	NN=2*NN
	DO 40 I=N+1,NN-1
40	B(I)=0.0
	B(NN)=1.0
	T=NN
	S=1
	DO 70 I=1,K-1
	  T=T/2
	  MM=-T
	  DO 60 J=1,S
	    MM=MM+T+T
	    B(MM)=B(MM)-1.0
	    DO 50 KK=2,T
50	    B(MM-KK+1)=B(MM-KK+1)-B(MM)*B(MM+T-KK+1)
60	  CONTINUE
	  S=S+S
70	CONTINUE
	DO 200 KK=1,L
	  DO 90 I=0,(NN-2)/2
90	  A(I+1)=X(KK)+B(2*I+1)
	  MM=1
	  Z=X(KK)
	  DO 110 I=1,K-1
	    MM=MM+MM
	    LL=MM+MM
	    Z=Z*Z
	    DO 100 J=0,NN-1,LL
100	    A(J/2+1)=A(J/2+1)+A((J+MM)/2+1)*(Z+B(J+MM))
110	  CONTINUE
	  Z=Z*Z/X(KK)
	  IF (NN.NE.N) A(1)=A(1)-Z
	  P(KK)=A(1)*Y
200	CONTINUE
	RETURN
	END

