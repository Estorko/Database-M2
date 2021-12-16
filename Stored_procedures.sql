--1.a_Register to the website by using my name (First and last name), password, faculty, email, and address
create proc StudentRegister 
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@Gucian bit,
@email varchar(50), 
@address varchar(50)
as
declare @Post_index int
declare @undergrad_id numeric
set @undergrad_id= CONVERT(NUMERIC(12,0),RAND() * 9999) + 10000 
insert into PostGradUser values (@email,@password)
set @Post_index= Scope_identity();
if @Gucian=1 insert into GucianStudent (id,first_name,last_name,type,faculty,address,undergradID) 
    values (@Post_index,@first_name,@last_name,@Gucian,@faculty,@address,@undergrad_id)
else insert into NonGucianStudent (id,first_name,last_name,type,faculty,address) 
    values (@Post_index,@first_name,@last_name,@Gucian,@faculty,@address)
go
--drop proc StudentRegister
--1.b_SupervisorRegister
create proc SupervisorRegister 
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@email varchar(50) 
as
declare @Post_index int
declare @name varchar(20)
insert into PostGradUser values (@email,@password)
set @Post_index= Scope_identity();
set @name= CONCAT(@first_name,' ',@last_name);
insert into Supervisor values (@Post_index,@name,@faculty)
go
--drop proc SupervisorRegister
--2.a_login using my username and password
create proc userLogin @id int, @password varchar(20)
as
declare @result bit
if exists(select * from PostGradUser where id=@id and password=@password)set @result=1 else set @result=0
print @result;
Go
--2.b_add my mobile number(s)
create proc addMobile
@ID int, 
@mobile_number varchar(20)
as
if(exists(select * from GucianStudent where id=@ID)) insert into GUCStudentPhoneNumber values (@ID,@mobile_number)
else insert into NonGUCStudentPhoneNumber values (@ID,@mobile_number)
go
--3.a List all supervisors in the system
create proc AdminListSup 
as
select * from Supervisor
go
--3.b view the profile of any supervisor that contains all his/her information
create proc AdminViewSupervisorProfile
@supId int
as
select s.id,s.name,p.email,s.faculity,p.password from Supervisor s 
inner join PostGradUser p on s.id=p.id where s.id=@supId
go
--drop proc AdminViewSupervisorProfile
--3.c List all Theses in the system
create proc AdminViewAllTheses
as
select * from Thesis
go
--3.d_List the number of on going theses.
create proc AdminViewOnGoingTheses
as
select COUNT(*)from Thesis where endDate is null;
go
--drop proc AdminViewOnGoingTheses
--3.e_List all supervisors’ names currently supervising students, theses title, student name
create proc AdminViewStudentThesisBySupervisor
as
select s.name as 'Supervisor Name',t.title as 'Thesis Title',st.first_name as 
'Student_First_Name',st.last_name as 'Student_Last_Name' from GUCianProgressReport gt 
inner join Thesis t on gt.thesisSerialNumber=t.serialNumber inner join GucianStudent st on
gt.sid=st.id inner join Supervisor s on s.id=gt.Sup_id
Union 
select s.name as 'Supervisor Name',t.title as 'Thesis Title',st.first_name as 
'Student_First_Name',st.last_name as 'Student_Last_Name' from NonGUCianProgressReport gt 
inner join Thesis t on gt.thesisSerialNumber=t.serialNumber inner join NonGucianStudent st on
gt.sid=st.id inner join Supervisor s on s.id=gt.Sup_id
go
--drop proc AdminViewStudentThesisBySupervisor
--3.f_List nonGucians names, course code, and respective grade.
create proc AdminListNonGucianCourse 
@courseID int
as
select st.name,c.code,tc.grade from 
