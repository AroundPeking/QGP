
	SUBROUTINE OPDIV(P,M,Q,N,S,K,R,L)
	DOUBLE PRECISION P(M),Q(N),S(K),R(L)
	DO 10 I=1,K
10	S(I)=0.0
	IF (Q(N)+1.0.EQ.1.0) RETURN
	LL=M-1
	DO 50 I=K,1,-1
	  S(I)=P(LL+1)/Q(N)
	  MM=LL
	  DO 30 J=1,N-1
	    P(MM)=P(MM)-S(I)*Q(N-J)
	    MM=MM-1
30	  CONTINUE
	  LL=LL-1
50	CONTINUE
	DO 80 I=1,L
80	R(I)=P(I)
	RETURN
	END

