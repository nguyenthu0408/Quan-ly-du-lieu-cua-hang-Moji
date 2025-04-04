create database NguyenLeMinhThu_QLMH
go

use NguyenLeMinhThu_QLMH
go

--Tạo bảng - create table

create table tblMatHang
(
MaMH varchar(25) not null constraint PK_tblMatHang primary key,
TenMH nvarchar(90) not null,
LoaiHang nvarchar(50) not null,
DGMua money not null,
DGBan money null,
SLTon int not null,
TrangThai nvarchar(8) not null
)

create table tblNCC
(
MaNCC char(5) not null constraint PK_tblNCC primary key,
TenNCC nvarchar(50) not null,
DiaChiNCC nvarchar(100) not null,
SDTNCC char(10) not null,
EmailNCC varchar(100) null,
STK varchar(14) not null,
TenNH nvarchar(70) not null
)

create table tblNhanVien
(
MaNV char(5) not null constraint PK_tblNhanVien primary key,
HoNV nvarchar(15) not null,
TenNV nvarchar(6) not null,
NgaySinh datetime not null,
GioiTinh nvarchar(3) not null,
DiaChiNV nvarchar(70) not null,
SDTNV char(10) not null,
ChucVu nvarchar(10) null
)

create table tblKho
(
MaKho char(5) not null constraint PK_tblKho primary key,
TenKho nvarchar(18) not null,
DiaChiKho nvarchar(70) not null
)

create table tblDonDatHang
(
MaDH char(10) not null constraint PK_tblDonDatHang primary key,
NgayDat datetime not null,
NgayGiao datetime not null,
DiaChiGiao nvarchar(70) not null,
PTTT nvarchar(15) not null,
TinhTrang nvarchar(10) not null,
MaNCC char(5) not null constraint FK_tblDonDatHang_MaNCC foreign key (MaNCC) references tblNCC(MaNCC),
MaKho char(5) not null constraint FK_tblDonDatHang_MaKho foreign key (MaKho) references tblKho(MaKho),
MaNV char(5) not null constraint FK_tblDonDatHang_MaNV foreign key (MaNV) references tblNhanVien(MaNV)
)

create table tblCTDH
(
MaMH varchar(25) not null constraint FK_tblCTDH_MaMH foreign key (MaMH) references tblMatHang(MaMH),
MaDH char(10) not null constraint FK_tblCTDH_MaDH foreign key (MaDH) references tblDonDatHang(MaDH),
SLDat int not null,
GiaMua money not null,
ChietKhau float null,
PhiGiaoHang money null,
constraint PK_tblCTDH primary key(MaMH, MaDH)
)

create table tblHoaDon
(
MaHD char(10) not null constraint PK_tblHoaDon primary key,
NgayLap datetime not null,
TienHang money not null,
ChietKhau float null,
PhiGiaoHang money null,
NgayThanhToan datetime not null,
PTTT nvarchar(15) not null,
MaDH char(10) not null constraint FK_tblHoaDon_MaDH foreign key (MaDH) references tblDonDatHang(MaDH),
MaNCC char(5) not null constraint FK_tblHoaDon_MaNCC foreign key (MaNCC) references tblNCC(MaNCC),
MaNV char(5) not null constraint FK_tblHoaDon_MaNV foreign key (MaNV) references tblNhanVien(MaNV)
)

create table tblCungCap
(
MaMH varchar(25) not null constraint FK_tblCungCap_MaMH foreign key (MaMH) references tblMatHang(MaMH),
MaNCC char(5) not null constraint FK_tblCungCap_MaNCC foreign key (MaNCC) references tblNCC(MaNCC),
ChietKhau float null,
GiaBan money not null,
PhiGiaoHang money null,
constraint PK_tblCungCap primary key(MaMH, MaNCC)
)

--Ràng buộc - alter

--Ràng buộc miền giá trị: 
--Số lượng tồn phải là số không âm
alter table tblMatHang
add constraint Check_SoLuongTon check (SLTon >= 0)

--Số lượng đặt hàng phải là số lớn hơn 0
alter table tblCTDH
add constraint Check_SoLuongDat check(SLDat >0)

--PTTT chỉ được nhập những giá trị cho phép
alter table tblDonDatHang
add constraint Check_PTTT check (PTTT in (N'Chuyển khoản', N'Tiền mặt'))

alter table tblHoaDon
add constraint Check_PTTTHD check (PTTT in (N'Chuyển khoản',N'Tiền mặt'))

--Tình trạng mặt hàng chỉ được nhập những giá trị cho phép
alter table tblMatHang
add constraint Check_TrangThai check (TrangThai in (N'Còn hàng', N'Hết hàng'))

--Tình trạng đơn đặt hàng chỉ được nhập những giá trị cho phép
alter table tblDonDatHang
add constraint Check_TinhTrangDon check (TinhTrang in (N'Chờ xử lý', N'Đã xử lý', N'Đang giao', N'Hoàn thành', N'Đã hủy'))

--Giới tính chỉ được nhập những giá trị cho phép
alter table tblNhanVien
add constraint Check_GioiTinh check (GioiTinh in(N'Nam', N'Nữ'))

