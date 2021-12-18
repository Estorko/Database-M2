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
--3.a_List all supervisors in the system
create proc AdminListSup 
as
select * from Supervisor
go
--3.b_view the profile of any supervisor that contains all his/her information
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
--3.j_Issue installments as per the number of installments for a certain payment every six months starting from the entered date
create proc AdminIssueInstallPayment --(NOT DONE)
@paymentID int, 
@InstallStartDate date
as
declare @installments int
declare @temp int 
declare @amount int
set @installments=(SELECT no_installments FROM Payment P INNER JOIN Installment I
ON P.id=I.payment_id where payment_id=@paymentID)
set @temp = @installments
set @amount=(SELECT P.amount FROM Payment P
INNER JOIN Installment I ON P.id=I.payment_id where payment_id=@paymentID)
while @temp != 0
begin
     insert into Installment values (@InstallStartDate,@paymentID,@amount/@installments,0)
     set @InstallStartDate=DATEADD(month,6,@InstallStartDate)
     set @temp-=1
end
go
--drop proc AdminIssueInstallPayment
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
--3.l_Add courses and link courses to students
create proc AddCourse
@courseCode varchar(10), 
@creditHrs int, 
@fees decimal
as
insert into Course values(@fees,@creditHrs,@courseCode)
go
--linkCourseStudent
create proc linkCourseStudent
@courseID int, 
@studentID int
as
if exists(select * from NonGucianStudent where id=@studentID)
insert into NonGucianStudentTakeCourse (sid,cid) values (@studentID,@courseID)
else print 'Invalid Student ID'
go
--addStudentCourseGrade
create proc addStudentCourseGrade
@courseID int, 
@studentID int, 
@grade decimal
as
update NonGucianStudentTakeCourse set grade=@grade where 
cid=@courseID and sid=@studentID
go
--3.m_View examiners and supervisor(s) names attending a thesis defense taking place on a certain date
create proc ViewExamSupDefense
@defenseDate datetime
as
declare @serial_num int
set @serial_num= (select t.serialNumber from Thesis t where defenseDate=@defenseDate)
if exists(select * from GUCianStudentRegisterThesis where serial_no=@serial_num) begin
select ex.name as'Examiner Name',s.name as 'Supervisor Name' from Thesis t inner join 
ExaminerEvaluateDefense e on t.serialNumber=e.serialNo inner join Examiner ex on 
e.examinerId=ex.id inner join GUCianStudentRegisterThesis gt on t.serialNumber=gt.serial_no 
inner join Supervisor s on gt.Sup_id=s.id where defenseDate=@defenseDate 
end
else begin
select ex.name as'Examiner Name',s.name as 'Supervisor Name' from Thesis t inner join 
ExaminerEvaluateDefense e on t.serialNumber=e.serialNo inner join Examiner ex on e.examinerId=ex.id 
inner join NonGUCianStudentRegisterThesis gt on t.serialNumber=gt.serial_no inner join Supervisor s 
on gt.Sup_id=s.id where defenseDate=@defenseDate
end
go
--drop proc ViewExamSupDefense
--4.a_Evaluate a student’s progress report, and give evaluation value 0 to 3
create proc EvaluateProgressReport
@supervisorID int, 
@thesisSerialNo int, 
@progressReportNo int, 
@evaluation int
as
if @evaluation >3 or @evaluation<0
print 'Wrong evaluation: Must be a value from from 0-3'
else 
begin
if exists(select * from  GUCianProgressReport where thesisSerialNumber=@thesisSerialNo and
Sup_id=@supervisorID and progressReportNo=@progressReportNo) update GUCianProgressReport
set eval=@evaluation where thesisSerialNumber=@thesisSerialNo and Sup_id=@supervisorID and 
progressReportNo=@progressReportNo
else update NonGUCianProgressReport set eval=@evaluation where thesisSerialNumber=@thesisSerialNo and 
Sup_id=@supervisorID and progressReportNo=@progressReportNo
end
go
--4.b_View all my students’s names and years spent in the thesis
create proc ViewSupStudentsYears
@supervisorID int
as
select s.first_name as 'First Name',t.years as 'Years in Thesis' from GUCianStudentRegisterThesis gt inner join Supervisor sup on
gt.Sup_id=sup.id inner join GucianStudent s on gt.sid=s.id inner join Thesis t on 
gt.serial_no=t.serialNumber where gt.Sup_id=@supervisorID
Union
select s.first_name as 'First Name',t.years as 'Years in Thesis' from NonGUCianStudentRegisterThesis gt inner join Supervisor sup on
gt.Sup_id=sup.id inner join NonGucianStudent s on gt.sid=s.id inner join Thesis t on 
gt.serial_no=t.serialNumber where gt.Sup_id=@supervisorID
go
--drop proc ViewSupStudentsYears
--4.c_View my profile and update my personal information
create proc SupViewProfile
@supervisorID int
as
if exists(select * from Supervisor where id=@supervisorID)
select * from Supervisor where id=@supervisorID
else print 'Profile doesn''t exist'
go
--drop proc SupViewProfile
--4.d_View all publications of a student
create proc ViewAStudentPublications
@StudentID int
as
if exists(select * from GucianStudent where id=@StudentID)
select p.id,p.title,p.date,p.place,p.accepted,p.host from Publication p inner join ThesisHasPublication tp on p.id=tp.pub_id inner join
Thesis t on tp.serialNo=t.serialNumber inner join GUCianStudentRegisterThesis st on 
st.serial_no=t.serialNumber inner join GucianStudent s on s.id=st.sid where s.id=@StudentID
else
select p.id,p.title,p.date,p.place,p.accepted,p.host from Publication p inner join ThesisHasPublication tp on p.id=tp.pub_id inner join
Thesis t on tp.serialNo=t.serialNumber inner join NonGUCianStudentRegisterThesis st on 
st.serial_no=t.serialNumber inner join NonGucianStudent s on s.id=st.sid where s.id=@StudentID
go
--drop proc ViewAStudentPublications
--4.e_Add defense for a thesis, for nonGucian students all courses’ grades should be greater than 50 percent
create proc AddDefenseGucian --(not done)
@ThesisSerialNo int ,
@DefenseDate Datetime , 
@DefenseLocation varchar(15)
as
go
--AddDefenseNonGucian 
create proc AddDefenseNonGucian --(not done)
@ThesisSerialNo int ,
@DefenseDate Datetime , 
@DefenseLocation varchar(15)
as
go
--
--4.f_Add examiner(s) for a defense
create proc AddExaminer
@ThesisSerialNo int , 
@DefenseDate Datetime , 
@ExaminerName varchar(20), 
@National bit, 
@fieldOfWork varchar(20)
as
declare @ex_id int
set @ex_id= (select e.id from Examiner e where e.name=@ExaminerName and isNational=@National and
fieldOfWork=@fieldOfWork)
insert into ExaminerEvaluateDefense (date,serialNo,examinerId)values 
(@DefenseDate,@ThesisSerialNo,@ex_id)
go
--drop proc AddExaminer 
--4.g_Cancel a Thesis if the evaluation of the last progress report is zero
create proc CancelThesis
@ThesisSerialNo int
as
if exists(select * from NonGUCianProgressReport where thesisSerialNumber=@ThesisSerialNo)
begin
select eval from
(select max(progressReportDate),pr.eval as eval from NonGUCianProgressReport pr where 
thesisSerialNumber=@ThesisSerialNo)
end
else
select max(progressReportDate) as MaxDate from GUCianProgressReport where 
thesisSerialNumber=@ThesisSerialNo
go
--4.h_Add a grade for a thesis
create proc AddGrade
@ThesisSerialNo int,
@Grade decimal (3,2)
as
update Thesis set grade=@Grade where serialNumber=@ThesisSerialNo
go
--5.a_Add grade for a defense
create proc AddDefenseGrade
@ThesisSerialNo int , 
@DefenseDate Datetime , 
@grade decimal(3,2)
as
update Defense set grade=@grade where serialNumber=@ThesisSerialNo and date=@DefenseDate
go
--5.b_Add comments for a defense
create proc AddCommentsGrade
@ThesisSerialNo int , 
@DefenseDate Datetime , 
@comments varchar(300)
as
update ExaminerEvaluateDefense set comment=@comments where serialNo=@ThesisSerialNo
and date=@DefenseDate
go
--6.a_View my profile that contains all my information
create proc viewMyProfile
@studentId int
as
if exists(select * from GucianStudent where id=@studentId)
select * from GucianStudent where id=@studentId
else select * from NonGucianStudent where id=@studentId
go
--6.b_Edit my profile (change any of my personal information)
create proc editMyProfile
@studentID int, 
@firstName varchar(10)=null, 
@lastName varchar(10)=null, 
@password varchar(10)=null, 
@email varchar(10)=null, 
@address varchar(10)=null, 
@type varchar(10)=null
as
if exists(select * from GucianStudent where id=@studentId)
begin
if(@firstName is not null) update GucianStudent set first_name=@firstName
where id=@studentID
if (@lastName is not null) update GucianStudent set last_name=@lastName
where id=@studentID
if (@password is not null) update PostGradUser set password=@password
where id=@studentID
if (@email is not null) update PostGradUser set email=@email
where id=@studentID
if (@address is not null) update GucianStudent set address=@address
where id=@studentID
if (@type is not null) update GucianStudent set type=@type where
id=@studentID
end
else
begin
if(@firstName is not null) update NonGucianStudent set first_name=@firstName
where id=@studentID
if (@lastName is not null) update NonGucianStudent set last_name=@lastName
where id=@studentID
if (@password is not null) update PostGradUser set password=@password
where id=@studentID
if (@email is not null) update PostGradUser set email=@email
where id=@studentID
if (@address is not null) update NonGucianStudent set address=@address
where id=@studentID
if (@type is not null) update NonGucianStudent set type=@type where
id=@studentID
end
go
--drop proc editMyProfile
--6.c_As a Gucian graduate, add my undergarduate ID
create proc addUndergradID 
@studentID int, 
@undergradID varchar(10)
as
if exists(select * from GucianStudent where id=@studentID)
update GucianStudent set undergradID=@undergradID where id=@studentID
else print 'Invalid ID'
go
--6.d_As a nonGucian student, view my courses’ grades
create proc ViewCoursesGrades
@studentID int
as
select c.code as'Course Code',nt.grade as 'Grade',c.creditHours 'Credit Hours' from Course c inner join 
NonGucianStudentTakeCourse nt on c.id=nt.cid where nt.sid=@studentID
go
--drop proc ViewCoursesGrades
--6.e_View all my payments and installments
create proc ViewCoursePaymentsInstall
@studentID int
as
select c.code as'Course Code',p.amount,p.no_installments from NonGucianStudentPayForCourse 
nc inner join Course c on nc.cid=c.id inner join Payment p on nc.paymentNo=p.id
where nc.sid=@studentID
go
--ViewThesisPaymentsInstall
create proc ViewThesisPaymentsInstall
@studentID int
as
if exists (select * from GucianStudent where id=@studentID)
select t.title as'Thesis Title',p.amount,p.no_installments from Thesis t inner join Payment p on t.payment_id=p.id 
inner join GUCianStudentRegisterThesis s on s.serial_no=t.serialNumber where s.sid=@studentID
else
select t.title as 'Thesis Title',p.amount,p.no_installments from Thesis t inner join Payment p on t.payment_id=p.id 
inner join NonGUCianStudentRegisterThesis s on s.serial_no=t.serialNumber where s.sid=@studentID
go
--ViewUpcomingInstallments
create proc ViewUpcomingInstallments
@studentID int
as
if exists (select * from GucianStudent where id=@studentID)
select i.amount,i.date from Installment i inner join Payment p on i.payment_id=p.id
inner join Thesis t on t.payment_id=p.id inner join GUCianStudentRegisterThesis gt on
gt.serial_no=t.serialNumber where gt.sid=@studentID and i.done=0 
else
select i.amount,i.date from Installment i inner join Payment p on i.payment_id=p.id
inner join Thesis t on t.payment_id=p.id inner join NonGUCianStudentRegisterThesis gt on
gt.serial_no=t.serialNumber inner join NonGucianStudentPayForCourse n_pc on n_pc.paymentNo=p.id  
where gt.sid=@studentID and i.done=0
go
--drop proc ViewUpcomingInstallments
--ViewMissedInstallments
create proc ViewMissedInstallments
@studentID int
as
if exists (select * from GucianStudent where id=@studentID)
select i.amount,i.date from Installment i inner join Payment p on i.payment_id=p.id
inner join Thesis t on t.payment_id=p.id inner join GUCianStudentRegisterThesis gt on
gt.serial_no=t.serialNumber where gt.sid=@studentID and i.done=0 and i.date < CONVERT(DATE, GETDATE())
else
select i.amount,i.date from Installment i inner join Payment p on i.payment_id=p.id
inner join Thesis t on t.payment_id=p.id inner join NonGUCianStudentRegisterThesis gt on
gt.serial_no=t.serialNumber inner join NonGucianStudentPayForCourse n_pc on n_pc.paymentNo=p.id  
where gt.sid=@studentID and i.done=0 and i.date < CONVERT(DATE, GETDATE());
go
--drop proc ViewMissedInstallments
--6.f_Add and fill my progress report(s)
create proc AddProgressReport
@thesisSerialNo int, 
@progressReportDate date
as
declare @studentID int
if exists (select * from GUCianStudentRegisterThesis where serial_no=@thesisSerialNo) 
begin set @studentID=(select s.id from Thesis t inner join GUCianStudentRegisterThesis gt on t.serialNumber=gt.serial_no inner join
GucianStudent s on gt.sid=s.id where t.serialNumber=@thesisSerialNo)
insert into GUCianProgressReport (sid,thesisSerialNumber,progressReportDate) values 
(@studentID,@thesisSerialNo,@progressReportDate)
end
else
begin set @studentID=(select s.id from Thesis t inner join NonGUCianStudentRegisterThesis gt on t.serialNumber=gt.serial_no inner join
NonGucianStudent s on gt.sid=s.id where t.serialNumber=@thesisSerialNo)
insert into NonGUCianProgressReport (sid,thesisSerialNumber,progressReportDate) values (@studentID,@thesisSerialNo,@progressReportDate)
end
go
--drop proc AddProgressReport
--FillProgressReport
create proc FillProgressReport
@thesisSerialNo int, 
@progressReportNo int, 
@state int, 
@description varchar(200)
as
declare @studentID int
if exists (select * from GUCianStudentRegisterThesis where serial_no=@thesisSerialNo) 
update GUCianProgressReport set state=@state,description=@description where progressReportNo=@progressReportNo
else
update NonGUCianProgressReport set state=@state,description=@description where progressReportNo=@progressReportNo
go
--6.g_View my progress report(s) evaluations
create proc ViewEvalProgressReport
@thesisSerialNo int, 
@progressReportNo int
as
if exists(select * from GUCianProgressReport where thesisSerialNumber=@thesisSerialNo and progressReportNo=@progressReportNo)
select r.progressReportNo,r.eval from GUCianProgressReport r where thesisSerialNumber=@thesisSerialNo and 
progressReportNo=@progressReportNo
else 
select r.progressReportNo,r.eval from NonGUCianProgressReport r where thesisSerialNumber=@thesisSerialNo and 
progressReportNo=@progressReportNo
go
--g.h_Add publication
create proc addPublication
@title varchar(50), 
@pubDate datetime, 
@host varchar(50), 
@place varchar(50), 
@accepted bit
as
insert into Publication (title, date, host, place, accepted) values (@title,@pubDate,@host,@place,@accepted)
go
--drop proc addPublication
--6.i_Link publication to my thesis
create proc linkPubThesis
@PubID int, 
@thesisSerialNo int
as
insert into ThesisHasPublication values (@PubID,@thesisSerialNo)
go


