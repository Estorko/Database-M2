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
select st.first_name,c.code,tc.grade from Course c 
inner join NonGucianStudentTakeCourse tc on c.id=tc.cid inner join
NonGucianStudent st on tc.sid=st.id
where c.id=@courseID
go
--drop proc AdminListNonGucianCourse
--3.g_Update the number of thesis extension by 1
create proc AdminUpdateExtension
@ThesisSerialNo int
as
declare @old_no_Extension int
set @old_no_Extension=(select t.noExtension from Thesis t where t.serialNumber=@ThesisSerialNo)
update Thesis set noExtension=@old_no_Extension+1
go
--drop proc AdminUpdateExtension
--3.h_Issue a thesis payment
create proc AdminIssueThesisPayment
@ThesisSerialNo int, 
@amount decimal, 
@noOfInstallments int, 
@fundPercentage decimal
as
declare @p_index int
declare @noIns int set @noIns=@noOfInstallments
declare @date date set @date =CAST(GETDATE()AS Date)
insert into Payment values (@amount,@noOfInstallments,@fundPercentage)
set @p_index=SCOPE_IDENTITY();
while @noIns !=0 begin
if @noIns=@noOfInstallments
    insert into Installment values (@date,@p_index,@amount/@noOfInstallments,0)
else begin
    set @date=DATEADD(month,6,@date)
    insert into Installment values (@date,@p_index,@amount/@noOfInstallments,0)
    end
set @noIns-=1
end
if exists(select * from Thesis where serialNumber=@ThesisSerialNo)
Begin
update Thesis set payment_id=@p_index where serialNumber=@ThesisSerialNo
print 1
end
else print 0
go
--drop proc AdminIssueThesisPayment
--3.i_view the profile of any student that contains all his/her information
create proc AdminViewStudentProfile
@sid int
as
if exists(select * from GucianStudent where id=@sid)
select s.id,s.first_name,s.last_name,s.faculty,s.address,p.email,p.password,
s.GPA,s.undergradID from GucianStudent s inner join PostGradUser p on s.id=p.id
where p.id =@sid
else
select s.id,s.first_name,s.last_name,s.faculty,s.address,p.email,p.password,
s.GPA from NonGucianStudent s inner join PostGradUser p on s.id=p.id
go
--drop proc AdminViewStudentProfile
--3.k_List the title(s) of accepted publication(s) per thesis
CREATE PROC AdminListAcceptPublication as
SELECT T.title as 'Thesis Title', P.title as 'Accepted Publication(s)'
FROM ThesisHasPublication as TP
INNER JOIN Publication as P
ON P.id= TP.pub_id
INNER JOIN Thesis as T
ON T.serialNumber = TP.serialNo
where accepted=1
GO
