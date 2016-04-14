--==??| DML for COMP9120 |???==--

-----------------------------------------------------------
-- Final edit by Jason Lockie
-- Edit By Ronak Patel
-- Written by Brett Samuel
-- Version 4


-----------------------------------------------------------

clear screen;


CREATE TABLE Participating_countries(
  iso char (2),--I thought this was a two character code ? -jl -- fixed BS
  country_name varchar(20),--name spelling error -> country_name -jl
  PRIMARY KEY (iso)
);

CREATE TABLE Spectator(
  id_type varchar(22),
  country varchar(45),
  o_state char(10),
  doc_id integer(15),
  address varchar(100),
  full_name varchar(70),
  PRIMARY KEY (id_type, country, o_state, doc_id)
  );

CREATE TABLE Event (
  event_name varchar (20),
  round_no INTEGER(3),
  --3 char not enough ->20, i.e "AU, BR, US" are all competing in the event -jl
  participating_countries char(2),--Wrong, this should have been put in the PK originally so that 
  --we can have more than one country competing from the iso table. changed data type to iso standard -jl
  date_and_time datetime, --see: https://docs.oracle.com/cd/E17952_01/refman-5.5-en/datetime.html
  --datetime forat: 'YYYY-MM-DD HH:MM:SS'
  --note I renamed "date	+	time" date_and_time
  sport varchar(20),
  PRIMARY KEY (event_name, round_no),--added comma -jl
  FOREIGN KEY (participating_countries) REFERENCES Participating_countries (iso)--remove comma -jl
);

CREATE TABLE Venue (
  venue_name varchar(20),
  location varchar(20),
  --- note that I added a "d" to the end of disable
  disabled_access_info varchar(200),
  PRIMARY KEY (venue_name)
);

CREATE TABLE Seat (
  seat_code INTEGER(6), --changed name -> seat_code, increase to 6char -jl --changed to integer type -jl
  venue_name VARCHAR(20) NOT NULL,--added not null -jl
  aisle VARCHAR(2),--perhaps we could pull a seating chart from somewhere so we are clear on the suitable inputs to this table -jl
  gate CHAR,
  seat_class VARCHAR(20),
  PRIMARY KEY (seat_code, seat_class, venue_name),
  FOREIGN KEY (venue_name) REFERENCES Venue (venue_name)
);

CREATE TABLE Ticket (
  barcode INTEGER,
  --changed name to seat_code, and 6 char as now including row number in this attribute -jl
  seat_code INTEGER(6),
  status VARCHAR(10) NOT NULL, -- added by BS
  seat_class VARCHAR(20),
  event_name VARCHAR(20),
  --name round not available --> round_no -jl
  --lets also discuss the data type for round_no next meeting -jl
  round_no INTEGER(3),--shoubld not be varchar here! -jl
  venue_name VARCHAR(20),
  PRIMARY KEY (barcode),
  FOREIGN KEY (seat_code, seat_class, venue_name) REFERENCES Seat (seat_code, seat_class, venue_name),
  FOREIGN KEY (event_name, round_no) REFERENCES Event (event_name, round_no)--removed comma
  --removed venue_name reference to venue table as it is already part of the key in seat table -jl
);

--removed ticket status table

CREATE TABLE Transactions (--changed name to Transactions as Transaction not available -jl
  transaction_number integer(20) NOT NULL, --bs added unique to make tickets_sold work
  --took out unique:tickets sold is not a table anymore and multiple tickets may be purchased in one transaction. -jl
  --Transaction number is a NUMBER so I changed the data type to a number! -jl
  price integer(4),--added a data type to price -jl
  barcode integer
  FOREIGN KEY (barcode) REFERENCES Ticket (barcode)
);

--removed tickets sold table as per ER model changes -jl