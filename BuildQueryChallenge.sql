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


SELECT * FROM INFORMATION_SCHEMA.TABLES;