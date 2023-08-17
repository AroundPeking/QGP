
	DIMENSION A(4,4),B(4),X(4),P(4,4),R(4),E(4),JS(4)
	DOUBLE PRECISION A,B,X,P,R,E
	DATA A/3.4336,-0.5238,0.67105,-0.15272,
     *         -0.5238,3.28326,-0.73051,-0.2689,
     *         0.67105,-0.73051,4.02612,0.01835,
     *         -0.15272,-0.2689,0.01835,2.75702/
        DATA B/-1.0,1.5,2.5,-2.0/
	N=4
	EPS=0.000001
	CALL ABINT(A,N,B,EPS,X,L,P,JS,R,E)
	WRITE(*,*)
	WRITE(*,*) 'L=',L
	IF (L.NE.0) THEN
          WRITE(*,*)
	  DO 10 K=1,N
10	  WRITE(*,100) K,X(K)
          WRITE(*,*)
	END IF
100     FORMAT(3X,'X(',I2,' )=',D15.6)
        END

