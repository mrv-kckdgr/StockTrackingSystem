﻿--En çok satılan bozulan ürünü bulma
CREATE VIEW V_MOSTSPOILED
AS
SELECT top 10 P.PRODUCTCODE, P.PRODUCTNAME, count(AD.PRODUCTID) TOTALPIECE FROM COMPANY_AUTHORIZEDSERVICEDETAILS AD
	INNER JOIN PRODUCT_PRODUCT P ON P.ID=AD.PRODUCTID
	WHERE SERVICE_='Bakım Onarım'
	group by PRODUCTID, P.PRODUCTNAME, P.PRODUCTCODE
	HAVING count(AD.PRODUCTID)>=2;

 
---EXECUTE
SELECT * FROM V_MOSTSPOILED