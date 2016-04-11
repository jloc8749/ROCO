-----------------------------------------------------------
-- Written by Jason Lockie
-- Final edit by Brett 4/4/2016
-----------------------------------------------------------

INSERT INTO Participating_countries VALUES ('CR','Costa Rica');
INSERT INTO Participating_countries VALUES ('AU','AUSTRALIA');
INSERT INTO Participating_countries VALUES ('CK','COOK ISLANDS');

--SELECT * FROM Participating_countries;



INSERT INTO Spectator VALUES ('PASSPORT', 'AU', 'NSW', 'PA43359187','112 King St,Newtown', 'John Knowitall');
INSERT INTO Spectator VALUES ('LICENSE', 'US', 'CA', '0803397221','98 Caballero St, Cupertino', 'Geoff Insiliconval');
INSERT INTO Spectator VALUES ('PASSPORT', 'AU', 'VIC', 'B7881203','81 Acacia Dr, Torquay', 'Wendy Lovesicecream');

--SELECT * FROM Spectator;
INSERT INTO Event VALUES ('100m Sprint', '003','AU', '2016/06/02 14:10', 'track event');    --bs removed multiple countries as created errors
INSERT INTO Event VALUES ('mens freestyle', '001','CK', '2016/06/04 18:15', 'swimming');    --bs removed multiple countries as created errors
INSERT INTO Event VALUES ('womens freestyle', '004', 'AU', '2016/07/04 11:15', 'swimming'); --bs removed multiple countries as created errors
 
--SELECT * FROM Event;
 

INSERT INTO Venue VALUES ('stadium park', '45 riverside ave', 'access via hank lane ramp on eastern side');
INSERT INTO Venue VALUES ('aquatic centre', 'Bentley Park', 'No wheelchair access available');


INSERT INTO Seat VALUES ('03123', 'stadium park', 'A1', 'D', 'vip');   -- bs added semicolon to end
INSERT INTO Seat VALUES ('03243', 'aquatic centre', 'A9', 'Z', 'vip'); -- bs added semicolon to end
INSERT INTO Seat VALUES ('03144', 'aquatic centre', 'A9', 'Z', 'vip'); -- bs added semicolon to end


INSERT INTO Ticket VALUES (001010,'03123','vip','100m Sprint','003','stadium park');
INSERT INTO Ticket VALUES (001110,'03243','vip','mens freestyle','001','aquatic centre');
INSERT INTO Ticket VALUES (011101,'03144','vip','womens freestyle','004','aquatic centre');


  
INSERT INTO Ticket_status VALUES (001010,'available');
INSERT INTO Ticket_status VALUES (001110,'posted');
INSERT INTO Ticket_status VALUES (011101,'printing');

INSERT INTO Transactions VALUES ('001','PASSPORT', 'AU', 'NSW', 'PA43359187');


INSERT INTO Tickets_sold VALUES ('001', 001110);