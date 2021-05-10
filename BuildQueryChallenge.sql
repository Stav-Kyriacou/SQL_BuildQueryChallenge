--Stavros Kyriacou 101610510

--USE BuildQueryChallengeOfficial;

--RELATIONAL SCHEMA

-- TOUR (TourName, Description)
-- PRIMARY KEY (TourName)

-- CLIENT (ClientID, Surname, GivenName, Gender)
-- PRIMARY KEY (ClientID)

-- EVENT (TourName, EventMonth, EventDay, EventYear, EventFee)
-- PRIMARY KEY (EventYear, EventMonth, EventDay, TourName)
-- FOREIGN KEY (TourName) REFERENCES Tour(TourName)

-- BOOKING (ClientID, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked)
-- PRIMARY KEY (ClientID, TourName, EventMonth, EventDay, EventYear)
-- FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
-- FOREIGN KEY (TourName, EventYear, EventMonth, EventDay) REFERENCES Event(TourName, EventYear, EventMonth, EventDay)


IF OBJECT_ID('BOOKING') IS NOT NULL
    DROP TABLE BOOKING;
IF OBJECT_ID('EVENT') IS NOT NULL
    DROP TABLE EVENT;
IF OBJECT_ID('TOUR') IS NOT NULL
    DROP TABLE TOUR;
IF OBJECT_ID('CLIENT') IS NOT NULL
    DROP TABLE CLIENT;

CREATE TABLE TOUR (
    TourName            NVARCHAR(100)
,   Description         NVARCHAR(500)
,   PRIMARY KEY (TourName)
);

CREATE TABLE CLIENT (
    ClientID            INT
,   SurName             NVARCHAR(100) NOT NULL
,   GivenName           NVARCHAR(100) NOT NULL
,   Gender              NVARCHAR(1) CHECK (Gender IN ('M', 'F', 'I'))
,   PRIMARY KEY (ClientID)
);

CREATE TABLE EVENT (
    TourName            NVARCHAR(100)
,   EventMonth          NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
,   EventDay            INT CHECK (EventDay >= 1 AND EventDay <= 31)
,   EventYear           INT CHECK (LEN(EventYear) = 4)
,   EventFee            INT CHECK (EventFee > 0) NOT NULL
,   PRIMARY KEY (TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY (TourName) REFERENCES TOUR(TourName)
);

CREATE TABLE BOOKING (
    ClientID            INT
,   TourName            NVARCHAR(100)
,   EventMonth          NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
,   EventDay            INT CHECK (EventDay >= 1 AND EventDay <= 31)
,   EventYear           INT CHECK (LEN(EventYear) = 4)
,   Payment             INT CHECK (Payment > 0)
,   DateBooked          DATE NOT NULL
,   PRIMARY KEY (ClientID, TourName, EventMonth, EventDay, EventYear)
,   FOREIGN KEY (ClientID) REFERENCES CLIENT(ClientID)
,   FOREIGN KEY (TourName, EventMonth, EventDay, EventYear) REFERENCES EVENT(TourName, EventMonth, EventDay, EventYear)
);


INSERT INTO TOUR 
(TourName,  Description) VALUES
('North',	'Tour of wineries and outlets of the Bedigo and Castlemaine region'),
('South',	'Tour of wineries and outlets of Mornington Penisula'),
('West',    'Tour of wineries and outlets of the Geelong and Otways region');


INSERT INTO CLIENT
(ClientID,  SurName,    GivenName,  Gender) VALUES
(1,	        'Price',	'Taylor',	'M'),
(2,	        'Gamble',	'Ellyse',	'F'),
(3,	        'Tan',	    'Tilly',	'F'),
(101610510, 'Kyriacou', 'Stavros',  'M');

INSERT INTO EVENT
(TourName,  EventMonth, EventDay,   EventYear,  EventFee) VALUES
('North',	'Jan',	    9,	        2016,	    200),
('North',	'Feb',	    13,	        2016,	    225),
('South',	'Jan',	    9,	        2016,	    200),
('South',	'Jan',	    16,	        2016,	    200),
('West',	'Jan',	    29,	        2016,	    225);

INSERT INTO BOOKING
(ClientID,  TourName,   EventMonth, EventDay,   EventYear,  Payment,    DateBooked) VALUES
(1,	        'North',	'Jan',	    9,	        2016,	    200,	    '2015-12-10'),
(2,	        'North',	'Jan',  	9,	        2016,	    200,	    '2015-12-16'),
(1,	        'North',	'Feb',  	13,	        2016,	    225,	    '2016-01-08'),
(2,	        'North',	'Feb',	    13,	        2016,	    125,	    '2016-01-14'),
(3,	        'North',	'Feb',	    13,	        2016,	    225,	    '2016-02-03'),
(1,	        'South',	'Jan',	    9,	        2016,	    200,	    '2015-12-10'),
(2,	        'South',	'Jan',	    16,	        2016,	    200,	    '2015-12-18'),
(3,	        'South',	'Jan',	    16,	        2016,	    200,	    '2016-01-09'),
(2,	        'West',	    'Jan',	    29,	        2016,	    225,	    '2015-12-17'),
(3,	        'West',	    'Jan',	    29,	        2016,	    200,	    '2015-12-18');

--Task 4
--Query 1
SELECT C.GivenName, C.Surname, B.TourName, T.Description, B.EventYear, B.EventMonth, B.EventDay, E.EventFee, B.DateBooked, B.Payment
FROM BOOKING B
INNER JOIN CLIENT C
ON B.ClientID = C.ClientID

INNER JOIN TOUR T
ON B.TourName = T.TourName

INNER JOIN EVENT E
ON B.TourName = E.TourName
AND B.EventYear = E.EventYear
AND B.EventMonth = E.EventMonth
AND B.EventDay = E.EventDay;

--Query 2
SELECT EventMonth, TourName, COUNT(*) AS 'Num Bookings'
FROM BOOKING
GROUP BY EventMonth, TourName;

--Query 3
SELECT *
FROM BOOKING
WHERE Payment > (SELECT AVG(Payment) FROM BOOKING);

