--==??| DML for COMP9120 |???==--

-----------------------------------------------------------
-- Final edit by Jason Lockie
-- Edit By Ronak Patel
-- Written by Brett Samuel
-- Version 1


-----------------------------------------------------------

clear screen;


CREATE TABLE Participating_countries (
  iso varchar (3),--I thought this was a two character code ? -jl
  country_name varchar(20),--name spelling error -> country_name -jl
  PRIMARY KEY (iso)
);

CREATE TABLE Spectator (
  id_type varchar(20),
  country varchar(45),
  o_state varchar(20),--i note you've used o_state where state not available -> need to update diagrams -jl
  doc_id varchar(15),
  address varchar(100),
  full_name varchar(70),
  PRIMARY KEY (id_type, country, o_state, doc_id)
);

CREATE TABLE Event (
  event_name varchar (20),
  round_no varchar(20),
  --3 char not enough ->20, i.e "AU, BR, US" are all competing in the event -jl
  participating_countries varchar(20),
  date_and_time varchar(20),
  --note I renamed "date	+	time" date_and_time
  --todo: find out if there is a date/time stamp in oracle SQL
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
  seat_code VARCHAR(6), --changed name -> seat_code, increase to 6char -jl
  venue_name VARCHAR(20) NOT NULL,--added not null -jl
  aisle VARCHAR(2),--perhaps we could pull a seating chart from somewhere so we are clear on the suitable inputs to this table -jl
  gate CHAR,
  seat_class VARCHAR(20),
  --added seat_class to key as it is in a disjoint ISA relationship with forced participation -jl
  --added venue_name to PK. My opinion is that multiple seat classes for the same seat (at the same venue) are useless. -jl
  PRIMARY KEY (seat_code, seat_class, venue_name),
  FOREIGN KEY (venue_name) REFERENCES Venue (venue_name)
);

CREATE TABLE Ticket (
  barcode INTEGER,
  --changed name to seat_code, and 6 char as now including row number in this attribute -jl
  seat_code VARCHAR(6),
  seat_class VARCHAR(20),
  event_name VARCHAR(20),
  --name round not available --> round_no -jl
  --lets also discuss the data type for round_no next meeting -jl
  round_no VARCHAR(20),
  venue_name VARCHAR(20),
  PRIMARY KEY (barcode),
  FOREIGN KEY (seat_code, seat_class, venue_name) REFERENCES Seat (seat_code, seat_class, venue_name),
  FOREIGN KEY (event_name, round_no) REFERENCES Event (event_name, round_no)--removed comma
  --removed venue_name reference to venue table as it is already part of the key in seat table -jl
);

CREATE TABLE Ticket_status (
  barcode integer,
  status varchar(20),--added comma -jl
  PRIMARY KEY (barcode, status),--added this PK due to the forced participation of each ticket having a status.
  FOREIGN KEY (barcode) REFERENCES Ticket (barcode)
);

CREATE TABLE Transactions (--changed name to Transactions as Transaction not available -jl
  transaction_number varchar(20) unique NOT NULL, --bs added unique to make tickets_sold work
  id_type varchar(20),
  country varchar(45),
  o_state varchar(20),
  doc_id varchar(15),
  --address varchar(100), --why is this here?? -jl
  --full_name varchar(70), --why is this here?? -jl
  --PK removed: more than one spectator posible per transaction if buying multiple tickets -jl
  --main constraint is that the spectator exists before transactions are generated (weak entity transaction discriminated by spectator) -jl
  --*fingers crossed* -jl
  --PRIMARY KEY (transaction_number)
  FOREIGN KEY (id_type, country, o_state, doc_id) REFERENCES Spectator (id_type, country, o_state, doc_id)--removed comma -jl
);

CREATE TABLE Tickets_sold(
  transaction_number varchar(20),
  barcode INTEGER NOT NULL,--added not null -jl
  
  FOREIGN KEY (transaction_number) REFERENCES Transactions (transaction_number),--added comma -jl
  FOREIGN KEY (barcode) REFERENCES Ticket (barcode)
);

