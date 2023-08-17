

	DIMENSION F(3,3),Q(3,3),R(1,1),H(1,3),Y(200,1),JS(1)
	DIMENSION X(200,3),P(3,3),G(3,1),E(1,1),A(3,3),B(3,3),IS(1)
	DOUBLE PRECISION F,Q,R,H,Y,X,P,G,E,S,A,B,RR
	REAL NGRN1
	DATA F/1.0,0.0,0.0,0.05,1.0,0.0,0.00125,0.05,1.0/
	DATA Q/0.1,3*0.0,0.1,3*0.0,0.1/
	DATA R/0.25/
	DATA H/1.0,0.0,0.0/
	DATA P/9*0.0/
	DATA X/5.0,199*0.0,-2.0,199*0.0,6.0,199*0.0/
	RR=3.0
	M=1
	N=3
	IA=3
	K=200
	DO 10 I=1,K
	  T=(I-1)*0.05
	  U=NGRN1(0.0,0.5,RR)
	  Y(I,1)=5.0-2.0*T+3.0*T*T+U
10	CONTINUE
	CALL KLMAN(N,M,K,F,Q,R,H,Y,X,P,G,L,E,IA,A,B,IS,JS)
	WRITE(*,*)
	IF (L.NE.0) THEN
	  WRITE(*,30)
	  DO 20 I=1,K,5
	    T=(I-1)*0.05
	    S=5.0-2.0*T+3.0*T*T
	    WRITE(*,40) T,S,Y(I,1),X(I,1),X(I,2),X(I,3)
20	  CONTINUE
	END IF
30	FORMAT(4X,'T',8X,'S',12X,'Y',12X,
     *          'X(1)',9X,'X(2)',9X,'X(3)')
40	FORMAT(1X,F6.2,5D13.6)
	WRITE(*,*)
	END