--Ràng buộc liên thuộc tính:
--Ngày giao phải sau hoặc bằng ngày đặt
alter table tblDonDatHang
add constraint Check_NgayGiao check (NgayGiao >= NgayDat)

--Nhập liệu - insert into

insert into tblMatHang values ('M.A304.NO.24082425', N'Ốp điện thoại Baby bear bow nơ chấm tròn', N'Ốp điện thoại', 20000, 40000, 500, N'Còn hàng')
insert into tblMatHang values ('M.A304.NO.24082424', N'Ốp điện thoại Bow nơ ruy băng', N'Ốp điện thoại', 30000, 70000, 600, N'Còn hàng')
insert into tblMatHang values ('M.A304.NO.24084382', N'Ốp điện thoại Shinchan happy day activities', N'Ốp điện thoại', 25000, 50000, 700, N'Còn hàng')
insert into tblMatHang values ('M.A304.NO.24084057', N'Ốp điện thoại Capybara fruit food đeo kính', N'Ốp điện thoại', 20000, 50000, 750, N'Còn hàng')
insert into tblMatHang values ('M.A304.NO.24082081', N'Ốp điện thoại Capybara happy day', N'Ốp điện thoại', 20000, 50000, 700, N'Còn hàng')
insert into tblMatHang values ('M.C600.NO.24074512', N'Móc khóa nhồi bông Stitch ngồi phối màu', N'Móc khóa', 30000, 65000, 0, N'Hết hàng')
insert into tblMatHang values ('M.C600.NO.24072455', N'Móc khóa nhồi bông Capybara hồng chảy nước mũi dây kéo co giãn', N'Móc khóa', 35000, 75000, 0, N'Hết hàng')
insert into tblMatHang values ('M.C600.NO.24074511-XX', N'Móc khóa nhồi bông Sanrio family Kuromi váy kẻ ô - Mix', N'Móc khóa', 35000, 75000, 0, N'Hết hàng')
insert into tblMatHang values ('M.C600.NO.24082505', N'Móc khóa nhồi bông unoff Crybaby váy xếp ly', N'Móc khóa', 30000, 70000, 500, N'Còn hàng')
insert into tblMatHang values ('M.C600.NO.24092018', N'Móc khóa nhồi bông Cute dog rabbit lái xe fruit rút dây cót có tiếng', N'Móc khóa', 50000, 190000, 300, N'Còn hàng')
insert into tblMatHang values ('M.F200.NO.24074591-XX', N'Balo gấu bông Penguin chim cánh cụt giữ ấm tai 10x29x38 - Mix', N'Ba lô', 60000, 190000, 350, N'Còn hàng')
insert into tblMatHang values ('M.F200.NO.24074590-XX', N'Balo gấu bông Cute dog puppy má hồng có tai phối 2 màu 12x30x38 - Mix', N'Ba lô', 60000, 190000, 340, N'Còn hàng')
insert into tblMatHang values ('M.F200.NO.24074410-XX', N'Balo vải Sanrio family Pochacco sunny day good lucky 20x29x44 - Mix', N'Ba lô', 80000, 250000, 342, N'Còn hàng')
insert into tblMatHang values ('M.F200.NO.24072141', N'Balo vải Baby bear face hello phối caro có chân 12x25x35', N'Ba lô', 85000, 270000, 348, N'Còn hàng')
insert into tblMatHang values ('M.F200.NO.24074120-BU', N'Balo vải Rabbit thỏ tai dài má hồng 18x29x44 - Xanh da trời', N'Ba lô', 100000, 330000, 250, N'Còn hàng')
insert into tblMatHang values ('M.C401.NO.24096002', N'Hoa kẽm nhung bó mini Basic flower 6 bông 20cm', N'Hoa', 20000, 60000, 200, N'Còn hàng')
insert into tblMatHang values ('M.C401.NO.24084261-BU', N'Hoa móc len bó Love phối màu 5 bông kèm túi 30cm - Xanh da trời', N'Hoa', 80000, 190000, 185, N'Còn hàng')
insert into tblMatHang values ('M.C401.NO.24082386', N'Hoa sáp lẻ Tulip flower happiness belongs to you 42cm', N'Hoa', 10000, 40000, 250, N'Còn hàng')
insert into tblMatHang values ('M.C401.NO.23084672', N'Hoa móc len bó Basic flower Just for you 5 bông kèm túi 23cm', N'Hoa', 50000, 130000, 0, N'Hết hàng')
insert into tblMatHang values ('M.C401.NO.24076013-XX', N'Hoa móc len lẻ Cute duck vịt vàng đội mũ hình ếch 30cm - Mix', N'Hoa', 15000, 70000, 180, N'Còn hàng')
insert into tblMatHang values ('M.C102.NO.24082249-XX', N'Hộp bút lớn lông xù Capybara face biểu cảm có tai 7x10x21 - Mix', N'Hộp bút', 30000, 100000, 188, N'Còn hàng')
insert into tblMatHang values ('M.C102.NO.24084023-GR', N'Hộp bút MJ gấu bông Cute cat big eyes 16x20 - Xám', N'Hộp bút', 40000, 95000, 400, N'Còn hàng')
insert into tblMatHang values ('M.C102.NO.24074442', N'Hộp bút lớn Sanrio family Hello Kitty face bow nơ có tai 8x17', N'Hộp bút', 30000, 9000, 450, N'Còn hàng')
insert into tblMatHang values ('M.C102.NO.24072109-BR', N'Hộp bút lớn lông xù Capybara face má béo có tai 4x10x18 - Nâu', N'Hộp bút', 50000, 100000, 350, N'Còn hàng')
insert into tblMatHang values ('M.C102.NO.24064364-XX', N'Hộp bút lớn lông xù Capybara be funny vibes có tóc 14x21 - Mix', N'Hộp bút', 30000, 90000, 245, N'Còn hàng')
insert into tblMatHang values ('M.I800.NO.24064311-XX', N'Bộ tinh dầu khuếch tán Rose flower lọ dáng tròn with orange 100ml - Mix', N'Nến thơm', 60000, 130000, 145, N'Còn hàng')
insert into tblMatHang values ('M.I200.NO.24016021-XX', N'Nến thơm hũ MZ Irregular straight line with Typa girl 150g 7x7 - Mix', N'Nến thơm', 80000, 180000, 155, N'Còn hàng')
insert into tblMatHang values ('M.I200.NO.24012405', N'Nến thơm hũ Heart fruit strawberry 3x7x7', N'Nến thơm', 40000, 100000, 555, N'Còn hàng')
insert into tblMatHang values ('M.I200.NO.24012414-XX', N'Nến thơm hũ Rabbit bunny sweet life painting world with rose 6x8 - Mix', N'Nến thơm', 70000, 140000, 237, N'Còn hàng')
insert into tblMatHang values ('M.I200.NO.24012383', N'Nến thơm hũ Baby bear happy birthday 9x11', N'Nến thơm', 80000, 180000, 239, N'Còn hàng')
insert into tblMatHang values ('M.E101.NO.24094054-WH', N'Gấu bông MS Cute dog bow nơ đội mũ đeo kính 22cm - Trắng', N'Gấu bông', 70000, 130000, 231, N'Còn hàng')
insert into tblMatHang values ('M.E101.NO.24092043-BU', N'Gấu bông MJ Stitch basic ngồi 32cm - Xanh da trời', N'Gấu bông', 100000, 190000, 500, N'Còn hàng')
insert into tblMatHang values ('M.E101.NO.24092013-GN', N'Gấu bông MS Cute bee rau xanh 20cm - Xanh lá cây', N'Gấu bông', 40000, 90000, 420, N'Còn hàng')
insert into tblMatHang values ('M.E200.NO.24084125-BL', N'Gấu bông chữ U có mũ Sanrio family Kuromi happy face - Đen', N'Gối chữ U', 150000, 240000, 234, N'Còn hàng')
insert into tblMatHang values ('M.E200.NO.24082112-BU', N'Gấu bông chữ U ruột cao su Moster Sulley angry face - Xanh da trời', N'Gối chữ U', 100000, 170000, 348, N'Còn hàng')
insert into tblMatHang values ('M.A303.NO.24082514-XX', N'Dây đeo điện thoại Baby bear heart star khối vuông chuỗi hạt tròn - Mix', N'Dây đeo', 20000, 60000, 376, N'Còn hàng')
insert into tblMatHang values ('M.A303.NO.24084247-XX', N'Dây đeo điện thoại Powerpuff Girls khối vuông bow nơ heart star - Mix', N'Dây đeo', 20000, 60000, 326, N'Còn hàng')
insert into tblMatHang values ('M.A305.NO.24066320', N'Tai nghe IE túi đựng Eggplant Fruit Avocado Trái bơ má hồng', N'Phụ kiện điện thoại', 40000, 90000, 126, N'Còn hàng')
insert into tblMatHang values ('M.A305.NO.24074029-XX', N'Đựng tai nghe MJ vuông Capybara playing with friends dont talk 7x7 - Mix', N'Phụ kiện điện thoại', 5000, 30000, 396, N'Còn hàng')

