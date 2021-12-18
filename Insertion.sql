-- Users insertion
-- PostGradUser insertion
Set IDENTITY_INSERT PostGradUser ON
	--GucianStudent
insert into PostGradUser (id,email,password) values (1,'anthony@gmail.com','u8nN}B');
insert into PostGradUser (id,email,password) values (2,'ashraf@gmail.com','n6B~/J');
insert into PostGradUser (id,email,password) values (3,'malak@gmail.com','\2Lz$?');
insert into PostGradUser (id,email,password) values (4,'lara@gmail.com','[8]wPV');
insert into PostGradUser (id,email,password) values (5,'Omar@gmail.com','X4,$e{');
	--NonGucianStudent
insert into PostGradUser (id,email,password) values (6,'Mohamed@gmail.com','Y~dU4j');
insert into PostGradUser (id,email,password) values (7,'Fred@gmail.com','q#8XkF');
insert into PostGradUser (id,email,password) values (8,'Nour@gmail.com','kA8+Yc');
insert into PostGradUser (id,email,password) values (9,'Toby@gmail.com','3:XMzP');
insert into PostGradUser (id,email,password) values (10,'Jared@gmail.com',']aE7-,');
	--Admin
insert into PostGradUser (id,email,password) values (11,'Hossam@gmail.com','H5Zb:H');
insert into PostGradUser (id,email,password) values (12,'Slim@gmail.com','rSC4>>');
	--Supervisor
insert into PostGradUser (id,email,password) values (13,'Yara@gmail.com','$7S%y^');
insert into PostGradUser (id,email,password) values (14,'Lobna@gmail.com','}fL37*');
	--Examiner
insert into PostGradUser (id,email,password) values (15,'Mervat@gmail.com','$X8aJc');
insert into PostGradUser (id,email,password) values (16,'Omneya@gmail.com','aY;3S');
Set IDENTITY_INSERT PostGradUser OFF

--GucianStudent insertion
insert into GucianStudent (id,first_name,last_name,type,faculty,address,GPA,undergradID)values 
(1,'Anthony','Ibrahim',1,'Business informatics','Heliopolis',1.96,10849);
insert into GucianStudent (id,first_name,last_name,type,faculty,address,GPA,undergradID)values 
(2,'Ashraf','Ibrahim',1,'Management','Tagamo3',1.86,10578);
insert into GucianStudent (id,first_name,last_name,type,faculty,address,GPA,undergradID)values 
(3,'Malak','Ahmad',1,'Business informatics','Dokki',1.0,10308);
insert into GucianStudent (id,first_name,last_name,type,faculty,address,GPA,undergradID)values 
(4,'Lara','Guirguis',1,'Applied arts','Tagamo3',1.1,10608);
insert into GucianStudent (id,first_name,last_name,type,faculty,address,GPA,undergradID)values 
(5,'Omar','Ehab',1,'Business informatics','6th October',2.0,11905);
--GUCStudentPhoneNumber insertion
insert into GUCStudentPhoneNumber values (2,'+20 109 043 3634');
insert into GUCStudentPhoneNumber values (3,'+20 152 883 8134');
insert into GUCStudentPhoneNumber values (4,'+20 115 831 3347');
insert into GUCStudentPhoneNumber values (5,'+20 153 416 9418');
--GUCStudentPhoneNumber display
select * from GUCStudentPhoneNumber;
--NonGucianStudent insertion
insert into NonGucianStudent (id,first_name,last_name,type,faculty,address,GPA)values 
(6,'Mohamed','Gamal',0,'Business informatics','6th October',1.4);
insert into NonGucianStudent (id,first_name,last_name,type,faculty,address,GPA)values 
(7,'Fred','Thomson',0,'Business informatics','Nasr City',0.98);
insert into NonGucianStudent (id,first_name,last_name,type,faculty,address,GPA)values 
(8,'Nour','Ahmad',0,'Business informatics','Tagamo3',3.1);
insert into NonGucianStudent (id,first_name,last_name,type,faculty,address,GPA)values 
(9,'Toby','Toby',0,'Business informatics','Tagamo3',2.1);
insert into NonGucianStudent (id,first_name,last_name,type,faculty,address,GPA)values 
(10,'Jared','Rafael',0,'Architecture','Tagamo3',2.6);
-- NonGUCStudentPhoneNumber insertion
insert into NonGUCStudentPhoneNumber values (6,'+20 128 841 8874');
insert into NonGUCStudentPhoneNumber values (7,'+20 121 296 9708');
insert into NonGUCStudentPhoneNumber values (8,'+20 125 562 3096');
insert into NonGUCStudentPhoneNumber values (9,'+20 123 776 7062');
insert into NonGUCStudentPhoneNumber values (10,'+20 103 348 4137');
--NonGUCStudentPhoneNumber display
select * from NonGUCStudentPhoneNumber;

