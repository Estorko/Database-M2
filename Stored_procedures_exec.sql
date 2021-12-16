--1.a_Register to the website by using my name (First and last name), password, faculty, email, and address
exec StudentRegister 'x','y','test','BI',1,'test@gmail.com','r';
select* from PostGradUser;
select * from GucianStudent;
--1.b_SupervisorRegister
exec SupervisorRegister 'Ahmad','Hany','7Rp[RV','Business informatics','Ahmad.Hany@gmail.com';
select * from PostGradUser;
select * from Supervisor;
--2.a_login using my username and password
exec userLogin 1,'u8nN}B';
--2.b_add my mobile number(s)
exec addMobile 1,'+20 224 899 1352';
select * from GUCStudentPhoneNumber;
--3.a_List all supervisors in the system
exec AdminListSup;
--3.b_view the profile of any supervisor that contains all his/her information
exec AdminViewSupervisorProfile 13;
--3.c_List all Theses in the system
exec AdminViewAllTheses;
--3.d_List the number of on going theses.
exec AdminViewOnGoingTheses;
--3.e_List all supervisors’ names currently supervising students, theses title, student name
exec AdminViewStudentThesisBySupervisor
--3.f_List nonGucians names, course code, and respective grade.
exec AdminListNonGucianCourse 1
--3.g_Update the number of thesis extension by 1
exec AdminUpdateExtension 3
--3.h_Issue a thesis payment
exec AdminIssueThesisPayment 1,2800,3,1.2
--3.i_view the profile of any student that contains all his/her information
exec AdminViewStudentProfile 1
--3.k_List the title(s) of accepted publication(s) per thesis
exec AdminListAcceptPublication