câu 1
IF OBJECT_ID('fn_TUOI_NV') IS NOT NULL
	DROP FUNCTION fn_TUOINV
GO

CREATE FUNCTION fn_TUOI_NV(@MaNhanVien nvarchar(9))
returns int
as
	begin
		RETURN (SELECT YEAR(GETDATE())-YEAR(ngsinh)
		from NHANVIEN WHERE MANV=@MaNhanVien)
	end

PRINT N'TUỔI NHÂN VIÊN :' + CAST(dbo.FN_TUOI_NV('001')AS VARCHAR (5))

SELECT * FROM NHANVIEN



	select count(mada) from PHANCONG where MA_NVIEN='001'
	select * from PHANCONG

 IF OBJECT_ID('fn_Sdean_NV') IS NOT NULL
	DROP FUNCTION fn_Sdean_NV
GO
CREATE FUNCTION fn_sdean_NV(@MaNhanVien nvarchar(9))
returns int
as
	begin
		RETURN (SELECT count(mada) from PHANCONG 
		where MA_NVIEN=@MaNhanVien)
	end

print(' số luọng đề án của nhân viên :'+ cast( dbo.fn_Sdean_nv ('001') as varchar (5)))


if OBJECT_ID('fn_Sphai_nv') is not null
drop function fn_Sphai_nv
go

create function fn_Sphai_NV( @gioitinh nvarchar(4))
returns int 
as
	begin 
	 return (select count(*) from NHANVIEN
	 where upper(phai)=UPPER(@gioitinh))
	end

	select* from NHANVIEN
	print N' Số lượng nhân viên nam:' +cast(dbo.fn_Sphai_nv('Nam') as varchar(5))
	print N' Số lượng nhân viên nữ:' +cast(dbo.fn_Sphai_nv(N'Nữ') as varchar(5))



	
declare @luongtb float 
select @luongtb=avg(luong) from NHANVIEN
inner join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG
where upper(TENPHG)=UPPER(@tenphongban)

insert into @ListNV
	select concat(Honv,' ',TenLot,' ',TenNv),luong from nhanvien
	where luong>@luongtb

if OBJECT_ID('fn_luongtb_nv') is not null
	drop function fn_luongtb_nv
go

 create function fn_luongtb_nv(@tenphongban nvarchar(15))
 returns @ListNV table(Hoten nvarchar(60),luong float)
 as
	begin
	declare @luongtb float 
	select @luongtb=avg(luong) from NHANVIEN
	inner join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG
	where upper(TENPHG)=UPPER(@tenphongban)

	insert into @ListNV
	select concat(Honv,' ',TenLot,' ',TenNv),luong from nhanvien
	where luong>@luongtb
	return 
	end
select *from PHONGBAN
select *from dbo.fn_luongtb_nv(N'Điều hành');
select avg(luong) from NHANVIEN
	inner join PHONGBAN on PHONGBAN.MAPHG=NHANVIEN.PHG
	where upper(TENPHG)=UPPER (N'Điều Hành')
 
IF OBJECT_ID('FN_PB_NV_DEAN') IS NOT NULL
DROP FUNCTION FN_PB_NV_DEAN
GO
CREATE FUNCTION FN_PB_NV_DEAN (@MAPB INT)
RETURNS @LISTPB TABLE (TENPHONG NVARCHAR(20), HOTENNV NVARCHAR(60),SLDUAN INT)
AS 
BEGIN
INSERT INTO @LISTPB
SELECT PHONGBAN.TENPHG, CONCAT(HONV,' ', TENLOT, ' ', TENNV), COUNT(MADA) 
FROM PHONGBAN INNER JOIN DEAN ON DEAN.PHONG=PHONGBAN.MAPHG 
INNER JOIN NHANVIEN ON NHANVIEN.PHG=PHONGBAN.MAPHG 
WHERE PHONGBAN.MAPHG=@MAPB
GROUP BY TENPHG, HONV, TENLOT, TENNV
RETURN
END
SELECT * FROM DBO.FN_PB_NV_DEAN('001');
GO


CREATE VIEW VW_DD_NV AS 
SELECT HONV,TENNV,TENPHG,DIADIEM FROM PHONGBAN
INNER JOIN DIADIEM_PHG ON DIADIEM_PHG.MAPHG=PHONGBAN.MAPHG
INNER JOIN NHANVIEN ON NHANVIEN.PHG=PHONGBAN.MAPHG
SELECT * FROM VW_DD_NV
GO

CREATE VIEW VW_TUOI_NV AS 
SELECT TENNV,LUONG,YEAR (GETDATE())-YEAR(NGSINH) AS 'TUỔI' FROM NHANVIEN
SELECT * FROM VW_TUOI_NV
GO

IF OBJECT_ID('VW_PB') IS NOT NULL
DROP FUNCTION VW_PB
GO
CREATE VIEW VW_PB(TENPHONGBAN,HOTENTP,SLNV)
AS
SELECT  TENPHG, COUNT(NV.MANV),CONCAT(TP.HONV,'',TP.TENLOT, '',TP.TENNV)
FROM NHANVIEN AS NV INNER JOIN PHONGBAN  ON PHONGBAN.MAPHG=NV.PHG
INNER JOIN NHANVIEN AS TP ON TP.MANV=PHONGBAN.TRPHG
GROUP BY TENPHG,TP.TENNV,TP.HONV,TP.TENLOT
ORDER BY COUNT (NV.MANV) DESC
SELECT * FROM PHONGBAN 
SELECT * FROM NHANVIEN

SELECT * FROM VW_PB