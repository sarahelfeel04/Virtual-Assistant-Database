CREATE DATABASE HomeSync;
USE HomeSync


CREATE TABLE Room(
room_id INT PRIMARY KEY IDENTITY, 
type varchar(20), 
floor INT, 
status varchar(20)
);

CREATE TABLE Users (
id int PRIMARY KEY IDENTITY,
f_Name varchar (20),
l_Name varchar (20),
password varchar (10), 
email varchar (50), 
preference varchar (100), 
room int,
type varchar(20),
birthdate DATETIME not null,
age AS (YEAR(CURRENT_TIMESTAMP)-YEAR(birthdate)),
FOREIGN KEY(room) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admin (
admin_id int,
no_of_guests_allowed int,
salary decimal (13,2),
PRIMARY KEY (admin_id),
FOREIGN KEY(admin_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Guest (
guest_id int, 
guest_of int, 
address varchar (30), 
arrival_date DATETIME,
departure_date DATETIME, 
residential bit,
PRIMARY KEY (guest_id),
FOREIGN KEY(guest_id) REFERENCES Users ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(guest_of) REFERENCES Admin
);
--------------------****************************************************************************--------------------

CREATE TABLE Task (
Task_id int PRIMARY KEY IDENTITY, 
name varchar(30), 
creation_date DATETIME, 
due_date DATETIME, 
category varchar(20), 
creator int, 
status varchar(20), 
reminder_date DATETIME, 
priority int,
FOREIGN KEY(creator) REFERENCES Admin ON DELETE CASCADE ON UPDATE CASCADE
);
--------------------****************************************************************************--------------------

CREATE TABLE Assigned_to(
admin_id int, 
task_id int, 
user_id int,
PRIMARY KEY(admin_id, task_id, user_id),
FOREIGN KEY(admin_id) REFERENCES Admin,
FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(task_id) REFERENCES Task 
);
--------------------****************************************************************************--------------------
CREATE TABLE Calendar(
event_id int ,
user_assigned_to int, 
name varchar(50), 
description varchar (200), 
location varchar (40), 
reminder_date DATETIME,
PRIMARY KEY(event_id, user_assigned_to),
FOREIGN KEY(user_assigned_to) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

-------------------------------Malak---------------------------------------------------------------------------------

CREATE TABLE Notes(
id INT,
user_id INT,
content varchar(500),
creation_date DATETIME,
title varchar(50),
PRIMARY KEY(id),
FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
);
-- USER


CREATE TABLE Travel(
trip_no INT, 
hotel_name varchar(10), 
destination  varchar(40), 
ingoing_flight_num varchar(30), 
outgoing_flight_num varchar(30), 
ingoing_flight_date DATETIME,
outgoing_flight_date DATETIME, 
ingoing_flight_airport varchar(30), 
outgoing_flight_airport varchar(30), 
transport varchar(10), 
PRIMARY KEY(trip_no)
);


CREATE TABLE User_trip(
trip_no INT, 
user_id INT, 
hotel_room_no INT, 
in_going_flight_seat_number VARCHAR(5), 
out_going_flight_seat_number VARCHAR(5),
PRIMARY KEY(trip_no,user_id),
FOREIGN KEY(trip_no) REFERENCES Travel ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
);
-- USER AND TRIP

CREATE TABLE Finance(
payement_id INT IDENTITY, 
user_id INT, 
type varchar(30), 
amount DECIMAL(13,2), 
currency varchar(3), 
method varchar(10), 
status varchar(10), 
date DATETIME, 
receipt_no INT,
deadline DATETIME,
penalty DECIMAL,
PRIMARY KEY(payement_id),
FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
);
-- USER

CREATE TABLE Health(
user_id INT, 
date DATETIME, 
activity varchar(10), 
hours_slept INT,
food varchar(10),
PRIMARY KEY(date, activity),
FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
);

-------------------------------------------------
CREATE TABLE Communication(
message_id INT PRIMARY KEY IDENTITY,
sender_id int, 
reciever_id int,
content varchar(200), 
time_sent DATETIME, 
time_received DATETIME, 
time_read DATETIME,
title varchar(30)
FOREIGN KEY(sender_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(reciever_id) REFERENCES Users 
);



CREATE TABLE Device(
device_id  INT PRIMARY KEY,
room INT,
type varchar(20), 
status varchar(20), 
battery_status INT,
FOREIGN KEY(room) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE RoomSchedule(
creator_id INT , 
action varchar(20), 
room INT,
start_time DATETIME , 
end_time DATETIME,
PRIMARY KEY(creator_id, start_time),
FOREIGN KEY(creator_id) REFERENCES Users,
FOREIGN KEY(room) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Log(
room_id INT, 
device_id INT, 
user_id INT,
activity varchar(30), 
date DATETIME,
duration varchar(50),
PRIMARY KEY(room_id, device_id, user_id,date),
FOREIGN KEY(room_id) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(device_id) REFERENCES Device,
FOREIGN KEY(user_id) REFERENCES Users
);


--------------------------------------------
USE HomeSync;

CREATE TABLE Consumption(
date DATETIME,
device_id INT,
consumption INT,
PRIMARY KEY(device_id , date),
FOREIGN KEY(device_id) REFERENCES Device ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Preferences(
user_id INT,
preference_no INT,
category varchar(20),
content varchar(20),
PRIMARY KEY(user_id ,preference_no),
FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Recommendation(
recommendation_id INT PRIMARY KEY IDENTITY,
user_id INT,
category varchar(20),
preference_no INT,
content varchar(20),
FOREIGN KEY(user_id, preference_no) REFERENCES Preferences ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(user_id) REFERENCES Users 
);


CREATE TABLE Inventory(
supply_id INT PRIMARY KEY ,
name varchar(30),
quantity INT,
expiry_date DATETIME,
price decimal(10,2),
manufacturer varchar(30),
category varchar(20), 
);


CREATE TABLE Camera(
monitor_id INT,
camera_id INT,
room_id INT,
PRIMARY KEY(monitor_id),
FOREIGN KEY(room_id) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (monitor_id) REFERENCES Users
);

CREATE TABLE DeletedGuests(
email varchar(50)
);


INSERT INTO Room
VALUES
('living', 1, 'free'),
('bedroom', 2, 'occupied'),
('bedroom', 3, 'occupied'),
('bedroom', 2, 'occupied'),
('bedroom', 3, 'occupied'),
('bedroom', 4, 'free'),
('kitchen', 1, 'free'),
('garden', 0, 'free');

INSERT INTO Users
VALUES
('Sarah', 'El-Feel', '12345678', 'sarah.elfeel@gmail.com', 'dark mode', 1, 'Admin', '05/10/2004'),
('Malak', 'Abdelbaki', 'abcdefgh', 'malak.ismail@gmail.com', 'no preference', 8, 'Admin', '09/28/2004'),
('Toqa', 'Amr', 'hello123', 'toqa.amr@gmail.com', 'no preference', 1, 'Admin', '11/06/2004'),
('Phebe', 'Atef', 'database10', 'phebe.atef@gmail.com', 'default preference', 3, 'Admin', '08/10/2004'),
('Ahmed', 'Mohamed', 'project@40', 'ahmed123@gmail.com', 'light mode', 4, 'Admin', '11/11/2002'),
('Kareem', 'Ahmed', 'Kareem2005', 'kareem.ahmed@gmail.com', 'default', 1, 'Guest', '11/04/2005'),
('Mariam', 'Ahmed', 'Mariam2010', 'mariam.ahmed@gmail.com', 'no preference', 5, 'Guest', '06/04/2010'),
('Mariam', 'Eid', 'Eid2004', 'mariam.eid@gmail.com', 'no preference', 6, 'Guest', '12/04/2004'),
('Eyad', 'Hesham', 'NoRiskNoFu', 'eyad@gmail.com', 'default', 7, 'Guest', '09/21/2004'),
('Zeina', 'Ismail', 'Zonzon9', 'zeina@gmail.com', 'dark mode', 4, 'Guest', '09/07/2004'),
('Mustafa', 'Ahmed', 'GIU123', 'mustafa@hotmail.com', 'default', 2, 'Guest', '09/07/1970');



INSERT INTO Admin
VALUES
(1, 4, 1000),
(2, 2, 2000),
(3, 1, 2500.5),
(4, 3, 1920),
(5, 1, 1891);



INSERT INTO Guest
VALUES
(6, 1, 'Cairo', '12/12/2023', '05/05/2024', 0),
(7, 1, 'Giza', '11/11/2023', '06/05/2025', 1),
(8, 2, 'Augsburg', '04/04/2023', '09/09/2027', 1),
(9, 1, 'Mannheim', '06/06/2023', '08/08/2027', 1),
(10, 4, 'Cairo', '07/07/2023', '01/01/2024', 1),
(11,5, 'Dubai', '1/1/2023', '12/12/2024', 0);


INSERT INTO Task
VALUES
('Math', '11/18/2023', '12/04/2023', 'Assignment', 1, 'not done', '12/03/2023', 1),
('Database M3', '01/01/2024', '01/31/2024', 'Project', 2, 'not done', '01/29/2024', 2),
('Prog', '11/01/2023', '11/15/2023', 'Project', 3, 'not done', '11/14/2023', 3);


INSERT INTO Assigned_to
VALUES
(2, 2, 8);

INSERT INTO Calendar
VALUES
(1, 9, 'Christmas', 'Festival', 'Berlin', '12/23/2023'),
(2, 1, 'Finals', 'Exams', 'Cairo', '01/01/2024');

INSERT INTO Notes
VALUES
(1, 1, 'flight tickets', '12/27/2023', 'Travel'),
(2, 6, 'studying', '09/09/2023', 'Uni');

INSERT INTO Travel
VALUES
(1, 'Kempinski', 'Dubai', 182, 188, '02/03/2024', '02/09/2024', 'Dubai', 'Cairo', 'Bus'),
(2, 'Fairmont', 'Cairo', 363, 918, '05/05/2022', '06/06/2022', 'Cairo', 'Berlin', 'Uber'),
(3, 'Novotel', 'Munich', '102', '103', '1/1/2023', '12/12/2023', 'Cairo', 'Munich', 'Bus');

INSERT INTO User_trip
VALUES (1, 1, 2, 128,818 )


INSERT INTO RoomSchedule
VALUES
(1, 'Karaoke', 1, '12/04/2023', '12/05/2023'),
(8, 'Cooking', 6, '11/04/2023', '11/05/2023');


INSERT INTO Device
VALUES
(1, 2, 'Desktop', 'free', 90),
(2,3, 'Laptop', 'occupied', 81),
(3,4, 'Smart TV', 'free', 72),
(4,3, 'Ipad', 'occupied', 0),
(5,1, 'Smart TV', 'free', 81),
(7,3, 'tv', 'in use', 0),
(8,3,'ipad', 'in use', 0),
(9, 1, 'Tablet', 'free', 100);

INSERT INTO Log
VALUES
(3, 2, 4, 'studying', '11/24/2023', 5);


INSERT INTO Communication
VALUES
(1, 6, 'HBD', '11/04/2023', '11/04/2023', '11/04/2023', 'birthday'),
(4, 2, 'Which page', '05/05/2022', '05/06/2022', '05/06/2022', 'work');

INSERT INTO Finance
VALUES
(1, 'outgoing', 1872, 'EGP', 'deposit', 'accepted', '07/07/2023', 161615, '07/31/2023', 0),
(7, 'ingoing', 167511, 'USD', 'transfer', 'accepted', '08/31/2022', 52542, '09/20/2023', 0);

INSERT INTO Health
VALUES
(1, '11/05/2023', 'cycling', 5, 'pasta'),
(2, '11/06/2023', 'gym', 8, ' bread');

INSERT INTO Preferences VALUES (6,1,'studying', 'study at night');
INSERT INTO Recommendation VALUES (6,'UNI',1,'start at 8');




INSERT INTO Inventory
VALUES
(1, 'oil', 2, '11/11/2024', 30, 'Crystal', 'Food'),
(2, 'light bulbs', 0, '12/12/2024', 77, 'Philips', 'Electronics'),
(3, 'chipsy', 0, '12/4/2023', 10, 'Lion', 'Food');

INSERT INTO Camera
VALUES
(1, 1, 6),
(5, 2, 4);


INSERT INTO Consumption
VALUES
('11/11/2023', 3, 120),
('4/4/2023', 2, 570),
('12/12/2024', 9, 9999);









