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







