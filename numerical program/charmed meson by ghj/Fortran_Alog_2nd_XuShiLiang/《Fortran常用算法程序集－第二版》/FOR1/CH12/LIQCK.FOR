

	SUBROUTINE LIQCK(A,N,MM,NN,M,k,L)
	INTEGER A(N),M(K),T
	L=1
	NTOP=2
	M(1)=MM
	M(2)=NN
10	IF (NTOP.NE.0) THEN
	  MS=M(NTOP)
	  KS=M(NTOP-1)
	  NTOP=NTOP-2
20	  IF (KS.LT.MS) THEN
	    J=(MS+KS)/2
	    IF ((A(KS).GE.A(MS)).AND.(A(MS).GE.A(J))) THEN
	      I=MS
	    ELSE IF ((A(KS).GE.A(J)).AND.(A(J).GE.A(MS))) THEN
	        I=J
	    ELSE
	      I=KS
	    END IF
	    T=A(I)
	    A(I)=A(KS)
	    I=KS
	    J=MS
30	    IF (I.NE.J) THEN
40	      IF ((A(J).GE.T).AND.(I.LT.J)) THEN
	        J=J-1
	        GOTO 40
	      END IF
	      IF (I.LT.J) THEN
	        A(I)=A(J)
	        I=I+1
50	        IF ((A(I).LE.T).AND.(I.LT.J)) THEN
	          I=I+1
	          GOTO 50
	        END IF
	        IF(I.LT.J) THEN
	          A(J)=A(I)
	          J=J-1
	        END IF
	      END IF
	      GOTO 30
	    END IF
	    A(I)=T
	    IF (NTOP.GT.(K-2)) THEN
	      L=0
	      WRITE(*,60)
	      RETURN
	    END IF
60	    FORMAT(1X,'FAIL')
	    M(NTOP+1)=I+1
	    M(NTOP+2)=MS
	    NTOP=NTOP+2
	    MS=I-1
	    GOTO 20
	  END IF
	  GOTO 10
	END IF
	RETURN
	END

