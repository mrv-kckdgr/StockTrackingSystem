﻿--GİRİLEN MÜŞTERİ ID YE GÖRE MÜŞTERİNİN ADRESLERİNİ LİSTELEME


CREATE PROC P_CUSTOMERADDRESSINFORMATION
	@CUSTOMERID INT
	AS
	BEGIN

	SELECT C.FIRSTNAME + C.LASTNAME, A.ADDRESSTEXT FROM ADDRESS_ADDRESS A
		INNER JOIN SALES_CUSTOMERS C ON C.ID=A.CUSTOMERID
		WHERE C.ID = @CUSTOMERID
		GROUP BY C.FIRSTNAME + C.LASTNAME, A.ADDRESSTEXT

	END