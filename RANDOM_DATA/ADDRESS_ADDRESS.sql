declare @i int = 1000
declare @CUSTOMERID INT
declare @CITYID SMALLINT
declare @CITYNAME VARCHAR(50)
declare @TOWNID INT
declare @TOWNNAME VARCHAR(50)
declare @NUMBER INT
declare @POSTALCODE varchar(10)
declare @ADDRESSTEXT varchar(500)

while @i>0
begin

SELECT TOP 1 @USERID=ID FROM USERS ORDER BY NEWID()

SELECT TOP 1 @TOWNID=T.ID, @CITYID=T.CITYID, @TOWNNAME=T.TOWNNAME, @CITYNAME=C.CITYNAME FROM TOWNS T
INNER JOIN CITIES C ON C.ID=T.CITYID
ORDER BY NEWID()




SELECT TOP 1 @DISTRICTID=ID, @DISTRICT=DISTRICT FROM DISTRICTS WHERE TOWNID=@TOWNID
--SELECT @DISTRICTID, @TOWNID
 SET @POSTALCODE = CONVERT(INT, RAND()*50000 + 1000)
 select @POSTALCODE



SET @NUMBER=CONVERT(INT, RAND()*100+500)

select @ADDRESSTEXT = CONCAT_WS(' ', trim(@DISTRICT),  'No:' , @NUMBER, @POSTALCODE, @TOWNNAME,'/',@CITYNAME )
SELECT @ADDRESSTEXT


INSERT INTO [dbo].[ADDRESS_ADDRESS]([USERID], [COUNTRYID], [CITYID], [TOWNID], [DISTRICTID], [POSTALCODE], [ADDRESSTEXT])

     VALUES
           (@USERID, @COUNTRYID, @CITYID, @TOWNID, @DISTRICTID, @POSTALCODE, @ADDRESSTEXT)
           

set @i = @i - 1
END