--create database T23_10849;
create table PostGradUser
(
id int Primary Key identity,
email varchar(50), 
password varchar(20)
);

create table Admin
(
id int primary key,
foreign key (id) references PostGradUser on delete cascade on update cascade
);

create table GucianStudent
(
id int primary key,
foreign key (id) references PostGradUser on delete cascade on update cascade,
first_name varchar(20), 
last_name varchar(20), 
type bit,
faculty varchar(20),
address varchar(50),
GPA decimal(3,2) default null,
undergradID int default null
);

create table NonGucianStudent
(
id int primary key,
foreign key (id) references PostGradUser on delete cascade on update cascade,
first_name varchar(20), 
last_name varchar(20), 
type bit,
faculty varchar(20),
address varchar(50),
GPA decimal (3,2)
);

create table GUCStudentPhoneNumber
(
id int primary key,
foreign key (id) references GucianStudent on delete cascade on update cascade,
phone varchar(20) 
);

create table NonGUCStudentPhoneNumber
(
id int primary key, 
foreign key (id) references NonGucianStudent on delete cascade on update cascade,
phone varchar(20)
);

create table Course
(
id int primary key identity,
fees decimal,
creditHours int,
code varchar(10)
);

create table Supervisor
(
id int primary key,
foreign key (id) references PostGradUser on delete cascade on update cascade,
name varchar(20),
faculity varchar(20)
);

create table Payment
(
id int primary key identity,
amount decimal,
no_installments int,
fundPercentage decimal(3,2)
);

create table Thesis
(
serialNumber int primary key identity,
field varchar(20),
type varchar(20),
title varchar(50),
startDate date not null,
endDate date default null,
defenseDate datetime default null,
years as (ABS(Year(startDate)-Year(endDate))),
grade decimal(3,2),
payment_id int default null,
foreign key (payment_id) references Payment on delete cascade on update cascade,
noExtension int default 0
);

create table Publication
(
id int primary key identity,
title varchar (50),
date datetime,
place varchar(50),
accepted bit,
host varchar(50)
);

create table Examiner
(
id int primary key identity ,
foreign key (id) references PostGradUser,
name varchar (20),
fieldOfWork varchar (20),
isNational bit
);

create table Defense
(
serialNumber int,
date datetime,
location varchar (15),
grade decimal(3,2) default null,
Primary key (serialNumber,date),
foreign key (serialNumber) references Thesis on delete cascade on update cascade
);

create table GUCianProgressReport
(
sid int,
progressReportNo int identity,
progressReportDate date,
eval int, 
state int,
thesisSerialNumber int,
Sup_id int,
description varchar(200) default '',
Primary key (sid,progressReportNo),
foreign key (sid) references GucianStudent on delete cascade on update cascade,
foreign key (thesisSerialNumber) references Thesis on delete cascade on update cascade,
foreign key (Sup_id) references Supervisor
);

create table NonGUCianProgressReport
(
sid int,
progressReportNo int identity,
progressReportDate date,
eval int,
state int,
thesisSerialNumber int,
Sup_id int,
description varchar(200) default '',
Primary key (sid,progressReportNo),
foreign key (sid) references NonGucianStudent on delete cascade on update cascade,
foreign key (thesisSerialNumber) references Thesis on delete cascade on update cascade,
foreign key (Sup_id) references Supervisor
);

create table Installment
(
date date,
payment_id int,
amount decimal,
done bit,
primary key (date,payment_id),
foreign key (payment_id) references Payment
);

create table NonGucianStudentPayForCourse
(
sid int,
paymentNo int,
cid int,
Primary key (sid,paymentNo,cid),
foreign key (sid) references NonGucianStudent on delete cascade on update cascade,
foreign key (paymentNo) references Payment on delete cascade on update cascade,
foreign key (cid) references Course on delete cascade on update cascade
);

create table NonGucianStudentTakeCourse
(
sid int,
cid int,
grade decimal (3,2) default null,
primary key(sid,cid),
foreign key (sid) references NonGucianStudent on delete cascade on update cascade,
foreign key (cid) references Course on delete cascade on update cascade
);

create table GUCianStudentRegisterThesis
(
sid int,
Sup_id int,
serial_no int,
primary key(sid,Sup_id,serial_no),
foreign key (sid) references GucianStudent on delete cascade on update cascade,
foreign key (Sup_id) references Supervisor,
foreign key (serial_no) references Thesis on delete cascade on update cascade
);

create table NonGUCianStudentRegisterThesis
(
sid int,
Sup_id int,
serial_no int,
primary key(sid,Sup_id,serial_no),
foreign key (sid) references NonGucianStudent on delete cascade on update cascade,
foreign key (Sup_id) references Supervisor,
foreign key (serial_no) references Thesis on delete cascade on update cascade
);

create table ExaminerEvaluateDefense
(
date datetime,
serialNo int,
examinerId int,
comment varchar(300) default Null,
primary key (date,serialNo,examinerId),
foreign key (serialNo,date) references Defense on delete cascade on update cascade,
foreign key (examinerId) references Examiner
);

create table ThesisHasPublication
(
serialNo int,
pub_id int,
primary key(serialNo,pub_id),
foreign key (serialNo) references Thesis on delete cascade on update cascade,
foreign key (pub_id) references Publication on delete cascade on update cascade
);