insert into tblNCC values ('NC001', N'Shin Case', N'18 P.Bùi Quốc Khái, Hoàng Liệt, Hoàng Mai, Hà Nội','0854679999',null, '58100234567891', N'Ngân hàng TMCP Đầu tư và Phát triển Việt Nam (BIDV)')
insert into tblNCC values ('NC002', N'Ốp lưng và phụ kiện Awifi', N'11 Ng.242 Đ.Vạn Phúc, Hà Đông, Hà Nội','0978474034',null, '58100321456789', N'Ngân hàng TMCP Đầu tư và Phát triển Việt Nam (BIDV)')
insert into tblNCC values ('NC003', N'Ốp lưng điện thoại Happy Case', N'44 QL1A, Tam Phú, Thủ Đức, Hồ Chí Minh','0347880700',null, '34021001234567', N'Ngân hàng Nông nghiệp và Phát triển Nông thôn Việt Nam (Agribank)')
insert into tblNCC values ('NC004', N'Ốp lưng Iphone - Monster Case', N'182 Đ.Lê Đại Hành, P.15, Q.11, Hồ Chí Minh','0384402270',null, '34021009876543', N'Ngân hàng Nông nghiệp và Phát triển Nông thôn Việt Nam (Agribank)')
insert into tblNCC values ('NC005', N'Nhà sách Fahasa Tân Định', N'389 Hai Bà Trưng, P.8, Q.3, Hồ Chí Minh','0838208534','info@fahasa.com', '34058001234567', N'Ngân hàng Nông nghiệp và Phát triển Nông thôn Việt Nam (Agribank)')
insert into tblNCC values ('NC006', N'Nhà sách Hải An', N'2B Đ.Nguyễn Thị Minh Khai, Đa Kao, Q.1, Hồ Chí Minh','0822299261','hello@haianbook.vn', '0123456789012', N'Ngân hàng TMCP Ngoại thương Việt Nam (Vietcombank)')
insert into tblNCC values ('NC007', N'Tiệm đồ xinh', N'170 Đ.Mỹ Đình, Mỹ Đình, Nam Từ Liêm, Hà Nội','0919805089',null, '0123456123789', N'Ngân hàng TMCP Ngoại thương Việt Nam (Vietcombank)')
insert into tblNCC values ('NC008', N'Phương Võ Accessories', N'150/14 Đ.Trần Bá Giao, P.5, Q.Gò Vấp, Hồ Chí Minh','0792138238',null, '0123654321098', N'Ngân hàng TMCP Ngoại thương Việt Nam (Vietcombank)')
insert into tblNCC values ('NC009', N'Gấu bông ADA', N'24E, Đ.Bình Đông, P.14, Q.8, Hồ Chí Minh','0968575733',null, '10712345678901', N'Ngân hàng TMCP Công Thương Việt Nam (VietinBank)')
insert into tblNCC values ('NC010', N'Sở thú gấu bông', N'1146 Đ.Cách Mạng Tháng 8, P.4, Q.Tân Bình, Hồ Chí Minh','0908888964',null, '10719876543210', N'Ngân hàng TMCP Công Thương Việt Nam (VietinBank)')
insert into tblNCC values ('NC011', N'Sỉ gấu bông Dĩ An Bình Dương', N'8/1 Cao Bá Quát, Khu phố Đông Tân, Dĩ An, Bình Dương','0933773052',null, '10715678123490', N'Ngân hàng TMCP Công Thương Việt Nam (VietinBank)')
insert into tblNCC values ('NC012', N'Tiệm hoa kẽm nhung handmade', N'405/13, Đ.Trường Chinh, P.14, Q.Tân Bình, Hồ Chí Minh','0813728403',null, '10713456789012', N'Ngân hàng TMCP Công Thương Việt Nam (VietinBank)')
insert into tblNCC values ('NC013', N'Da Flora - Hoa kẽm nhung', N'Ấp Tân Thới 2, Hóc Môn, Hồ Chí Minh','0586355025',null, '10717654321098', N'Ngân hàng TMCP Công Thương Việt Nam (VietinBank)')
insert into tblNCC values ('NC014', N'ORSE Studio', N'200/202 Đ.Nguyễn Cư Trinh, P.Nguyễn Cư Trinh, Q.1, Hồ Chí Minh','0823453153',null, '10718901234567', N'Ngân hàng TMCP Công Thương Việt Nam (VietinBank)')
insert into tblNCC values ('NC015', N'Nhà sách Tiến Thọ', N'828 Đ.Láng, Láng Thượng, Đống Đa, Hà Nội','0941234828','marketingnhasachtientho@gmail.com', '1234567890123', N'Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)')
insert into tblNCC values ('NC016', N'Nhà sách Tiền Phong Thủy Lợi', N'175 P.Tây Sơn, Trung Liệt, Đống Đa, Hà Nội','0243537295',null, '1234098765432', N'Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)')
insert into tblNCC values ('NC017', N'Gấu bông Teddy', N'388 P.Xã Đàn, Nam Đồng, Đống Đa, Hà Nội','0962222346',null, '1234321654987', N'Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)')
insert into tblNCC values ('NC018', N'Ngôi nhà gấu bông', N'158 P.Tây Sơn, Quang Trung, Đống Đa, Hà Nội','0967178818',null, '1234567890456', N'Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)')
insert into tblNCC values ('NC019', N'Xưởng sản xuất gấu bông Memon', N'Tân Triều, Thanh Trì, Hà Nội','0397976616',null, '1234987654321', N'Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)')
insert into tblNCC values ('NC020', N'Xumi Shop', N'114 Ng.1194 Đ.Láng, Láng Thượng, Đống Đa, Hà Nội','0868607551',null, '1234111222333', N'Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)')
insert into tblNCC values ('NC021', N'Tất Hàn Quốc Store', N'4 Ng.207 Xôm Câu - Triều Khúc, Tân Triều, Thanh Trì, Hà nội','0948679708',null, '1423456789012', N'Ngân hàng TMCP Sài Gòn Thương Tín (Sacombank)')

