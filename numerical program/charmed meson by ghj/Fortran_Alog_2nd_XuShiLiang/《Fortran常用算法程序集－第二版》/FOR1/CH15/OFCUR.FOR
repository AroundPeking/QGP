

	SUBROUTINE OFCUR(A,B,H,D,YC,XC,K,N,F)
	CHARACTER C(60)
	CHARACTER YC,XC
	WRITE(*,*)
	WRITE(*,10) A,B
10	FORMAT(1X,'BEGIN=',E13.6,10X,'END=',E13.6)
	WRITE(*,20) H
20	FORMAT(1X,'STEP=',E13.6)
	WRITE(*,30) D
30	FORMAT(1X,'SCALE=',E13.6)
	WRITE(*,*)
	IF (K.LT.1) K=1
	IF (K.GT.60) K=60
	C(K)=XC
	L=0
	X=A
40	IF (X.LE.B) THEN
	  Y=F(X)
	  YY=Y/D
	  IF (YY.GE.0.0) M=YY+0.5
	  IF (YY.LT.0.0) THEN
	    M=ABS(YY)+0.5
	    M=-M
	  END IF
	  M=K+M
	  IF (M.LT.1) M=1
	  IF (M.GT.60) M=60
	  DO 50 I=1,60
	    IF (I.NE.K) C(I)=' '
50	  CONTINUE
	  IF (M.NE.K) C(M)=YC
	  IF (L.EQ.0) THEN
	    WRITE(*,60) Y,(C(I),I=1,60)
	  ELSE
	    WRITE(*,70) (C(I),I=1,60)
	  END IF
	  L=L+1
	  IF (L.EQ.N) L=0
	  X=X+H
	  GOTO 40
	END IF
60	FORMAT(1X,E13.6,60A1)
70	FORMAT(14X,60A1)
	WRITE(*,*)
	RETURN
	END


