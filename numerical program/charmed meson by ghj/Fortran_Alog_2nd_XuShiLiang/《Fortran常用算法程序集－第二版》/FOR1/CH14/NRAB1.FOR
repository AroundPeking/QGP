

	FUNCTION NRAB1(R,A,B)
	INTEGER A,B
	S=B-A+1.0
	K=LOG(S-0.5)/LOG(2.0)+1
	L=1
	DO 10 I=1,K
10	L=2*L
	K=1
	S=4.0*L
20	IF (K.LE.1) THEN
	  R=R+R+R+R+R
	  M=R/S
	  R=R-M*S
	  J=A+R/4.0
	  IF (J.LE.B) THEN
	    NRAB1=J
	    K=K+1
	  END IF
	  GOTO 20
	END IF
	RETURN
	END