insert into tblNhanVien values ('NV001', N'Nguyễn Văn', N'An', '2000-03-12',N'Nam',N'123 Đ.Nam Kỳ Khởi Nghĩa, P.1, Q.1, Hồ Chí Minh','0901234567',N'Nhân viên')
insert into tblNhanVien values ('NV002', N'Lê Mai', N'Bình', '2004-08-03',N'Nữ',N'123 Đ.Nguyễn Thị Định, P.Bình Trung, Q.2, Hồ Chí Minh','0919012345',N'Nhân viên')
insert into tblNhanVien values ('NV003', N'Trương Quốc', N'Duy', '2003-04-03',N'Nam',N'135 Đ.Phạm Thế Hiển, P.5, Q.8, Hồ Chí Minh','0907890123',N'Nhân viên')
insert into tblNhanVien values ('NV004', N'Lý Hữu', N'Nghĩa', '2003-05-09',N'Nam',N'369 Đ.3/2, P.12, Q.10, Hồ Chí Minh','0909012345',N'Nhân viên')
insert into tblNhanVien values ('NV005', N'Nguyễn Thị', N'Hòa', '1999-03-09',N'Nữ',N'987 Đ.Nguyễn Thị Thập, P.Tân Phú, Q.7, Hồ Chí Minh','0906789012',N'Quản lý')
insert into tblNhanVien values ('NV006', N'Hồ Hoài', N'Thương', '2000-05-23',N'Nữ',N'789 Đ.Đội Cấn, Q.Ba Đình, Hà Nội','0913456789',N'Quản lý')
insert into tblNhanVien values ('NV007', N'Đỗ Hữu', N'Nghĩa', '2001-05-26',N'Nam',N'321 Đ.Thanh Niên, Q.Tây Hồ, Hà Nội','0914567890',N'Nhân viên')
insert into tblNhanVien values ('NV008', N'Lê Minh', N'Tuấn', '2001-06-27',N'Nam',N'987 Đ.Láng Hạ, Q.Đống Đa, Hà Nội','0916789012',N'Nhân viên')
insert into tblNhanVien values ('NV009', N'Phạm Văn', N'Kiên', '2002-05-21',N'Nam',N'246 Đ.Phan Chu Trinh, Q.Hoàn Kiếm, Hà Nội','0918901234',N'Nhân viên')
insert into tblNhanVien values ('NV010', N'Nguyễn Thị', N'Mỹ', '2004-06-28',N'Nữ',N'123 Đ.Kim Mã, Q.Ba Đình, Hà Nội','0911234567',N'Nhân viên')

