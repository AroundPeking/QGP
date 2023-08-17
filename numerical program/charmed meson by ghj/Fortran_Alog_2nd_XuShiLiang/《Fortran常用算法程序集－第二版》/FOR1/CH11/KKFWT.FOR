

	SUBROUTINE KKFWT(P,K,N,X)
	DIMENSION P(N),X(N)
	M=1
	L=N
	IT=2
	X(1)=1
	II=N/2+1
	X(II)=2
	DO 20 I=1,K-1
	  M=M+M
	  L=L/2
	  IT=IT+IT
	  DO 10 J=0,M-1
10	  X(J*L+L/2+1)=IT+1-X(J*L+1)
20	CONTINUE
	DO 30 I=1,N
	  II=X(I)
	  X(I)=P(II)
30	CONTINUE
	L=1
	DO 60 I=1,K
	  M=N/(2*L)-1
	  DO 50 J=0,M
	    IT=2*L*J
	    DO 40 IS=0,L-1
	      Q=X(IT+IS+1)+X(IT+IS+L+1)
	      X(IT+IS+L+1)=X(IT+IS+1)-X(IT+IS+L+1)
	      X(IT+IS+1)=Q
40	    CONTINUE
50	  CONTINUE
	  L=2*L
60	CONTINUE
	RETURN
	END

