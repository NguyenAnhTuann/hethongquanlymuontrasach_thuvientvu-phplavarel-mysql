CREATE DATABASE muontrasach_thuvientvu;
USE muontrasach_thuvientvu;

-- Bảng thủ thư
CREATE TABLE thuthu (
    mathuthu int AUTO_INCREMENT primary key,
    username varchar(100),
    password varchar(50),
    hotenthuthu varchar(100),
    sodienthoai varchar(10)
);

-- Bảng độc giả
CREATE TABLE docgia (
    madocgia int AUTO_INCREMENT primary key,
    username varchar(100),
    password varchar(50),
    hoten varchar(100),
    gioitinh enum('Nam', 'Nữ'),
    ngaysinh date,
    sodienthoai varchar(10),
    anhdaidien blob
);

-- Bảng thể loại sách
CREATE TABLE loaisach (
    maloaisach int AUTO_INCREMENT primary key,
    tenloai varchar(100)
);

-- Bảng sách
CREATE TABLE sach (
    masach int AUTO_INCREMENT primary key,
    tensach varchar(255),
    tacgia varchar(100),
    nhaxuatban varchar(100),
    maloaisach int,
    mota text,
    anhsach blob,
    sotrang int,
    soluong int,
    trangthai tinyint(1),
    FOREIGN KEY (maloaisach) REFERENCES loaisach(maloaisach)
);

-- Bảng yêu cầu mượn sách
CREATE TABLE yeucaumuonsach (
    mayeucaumuon int AUTO_INCREMENT primary key,
    mathuthu int,
    madocgia int,
    masach int,
    ngayyeucaumuon date,
    trangthaixuly enum('Chờ xử lý', 'Đã phê duyệt', 'Từ chối'),
    FOREIGN KEY (mathuthu) REFERENCES thuthu(mathuthu),
    FOREIGN KEY (madocgia) REFERENCES docgia(madocgia),
    FOREIGN KEY (masach) REFERENCES sach(masach)
);

-- Bảng lịch sử mượn sách
CREATE TABLE lichsumuonsach (
    mamuon int AUTO_INCREMENT primary key,
    mathuthu int,
    madocgia int,
    masach int,
    ngaymuon date,
    ngaytra date,
    hantrasach date,
    chuahethan tinyint(1) default 0,
    phiphat decimal(10, 2) default 0,
    trangthaisach enum('Bình thường', 'Hư hỏng', 'Mất sách'),
    FOREIGN KEY (mathuthu) REFERENCES thuthu(mathuthu),
    FOREIGN KEY (madocgia) REFERENCES docgia(madocgia),
    FOREIGN KEY (masach) REFERENCES sach(masach)

);

-- Bảng vi phạm
CREATE TABLE vipham (
    mavipham int AUTO_INCREMENT primary key,
    mamuon int,
    loaivipham enum('Trễ hạn', 'Hư hỏng', 'Mất sách'),
    phiphat decimal(10, 2) default 0,
    FOREIGN KEY (mamuon) REFERENCES lichsumuonsach(mamuon)
);

-- Bảng thống kê mượn sách
CREATE TABLE thongkemuonsach (
    mathongke int AUTO_INCREMENT primary key,
    ngaybatdauthongke date,
    ngayketthucthongke date,
    masach int,
    soluotmuon int default 0,
    soluottra int default 0,
    FOREIGN KEY (masach) REFERENCES sach(masach)
);