insert into tblKho values ('KH001', N'Bà Triệu', N'81 Bà Triệu, Hai Bà Trưng, Hà Nội')
insert into tblKho values ('KH002', N'Chùa Bộc', N'241 Chùa Bộc, Đống Đa, Hà Nội')
insert into tblKho values ('KH003', N'Trần Đại Nghĩa', N'60 Trần Đại Nghĩa, Hai Bà Trưng, Hà Nội')
insert into tblKho values ('KH004', N'Nguyễn Trãi', N'226 Nguyễn Trãi, Nam Từ Liêm, Hà Nội')
insert into tblKho values ('KH005', N'Xuân Thủy', N'157 Xuân Thủy, Cầu Giấy, Hà Nội')
insert into tblKho values ('KH006', N'Hồ Tùng Mậu', N'92 Hồ Tùng Mậu, P.Bến Nghé, Q1, Hồ Chí Minh')
insert into tblKho values ('KH007', N'Nguyễn Đình Chiểu', N'459E Nguyễn Đình Chiểu, P.5, Q.3, Hồ Chí Minh')
insert into tblKho values ('KH008', N'Sư Vạn Hạnh', N'708 Sư Vạn Hạnh, P.12, Q.10, Hồ Chí Minh')
insert into tblKho values ('KH009', N'Bàu Cát', N'87 Bàu Cát, P.14, Q.Tân Bình, Hồ Chí Minh')
insert into tblKho values ('KH010', N'Phan Xích Long', N'232 Phan Xích Long, P.7, Q.Phú Nhuận, Hồ Chí Minh')

