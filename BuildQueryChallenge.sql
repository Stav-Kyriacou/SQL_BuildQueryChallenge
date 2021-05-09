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