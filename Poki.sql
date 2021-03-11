--1.What grades are stored in the database?
SELECT	* FROM Grade


--2.What emotions may be associated with a poem?
SELECT	* FROM emotion


--3.How many poems are in the database?
SELECT COUNT(p.ID)
From Poem p

--4.Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 * FROM Author
ORDER BY Name ASC


--5.Starting with the above query, add the grade of each of the authors.
SELECT a.Name, g.Name
FROM Author a
LEFT JOIN Grade g on a.GradeId = g.ID
group by a.Name, g.Name


--6.Starting with the above query, add the recorded gender of each of the authors.
SELECT a.Name, g.Name, ge.Name
FROM Author a
LEFT JOIN Grade g on a.GradeId = g.Id
LEFT JOIN Gender ge on a.GenderId = ge.Id
group by a.Name, g.Name, ge.Name


--7.What is the total number of words in all poems in the database?
SELECT COUNT(p.WordCount) as wordCount
FROM Poem p


--8.Which poem has the fewest characters?
SELECT p.Title
FROM Poem p
WHERE p.CharCount = (SELECT MIN(P.CharCount) FROM Poem p)


--9.How many authors are in the third grade?
SELECT Count(a.Id)
FROM Author a
LEFT JOIN Grade g on a.GradeId = g.Id
where a.GradeId = 3


--10.How many authors are in the first, second or third grades?
SELECT COUNT(a.Id) as #
FROM Author a
LEFT JOIN Grade g on a.GradeId = g.Id
where a.GradeId = 3 OR a.GradeId = 1 OR  a.GradeId = 2


--11.What is the total number of poems written by fourth graders?
SELECT COUNT(p.Id) as #
FROM Author a
LEFT JOIN Poem p on a.Id = p.AuthorId
LEFT JOIN Grade g on a.GradeId = g.Id
where a.GradeId = 4


--12.How many poems are there per grade?
SELECT COUNT(p.Id) as #, g.Id as grade
FROM Poem p
LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Grade g on a.GradeId = g.Id
GROUP BY g.Id
ORDER BY g.Id Asc


--13.How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT COUNT(a.Id) as #, g.Id as grade
FROM Author a
LEFT JOIN Grade g on a.GradeId = g.Id
GROUP BY g.Id
ORDER BY COUNT(a.Id) ASC


--14.What is the title of the poem that has the most words?
SELECT p.Title
FROM Poem p
WHERE p.WordCount = (SELECT MAX(p.WordCount) FROM Poem p)


--15.Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT top 1 COUNT(p.id) AS #, a.Name AS Author
FROM Author a
LEFT JOIN Poem p on a.Id = p.AuthorId
GROUP BY a.Name ORDER BY COUNT(p.id) DESC


--16.How many poems have an emotion of sadness?
SELECT COUNT(p.Id) as #,  e.Name AS emotion
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.id
GROUP BY e.Name, e.id
HAVING e.Id = 3


--17.How many poems are not associated with any emotion?
SELECT COUNT(p.Id) as #
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.id
WHERE e.Id IS NULL


--18.Which emotion is associated with the least number of poems?
SELECT top 1 COUNT(p.id) as #, e.Name AS emotion
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.id
GROUP BY e.Name, e.id
HAVING e.Name IS NOT NULL
ORDER BY COUNT(p.id) ASC


--19.Which grade has the largest number of poems with an emotion of joy?
SELECT top 1 COUNT(p.id) as #, e.Name AS emotion
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
	left join Author a on a.Id = p.authorId 
	left join Grade g on g.Id = a.GradeId
	GROUP BY e.Name, e.id, g.name
HAVING e.Name IS NOT NULL and e.id = 4
ORDER BY COUNT(p.id) ASC


--20.Which gender has the least number of poems with an emotion of fear?
SELECT top 1 COUNT(p.id) as #, ge.Name AS gender
FROM Poem p
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
	left join Author a on a.Id = p.authorId 
	left join Gender ge on ge.Id = a.GenderId
	GROUP BY e.Name, e.id, ge.name
HAVING e.Name IS NOT NULL and e.id = 2
ORDER BY COUNT(p.id) ASC