insert into tblDonDatHang values ('OD-24-0001','2024-01-01','2024-01-03',N'232 Phan Xích Long, P.7, Q.Phú Nhuận, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC001','KH010','NV005')
insert into tblDonDatHang values ('OD-24-0002','2024-01-01','2024-01-03',N'87 Bàu Cát, P.14, Q.Tân Bình, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC001','KH009','NV005')
insert into tblDonDatHang values ('OD-24-0003','2024-01-01','2024-01-03',N'459E Nguyễn Đình Chiểu, P.5, Q.3, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC001','KH007','NV005')
insert into tblDonDatHang values ('OD-24-0004','2024-01-02','2024-01-05',N'81 Bà Triệu, Hai Bà Trưng, Hà Nội', N'Tiền mặt',N'Hoàn thành','NC001','KH001','NV006')
insert into tblDonDatHang values ('OD-24-0005','2024-02-05','2024-02-07',N'60 Trần Đại Nghĩa, Hai Bà Trưng, Hà Nội', N'Chuyển khoản',N'Hoàn thành','NC001','KH003','NV006')
insert into tblDonDatHang values ('OD-24-0006','2024-02-06','2024-02-08',N'708 Sư Vạn Hạnh, P.12, Q.10, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC010','KH008','NV005')
insert into tblDonDatHang values ('OD-24-0007','2024-02-06','2024-02-08',N'459E Nguyễn Đình Chiểu, P.5, Q.3, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC010','KH007','NV005')
insert into tblDonDatHang values ('OD-24-0008','2024-03-01','2024-03-05',N'459E Nguyễn Đình Chiểu, P.5, Q.3, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC010','KH007','NV005')
insert into tblDonDatHang values ('OD-24-0009','2024-03-01','2024-03-05',N'459E Nguyễn Đình Chiểu, P.5, Q.3, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC013','KH007','NV005')
insert into tblDonDatHang values ('OD-24-0010','2024-03-01','2024-03-05',N'92 Hồ Tùng Mậu, P.Bến Nghé, Q1, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC013','KH006','NV005')
insert into tblDonDatHang values ('OD-24-0011','2024-03-01','2024-03-05',N'241 Chùa Bộc, Đống Đa, Hà Nội', N'Tiền mặt',N'Hoàn thành','NC013','KH002','NV006')
insert into tblDonDatHang values ('OD-24-0012','2024-04-05','2024-04-07',N'60 Trần Đại Nghĩa, Hai Bà Trưng, Hà Nội', N'Tiền mặt',N'Hoàn thành','NC013','KH003','NV006')
insert into tblDonDatHang values ('OD-24-0013','2024-04-05','2024-04-07',N'92 Hồ Tùng Mậu, P.Bến Nghé, Q1, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC013','KH006','NV005')
insert into tblDonDatHang values ('OD-24-0014','2024-05-17','2024-05-20',N'232 Phan Xích Long, P.7, Q.Phú Nhuận, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC005','KH010','NV005')
insert into tblDonDatHang values ('OD-24-0015','2024-05-17','2024-05-20',N'459E Nguyễn Đình Chiểu, P.5, Q.3, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC005','KH007','NV005')
insert into tblDonDatHang values ('OD-24-0016','2024-05-17','2024-05-20',N'92 Hồ Tùng Mậu, P.Bến Nghé, Q1, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC005','KH006','NV005')
insert into tblDonDatHang values ('OD-24-0017','2024-06-20','2024-06-22',N'226 Nguyễn Trãi, Nam Từ Liêm, Hà Nội', N'Chuyển khoản',N'Hoàn thành','NC015','KH004','NV006')
insert into tblDonDatHang values ('OD-24-0018','2024-06-20','2024-06-22',N'157 Xuân Thủy, Cầu Giấy, Hà Nội', N'Chuyển khoản',N'Hoàn thành','NC015','KH005','NV006')
insert into tblDonDatHang values ('OD-24-0019','2024-07-01','2024-07-04',N'241 Chùa Bộc, Đống Đa, Hà Nội', N'Chuyển khoản',N'Hoàn thành','NC015','KH002','NV006')
insert into tblDonDatHang values ('OD-24-0020','2024-07-01','2024-07-04',N'232 Phan Xích Long, P.7, Q.Phú Nhuận, Hồ Chí Minh', N'Tiền mặt',N'Hoàn thành','NC015','KH010','NV005')
insert into tblDonDatHang values ('OD-24-0021','2024-08-03','2024-08-05',N'232 Phan Xích Long, P.7, Q.Phú Nhuận, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC008','KH010','NV005')
insert into tblDonDatHang values ('OD-24-0022','2024-08-03','2024-08-05',N'92 Hồ Tùng Mậu, P.Bến Nghé, Q1, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC008','KH006','NV005')
insert into tblDonDatHang values ('OD-24-0023','2024-08-03','2024-08-05',N'459E Nguyễn Đình Chiểu, P.5, Q.3, Hồ Chí Minh', N'Chuyển khoản',N'Hoàn thành','NC008','KH007','NV005')
insert into tblDonDatHang values ('OD-24-0024','2024-09-12','2024-09-15',N'81 Bà Triệu, Hai Bà Trưng, Hà Nội', N'Chuyển khoản',N'Hoàn thành','NC018','KH001','NV006')
insert into tblDonDatHang values ('OD-24-0025','2024-09-25','2024-09-30',N'241 Chùa Bộc, Đống Đa, Hà Nội', N'Tiền mặt',N'Đang giao','NC005','KH002','NV006')



