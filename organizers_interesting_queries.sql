/* Most popular post topics */

SELECT T_Title , Count(T_Title)
FROM TAGS
ORDER BY DESC
LIMIT 10;

/* Notifications sent in the last 2 hours */
SELECT N_Content, N_Sender
FROM Notifications
WHERE N_Time >= (NOW() - INTERVAL '2 hours');

/* Employees who are not working on a particular day */
SELECT O_ID, O_LastName
FROM Organizers
WHERE O_ID NOT IN
(SELECT E_S_ID AS O_ID
FROM EMPLOYEE_WORK_SHIFT
WHERE DATE = now()::DATE);
