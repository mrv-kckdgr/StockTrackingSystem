﻿CREATE TRIGGER AccountActiveCode
on SALES_CUSTOMERS
after insert

as

declare @id int,
		@fullname varchar(100),
		@mail varchar(100),
		@code int,
		@message nvarchar(max)

declare cls cursor for select ID, FIRSTNAME + ' ' + LASTNAME , EMAIL from inserted
open cls
fetch next from cls into @id, @fullname, @mail

while @@FETCH_STATUS = 0
begin

set @code=RAND()*55000+10000
UPDATE [SALES_CUSTOMERS] set LOGINCODE = @code where ID=@id
set @message = concat('<html><head><style> body { font-size:18px; } .username{ color: red; font-size:18px;}</style></head><body> Sayın <strong class="username">', @fullname, ';</strong><br/><br/>',
'Sisteme kayıt için gerekli tek kullanımlık şifreniz: <b>', convert(nvarchar, @code), '</b><br><br/>',
'Tek kullanımlık şifrenizi kimseyle paylaşmayınız!!!<br><br><br><br>',
'<a href="https://github.com/Kucukdogru/StockTrackingSystem" target="_blank"><center><img src="https://www.bosch-home.com.tr/store/medias/sys_master/root/h15/h35/9828799512606/Turkish-165px.jpg" alt="StockTrackingSystem" title="StockTrackingSystem" width="300px" style="margin:auto; margin-top:50px; left:15px;"></center></a>'
)

exec msdb.dbo.sp_send_dbmail
		@profile_name = 'Genel Mail',
		@recipients=@mail,
		@body=@message,
		@subject='Sistem Hesabı Aktifleştirme Kodu',
		@body_format = 'HTML'

fetch next from cls into @id, @fullname, @mail
end


close cls
deallocate cls