--Admin insertion
insert into Admin (id) values (11);
insert into Admin (id) values (12);

--Supervisor insertion
insert into Supervisor (id,name,faculity) values (13,'Yara','Business informatics');
insert into Supervisor (id,name,faculity) values (14,'Lobna','Architecture');

--Examiner insertion
set IDENTITY_INSERT Examiner ON 
insert into Examiner (id,name,fieldOfWork,isNational) values (15,'Mervat','Proffessor',1);
insert into Examiner (id,name,fieldOfWork,isNational) values (16,'Omneya','Teacher',0);
set IDENTITY_INSERT Examiner OFF 
--display tables
select * from PostGradUser;
select * from GucianStudent;
select * from NonGucianStudent;
select * from Admin;
select * from Supervisor;
select * from Examiner;
-------------------------------------------------------------------------------------
--Payment and installments insertion
--Thesis Payments and installments
insert into Payment values (500,3,0.4);
insert into Payment values (800,4,0.3);
insert into Payment values (400,2,0.7);
insert into Payment values (1000,3,0.5);
insert into Payment values (300,2,0.2);
insert into Payment values (300,1,0.1);
insert into Payment values (600,3,0.4);
insert into Payment values (1100,4,0.3);
insert into Payment values (3000,4,0.2);
--installments
--P_1
insert into Installment values ('8/11/2019',1,166.66,0);
insert into Installment values ('2020-02-11',1,166.66,0);
insert into Installment values ('2020-08-11',1,166.66,0);
--P_2
insert into Installment values ('8/6/2020',2,200,0);
insert into Installment values ('2021-02-06',2,200,0);
insert into Installment values ('2021-08-06',2,200,0);
insert into Installment values ('2022-02-06',2,200,0);
--P_3
insert into Installment values ('4/12/2021',3,200,1);
insert into Installment values ('2021-10-12',3,200,1);
--P_4
insert into Installment values ('4/4/2018',4,333.33,0);
insert into Installment values ('2018-10-04',4,333.33,0);
insert into Installment values ('2019-04-04',4,333.33,0);
--P_5
insert into Installment values ('8/11/2020',5,150,0);
insert into Installment values ('2021-02-11',5,150,0);
--P_6
insert into Installment values ('5/11/2019',6,300,0);
--P_7
insert into Installment values ('8/4/2015',7,200,1);
insert into Installment values ('2016-02-04',7,200,1);
insert into Installment values ('2016-08-04',7,200,1);
--P_8
insert into Installment values ('11/11/2019',8,275,0);
insert into Installment values ('2020-05-11',8,275,0);
insert into Installment values ('2020-11-11',8,275,0);
insert into Installment values ('2021-05-11',8,275,0);
-- Course payments
insert into Payment values (3000,0,0);
insert into Payment values (2000,0,0.2);
insert into Payment values (5000,0,0.4);
insert into Payment values (2000,0,0.2);
insert into Payment values (2500,0,0.5);
insert into Payment values (5000,2,0.4);
insert into Payment values (6000,4,0.2);
--(delete) DBCC CHECKIDENT ('Payment',Reseed,0); (to reset identity counter);
--display payment & installments
select * from Payment;
select * from Installment;
-------------------------------------------------------------------------------------
--	Thesis (8 Master & 8 PhD)
--	Masters
insert into Thesis (field,type,title,startDate,grade)values ('Biology','Master','Climate change','8/11/2019',1.8);
insert into Thesis (field,type,title,startDate,defenseDate,grade,payment_id) values ('Economics','Master','Equality','7/9/2015','2/9/2016',2.1,1);
insert into Thesis (field,type,title,startDate,endDate,grade,payment_id,noExtension)values('Business','Master','Stocks','8/1/2017','8/2/2020',1.0,2,2);
insert into Thesis (field,type,title,startDate,grade,payment_id) values ('Law','Master','Courts','4/10/2017',2.0,3);
insert into Thesis (field,type,title,startDate,defenseDate,grade,payment_id) values ('Economics','Master','Equilibrium point','7/9/2015','7/3/2015',1.8,4);
insert into Thesis (field,type,title,startDate,defenseDate,grade,payment_id) values ('Technology','Master','Internet of things','10/9/2016','12/12/2017',3.1,5);
insert into Thesis (field,type,title,startDate,grade)values ('Biology','Master','Astrobiology','8/5/2021',1.3);
insert into Thesis (field,type,title,startDate,defenseDate,grade)values ('Biology','Master','CRISPR and Genetic Engineering','9/7/2021','7/8/2021',1.0);
insert into Thesis (field,type,title,startDate,grade)values ('Biology','Master','Fona and Fora','9/7/2021',1.0);
-- Phd
insert into Thesis (field,type,title,startDate,defenseDate,grade,payment_id) values ('Business','PhD','Challenges of Small Enterprises','8/1/2011','9/22/2012',3.0,6);
insert into Thesis (field,type,title,startDate,grade,payment_id) values ('Business','PhD','Regulation of Workplace Diversity','3/1/2013',1.4,7);
insert into Thesis (field,type,title,startDate,grade,payment_id) values ('Business','PhD','Business Leadership','2/1/2017',1.1,8);
insert into Thesis (field,type,title,startDate,grade)values ('Architecture','PhD','Heritage museums','9/7/2020',1.6);
insert into Thesis (field,type,title,startDate,grade)values ('Architecture','PhD','Cinema and theatre architecture','10/4/2018',2.5);
insert into Thesis (field,type,title,startDate,grade)values ('Architecture','PhD','Skyscraper design','10/5/2011',2.3);
insert into Thesis (field,type,title,startDate,grade)values ('Architecture','PhD','Suburban homes for multifamily','1/6/2017',2.1);
insert into Thesis (field,type,title,startDate,grade)values ('Law','PhD','Criminal psychology','11/9/2013',1.9);
--Display thesis table
select * from Thesis;
-- GucianStudent Register Thesis tables
insert into GUCianStudentRegisterThesis values (1,13,1);
insert into GUCianStudentRegisterThesis values (2,13,2);
insert into GUCianStudentRegisterThesis values (3,14,3);
insert into GUCianStudentRegisterThesis values (4,14,4);
insert into GUCianStudentRegisterThesis values (5,13,5);
select * from GUCianStudentRegisterThesis;
-- NonGucianStudent Register Thesis tables	
insert into NonGUCianStudentRegisterThesis values (6,14,6);
insert into NonGUCianStudentRegisterThesis values (7,14,7);
insert into NonGUCianStudentRegisterThesis values (8,13,8);
insert into NonGUCianStudentRegisterThesis values (9,14,9);
insert into NonGUCianStudentRegisterThesis values (10,13,10);
select * from NonGUCianStudentRegisterThesis;
--Test(delete)select s.id,th.endDate,th.startDate,t.Sup_id,t.serial_no,th.grade from NonGucianStudent s inner join NonGUCianStudentRegisterThesis t 
--on s.id=t.sid inner join Thesis th on t.serial_no=th.serialNumber;
------------------------------------------------------------------------------------- 
--GUCianProgressReport insertion
insert into GUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (1,'11/11/2019',2,2,1,13);
insert into GUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (1,'12/11/2019',0,2,1,13);
insert into GUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (2,'1/8/2016',1,7,2,13);
insert into GUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (3,'4/6/2019',3,2,3,14);
insert into GUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (4,'6/7/2017',1,6,4,14);
insert into GUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (5,'5/2/2015',2,1,5,13);
select * from GUCianProgressReport;
--NonGUCianProgressReport insertion
insert into NonGUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (6,'11/11/2017',0,2,6,14);
insert into NonGUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (7,'1/8/2021',0,7,7,14);
insert into NonGUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (8,'4/6/2021',2,2,8,13);
insert into NonGUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (9,'9/12/2021',1,6,9,14);
insert into NonGUCianProgressReport (sid,progressReportDate,eval,state,thesisSerialNumber,Sup_id)values (10,'5/2/2012',3,1,10,13);
select * from NonGUCianProgressReport;
------------------------------------------------------------------------------------- 
-- Courses insertion
insert into Course values (3000,6,'CSEN-501');
insert into Course values (2000,4,'CSEN-507');
insert into Course values (5000,8,'CSEN-401');
insert into Course values (2000,4,'BINF-506');
insert into Course values (2500,4,'HROB-203');
--display course table 
select * from Course;
--NonGucianStudentTakeCourse insertion
insert into NonGucianStudentTakeCourse values (6,1,75);
insert into NonGucianStudentTakeCourse (sid,cid)values (7,1);
insert into NonGucianStudentTakeCourse values (8,2,70);
insert into NonGucianStudentTakeCourse values (9,3,75);
insert into NonGucianStudentTakeCourse values (9,4,45);
insert into NonGucianStudentTakeCourse values (9,1,45);
insert into NonGucianStudentTakeCourse values (10,1,90);
insert into NonGucianStudentTakeCourse values (10,3,51);
insert into NonGucianStudentTakeCourse values (10,2,80);
--display NonGucianStudentTakeCourse table
select * from NonGucianStudentTakeCourse;
--NonGucianStudentPayForCourse insertion
insert into NonGucianStudentPayForCourse values(6,9,1);
insert into NonGucianStudentPayForCourse values(8,10,2);
insert into NonGucianStudentPayForCourse values(9,11,3);
insert into NonGucianStudentPayForCourse values(9,12,4);
insert into NonGucianStudentPayForCourse values(10,13,1);
insert into NonGucianStudentPayForCourse values(10,14,3);
insert into NonGucianStudentPayForCourse values(10,15,2);
-- display NonGucianStudentPayForCourse table
select * from NonGucianStudentPayForCourse;
-- Test (delete): select s.first_name,c.code from NonGucianStudent s inner join NonGucianStudentTakeCourse t on 
--s.id=t.sid inner join Course c on t.cid=c.id;
-------------------------------------------------------------------------------------
-- Defenses and examiners insertion
insert into Defense (serialNumber,date,location) values (2,'2/9/2016','H15');
insert into Defense (serialNumber,date,location) values (5,'7/3/2015','H14');
insert into Defense (serialNumber,date,location) values (6,'12/12/2017','H1');
insert into Defense (serialNumber,date,location) values (8,'7/8/2021','H4');
insert into Defense (serialNumber,date,location) values (10,'9/22/2012','H18');
select * from Defense;
-- Examiners attending
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('2/9/2016',2,16);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('7/3/2015',5,15);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('7/3/2015',5,16);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('12/12/2017',6,15);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('12/12/2017',6,16);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('7/8/2021',8,15);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('7/8/2021',8,16);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('9/22/2012',10,15);
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values('9/22/2012',10,16);
select * from ExaminerEvaluateDefense;
-------------------------------------------------------------------------------------
--Publication insertion
Set IDENTITY_INSERT Publication ON
INSERT INTO Publication (id, title, date, place, accepted, host)
values(1, 'Adoption of Data Mining', '2018-5-8','Hilton Hotel', 1,'Cairo International Confrence')
INSERT INTO Publication (id, title, date, place, accepted, host)
values(2, 'Biology and Space', '2016-8-8','Radison Blue Hotel', 0,'Berlin International Confrence')
INSERT INTO Publication (id, title, date, place, accepted, host)
values(3, 'Modern Courts', '2017-6-12','Ritz Hotel', 1,'Riyadh International Confrence')
INSERT INTO Publication (id, title, date, place, accepted, host)
values(4, 'The Path to Equilibrium', '2020-2-4','Hayatt Hotel', 0,'Dubai International Confrence')
INSERT INTO Publication (id, title, date, place, accepted, host)
values(5, 'Portfolio Management','2017-2-12', 'Hilton Hotel', 1,'Cairo International Confrence')
Set IDENTITY_INSERT Publication OFF
--ThesisHasPublication insertion
INSERT INTO ThesisHasPublication (serialNo, pub_id)values(6,1)
INSERT INTO ThesisHasPublication (serialNo, pub_id)values(7,2)
INSERT INTO ThesisHasPublication (serialNo, pub_id)values(4,3)
INSERT INTO ThesisHasPublication (serialNo, pub_id)values(5,4)
INSERT INTO ThesisHasPublication (serialNo, pub_id)values(3,5)
select * from ThesisHasPublication



