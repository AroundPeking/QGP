

	SUBROUTINE KKSPT(N,Y,YY)
	DIMENSION Y(N),YY(N)
	IF (N.LT.5) THEN
	  DO 10 I=1,N
10	  YY(I)=Y(I)
          RETURN
	END IF
	YY(1)=(69.*Y(1)+4.*Y(2)-6.*Y(3)+4.*Y(4)-Y(5))/70.
	YY(2)=(2.*Y(1)+27.*Y(2)+12.*Y(3)-8.*Y(4)+2.*Y(5))/35.
	DO 20 I=3,N-2
20	YY(I)=(-3.*Y(I-2)+12.*Y(I-1)+17.*Y(I)+
     *           12.*Y(I+1)-3.*Y(I+2))/35.
	YY(N-1)=(2.*Y(N-4)-8.*Y(N-3)+12.*Y(N-2)+
     *           27.*Y(N-1)+2.*Y(N))/35.
	YY(N)=(-Y(N-4)+4.*Y(N-3)-6.*Y(N-2)+
     *         4.*Y(N-1)+69.*Y(N))/70.
	RETURN
	END

