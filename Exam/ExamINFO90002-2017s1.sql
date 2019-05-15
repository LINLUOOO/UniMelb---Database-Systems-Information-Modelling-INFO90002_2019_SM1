/*
A) List any students who have passed more than 30 credit points of subjects. “Pass” means a result of 50 or
more. Show the students’ first and last names and total credit points passed.  (3 marks)
*/
SELECT Student.firstname, Student.lastname, TotalCreditPoints.AccumCreditPoints
FROM 
	(SELECT student, SUM(Subject.creditpoints) AS AccumCreditPoints
	FROM 
		(SELECT *
		FROM StudentTakesSubject
		WHERE result >= 50) AS StudentPassesSubject
		LEFT JOIN Subject ON StudentPassesSubject.code = Subject.code
	GROUP BY StudentPassesSubject.student
    HAVING SUM(Subject.creditpoints) > 30) AS TotalCreditPoints
    LEFT JOIN Student ON TotalCreditPoints.student = Student.id;
    
/*
B) Which lecturers have taught or are teaching students who live in the same suburb as them?
Show the lecturers’ first and last names.(There is no need to list the students.)  (4 marks)
/*
SELECT Lecturer.firstname, Lecturer.lastname
FROM 
	StudentTakesSubject
    LEFT JOIN Subject ON StudentTakesSubject.code = Subject.code
    LEFT JOIN Student ON StudentTakesSubject.student = Student.id
    LEFT JOIN Lecturer ON Subject.lecturer = Lecturer.id
WHERE Lecturer.postcode = Student.postcode;



