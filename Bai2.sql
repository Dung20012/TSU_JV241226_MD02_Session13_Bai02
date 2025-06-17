-- Thiết kế cơ sở dữ liệu

-- Tạo database
CREATE database library_management;
USE library_management; 

-- Bảng book
create table Book(
	bookId int auto_increment primary key,
    title varchar(100) NOT NULL UNIQUE,
    author varchar(50) NOT NULL,
    publishedYear YEAR NOT NULL,
    category varchar(50) NOT NULL
);

-- Bảng readers
create table Readers(
	readerId int auto_increment primary key,
    name varchar(50) NOT NULL,
    birthDate DATE NOT NULL,
    address varchar(255),
    phoneNumber varchar(11)
);

-- Năm sinh nhỏ hơn hiện tại
DELIMITER $$
create trigger check_birth_date_before_insert
before insert on Readers
for each row
begin
	if YEAR(new.birthDate) >= YEAR(CURDATE()) then
		signal sqlstate '45000'
        set message_text = 'Năm sinh phải nhỏ hơn năm hiện tại';
	end if;
end$$

-- Bảng borrows
create table Borrows(
	borrowId int auto_increment primary key,
    borrowDate DATE NOT NULL,
    returnDate DATE,
    bookId int,
    readerId int,
    FOREIGN KEY(bookId) REFERENCES book(bookId),
    FOREIGN KEY(readerId) REFERENCES readers(readerId)
);
