

	SUBROUTINE NRABS(R,A,B,N,P)
	INTEGER P(N)
	INTEGER A,B
	S=B-A+1.0
	K=LOG(S-0.5)/LOG(2.0)+1
	L=1
	DO 10 I=1,K
10	L=2*L
	K=1
	S=4.0*L
	I=1
20	IF ((I.LE.L).AND.(K.LE.N)) THEN
	  R=R+R+R+R+R
	  M=R/S
	  R=R-M*S
	  J=A+R/4.0
	  IF (J.LE.B) THEN
	    P(K)=J
	    K=K+1
	  END IF
	  I=I+1
	  GOTO 20
	END IF
	RETURN
	END