insert into tblCTDH values ('M.A304.NO.24082425','OD-24-0001',200, 20000, 0, 100000) 
insert into tblCTDH values ('M.A304.NO.24082425','OD-24-0002',100, 20000, 0, 100000) 
insert into tblCTDH values ('M.A304.NO.24082425','OD-24-0003',300, 20000, 0, 100000) 
insert into tblCTDH values ('M.A304.NO.24082425','OD-24-0004',200, 20000, 0, 100000) 
insert into tblCTDH values ('M.A304.NO.24082424','OD-24-0004',300, 30000, 0, 100000) 
insert into tblCTDH values ('M.A304.NO.24084057','OD-24-0004',300, 20000, 0, 100000) 
insert into tblCTDH values ('M.A304.NO.24082081','OD-24-0004',100, 20000, 0, 100000) 
insert into tblCTDH values ('M.A304.NO.24084382','OD-24-0005',200, 25000, 0, 100000) 
insert into tblCTDH values ('M.E101.NO.24094054-WH','OD-24-0006',100, 70000, 0, 0)
insert into tblCTDH values ('M.E101.NO.24094054-WH','OD-24-0007',100, 70000, 0, 0)
insert into tblCTDH values ('M.E200.NO.24082112-BU','OD-24-0008',100, 100000, 0, 0)
insert into tblCTDH values ('M.C401.NO.24096002','OD-24-0009',200, 20000, 0.05, 0)
insert into tblCTDH values ('M.C401.NO.24096002','OD-24-0010',200, 20000, 0.05, 0)
insert into tblCTDH values ('M.C401.NO.24096002','OD-24-0011',400, 20000, 0.05, 0)
insert into tblCTDH values ('M.C401.NO.23084672','OD-24-0012',200, 50000, 0.05, 0)
insert into tblCTDH values ('M.C401.NO.23084672','OD-24-0013',200, 50000, 0.05, 0)
insert into tblCTDH values ('M.C102.NO.24082249-XX','OD-24-0014',100, 30000, 0, 0)
insert into tblCTDH values ('M.C102.NO.24084023-GR','OD-24-0014',100, 40000, 0, 0)
insert into tblCTDH values ('M.C102.NO.24082249-XX','OD-24-0015',100, 30000, 0, 0)
insert into tblCTDH values ('M.C102.NO.24084023-GR','OD-24-0015',100, 40000, 0, 0)
insert into tblCTDH values ('M.C102.NO.24082249-XX','OD-24-0016',100, 30000, 0, 0)
insert into tblCTDH values ('M.C102.NO.24084023-GR','OD-24-0016',100, 40000, 0, 0)
insert into tblCTDH values ('M.F200.NO.24074590-XX','OD-24-0017',100, 60000, 0, 0)
insert into tblCTDH values ('M.F200.NO.24074590-XX','OD-24-0018',100, 60000, 0, 0)
insert into tblCTDH values ('M.F200.NO.24074590-XX','OD-24-0019',100, 60000, 0, 0)
insert into tblCTDH values ('M.F200.NO.24074590-XX','OD-24-0020',100, 60000, 0, 0)
insert into tblCTDH values ('M.C600.NO.24074511-XX','OD-24-0021',100, 35000, 0, 0)
insert into tblCTDH values ('M.C600.NO.24074511-XX','OD-24-0022',100, 35000, 0, 0)
insert into tblCTDH values ('M.C600.NO.24082505','OD-24-0023',50, 30000, 0, 0)
insert into tblCTDH values ('M.F200.NO.24074591-XX','OD-24-0023',100, 60000, 0, 0)
insert into tblCTDH values ('M.F200.NO.24072141','OD-24-0024',100, 85000, 0, 0)
insert into tblCTDH values ('M.C102.NO.24082249-XX','OD-24-0025',100, 30000, 0, 0)

