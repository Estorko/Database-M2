--1.a_Register to the website by using my name (First and last name), password, faculty, email, and address
exec StudentRegister 'Baher','Rafael','BaherR^_3','Business Informatics',1,'Baher@gmail.com','Tagamo3';
--1.b_SupervisorRegister
exec SupervisorRegister 'Ahmad','Hany','7Rp[RV','Business informatics','Ahmad.Hany@gmail.com';
--2.a_login using my username and password
exec userLogin 1,'u8nN}B';
--2.b_add my mobile number(s)
exec addMobile 1,'+20 224 899 1352';
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
--3.j_Issue installments as per the number of installments for a certain payment every six months starting from the entered date
exec AdminIssueInstallPayment 16,'1/1/2018'
--3.k_List the title(s) of accepted publication(s) per thesis
exec AdminListAcceptPublication
--3.l_Add courses and link courses to students
exec AddCourse 'CSEN-421',6,5000
exec linkCourseStudent 3,8
exec addStudentCourseGrade 3,8,1.8
--3.m_View examiners and supervisor(s) names attending a thesis defense taking place on a certain date
exec ViewExamSupDefense '2/9/2016'
--4.a_Evaluate a student’s progress report, and give evaluation value 0 to 3
exec EvaluateProgressReport 14,9,4,3
--4.b_View all my students’s names and years spent in the thesis
exec ViewSupStudentsYears 14
--4.c_View my profile and update my personal information
exec SupViewProfile 13
exec UpdateSupProfile 13,'Yara','Applied Arts'
--4.d_View all publications of a student
exec ViewAStudentPublications 4
--4.e_Add defense for a thesis, for nonGucian students all courses’ grades should be greater than 50 percent
exec AddDefenseGucian 1,'12/24/2020','N5'
exec AddDefenseNonGucian 10,'12/24/2020','N5'
exec AddDefenseNonGucian 9,'12/24/2020','N5'
--4.f_Add examiner(s) for a defense
exec AddExaminer 2,'2/9/2016','Mervat',1,'Proffessor'
--4.g_Cancel a Thesis if the evaluation of the last progress report is zero
exec CancelThesis 1
--4.h_Add a grade for a thesis
exec AddGrade 1,2.1
--5.a_Add grade for a defense
exec AddDefenseGrade 2,'2016-02-09',1.8
--5.b_Add comments for a defense
exec AddCommentsGrade 10,'2012-09-22','The student did a good job'
--6.a_View my profile that contains all my information
exec viewMyProfile 1
--6.b_Edit my profile (change any of my personal information)
exec editMyProfile 2,'Ashraf_Edited',@password='test';
--6.c_As a Gucian graduate, add my undergarduate ID
exec addUndergradID 2,'14444'
--6.d_As a nonGucian student, view my courses’ grades
exec ViewCoursesGrades 10
--6.e_View all my payments and installments
exec ViewCoursePaymentsInstall 10
exec ViewThesisPaymentsInstall 2
exec ViewUpcomingInstallments 5
exec ViewMissedInstallments 3
--6.f_Add and fill my progress report(s)
exec AddProgressReport 10,'12/11/2020'
exec FillProgressReport 6,1,2,'TEST'
--6.g_View my progress report(s) evaluations
exec ViewEvalProgressReport 1,1
--6.h_Add publication
exec addPublication 'Adoption of Technical analysis','2019/6/7','Hilton Hotel','Cairo International Confrence',1
--6.i_Link publication to my thesis
exec linkPubThesis 3,2