insert into tblHoaDon values ('IV-24-0001','2024-01-03', 4000000, 0, 100000, '2024-01-03',N'Chuyển khoản','OD-24-0001','NC001', 'NV005')
insert into tblHoaDon values ('IV-24-0002','2024-01-03', 2000000, 0, 100000, '2024-01-03',N'Chuyển khoản','OD-24-0002','NC001', 'NV005')
insert into tblHoaDon values ('IV-24-0003','2024-01-03', 6000000, 0, 100000, '2024-01-03',N'Chuyển khoản','OD-24-0003','NC001','NV005')
insert into tblHoaDon values ('IV-24-0004','2024-01-05', 21000000, 0, 400000, '2024-01-05',N'Tiền mặt','OD-24-0004','NC001','NV006')
insert into tblHoaDon values ('IV-24-0005','2024-02-07', 5000000, 0, 100000, '2024-02-07',N'Chuyển khoản','OD-24-0005','NC001','NV006')
insert into tblHoaDon values ('IV-24-0006','2024-02-08', 7000000, 0, 0, '2024-02-08',N'Chuyển khoản','OD-24-0006','NC010','NV005')
insert into tblHoaDon values ('IV-24-0007','2024-02-08', 7000000, 0, 0, '2024-02-08',N'Chuyển khoản','OD-24-0007','NC010','NV005')
insert into tblHoaDon values ('IV-24-0008','2024-03-05', 10000000, 0, 0, '2024-03-05',N'Chuyển khoản','OD-24-0008','NC010','NV005')
insert into tblHoaDon values ('IV-24-0009','2024-03-05', 4000000, 200000, 0, '2024-03-05',N'Chuyển khoản','OD-24-0009','NC013','NV005')
insert into tblHoaDon values ('IV-24-0010','2024-03-05', 4000000, 200000, 0, '2024-03-05',N'Chuyển khoản','OD-24-0010','NC013','NV005')
insert into tblHoaDon values ('IV-24-0011','2024-03-05', 8000000, 400000, 0, '2024-03-05',N'Tiền mặt','OD-24-0011','NC013','NV006')
insert into tblHoaDon values ('IV-24-0012','2024-04-07', 10000000, 500000, 0, '2024-04-07',N'Tiền mặt','OD-24-0012','NC013','NV006')
insert into tblHoaDon values ('IV-24-0013','2024-04-07', 10000000, 500000, 0, '2024-04-07',N'Chuyển khoản','OD-24-0013','NC013','NV005')
insert into tblHoaDon values ('IV-24-0014','2024-05-20', 7000000, 0, 0, '2024-05-20',N'Chuyển khoản','OD-24-0014','NC005','NV005')
insert into tblHoaDon values ('IV-24-0015','2024-05-20', 7000000, 0, 0, '2024-05-20',N'Chuyển khoản','OD-24-0015','NC005','NV005')
insert into tblHoaDon values ('IV-24-0016','2024-05-20', 7000000, 0, 0, '2024-05-20',N'Chuyển khoản','OD-24-0016','NC005','NV005')
insert into tblHoaDon values ('IV-24-0017','2024-06-22', 6000000, 0, 0, '2024-06-22',N'Chuyển khoản','OD-24-0017','NC015','NV006')
insert into tblHoaDon values ('IV-24-0018','2024-06-22', 6000000, 0, 0, '2024-06-22',N'Chuyển khoản','OD-24-0018','NC015','NV006')
insert into tblHoaDon values ('IV-24-0019','2024-07-04', 6000000, 0, 0, '2024-07-04',N'Chuyển khoản','OD-24-0019','NC015','NV006')
insert into tblHoaDon values ('IV-24-0020','2024-07-04', 6000000, 0, 0, '2024-07-04',N'Tiền mặt','OD-24-0020','NC015','NV005')
insert into tblHoaDon values ('IV-24-0021','2024-08-05', 3500000, 0, 0, '2024-08-05',N'Chuyển khoản','OD-24-0021','NC008','NV005')
insert into tblHoaDon values ('IV-24-0022','2024-08-05', 3500000, 0, 0, '2024-08-05',N'Chuyển khoản','OD-24-0022','NC008','NV005')
insert into tblHoaDon values ('IV-24-0023','2024-08-05', 7500000, 0, 0, '2024-08-05',N'Chuyển khoản','OD-24-0023','NC008','NV005')
insert into tblHoaDon values ('IV-24-0024','2024-09-15', 8500000, 0, 0, '2024-09-15',N'Chuyển khoản','OD-24-0024','NC018','NV006')

insert into tblCungCap values ('M.A304.NO.24082425','NC001',0,20000,100000)
insert into tblCungCap values ('M.A304.NO.24082425','NC002',0,25000,120000)
insert into tblCungCap values ('M.A304.NO.24082424','NC001',0,30000,100000)
insert into tblCungCap values ('M.A304.NO.24082424','NC002',0,35000,120000)
insert into tblCungCap values ('M.A304.NO.24084057','NC001',0,20000,100000)
insert into tblCungCap values ('M.A304.NO.24084057','NC002',0,22000,120000)
insert into tblCungCap values ('M.A304.NO.24082081','NC001',0,20000,100000)
insert into tblCungCap values ('M.A304.NO.24082081','NC003',0,26000,100000)
insert into tblCungCap values ('M.A304.NO.24084382','NC001',0,25000,100000)
insert into tblCungCap values ('M.A304.NO.24084382','NC003',0,32000,100000)
insert into tblCungCap values ('M.E101.NO.24094054-WH','NC009',0,75000,0)
insert into tblCungCap values ('M.E101.NO.24094054-WH','NC010',0,70000,0)
insert into tblCungCap values ('M.E200.NO.24082112-BU','NC009',0,110000,0)
insert into tblCungCap values ('M.E200.NO.24082112-BU','NC010',0,100000,0)
insert into tblCungCap values ('M.C401.NO.24096002','NC012',0,25000, 0)
insert into tblCungCap values ('M.C401.NO.24096002','NC013',0.05,20000,0)
insert into tblCungCap values ('M.C401.NO.23084672','NC012',0,54000,0)
insert into tblCungCap values ('M.C401.NO.23084672','NC013',0.05,50000,0)
insert into tblCungCap values ('M.C102.NO.24082249-XX','NC005',0,30000,0)
insert into tblCungCap values ('M.C102.NO.24082249-XX','NC006',0,40000,0)
insert into tblCungCap values ('M.C102.NO.24084023-GR','NC005',0,40000,0)
insert into tblCungCap values ('M.C102.NO.24084023-GR','NC006',0,55000,0)
insert into tblCungCap values ('M.F200.NO.24074590-XX','NC015',0,60000,0)
insert into tblCungCap values ('M.F200.NO.24074590-XX','NC016',0,65000,0)
insert into tblCungCap values ('M.C600.NO.24074511-XX','NC008',0,35000,0)
insert into tblCungCap values ('M.C600.NO.24082505','NC008',0,30000,0)
insert into tblCungCap values ('M.F200.NO.24074591-XX','NC008',0,60000,0)
insert into tblCungCap values ('M.F200.NO.24072141','NC018',0,85000,0)
insert into tblCungCap values ('M.F200.NO.24072141','NC017',0,88000,0)




