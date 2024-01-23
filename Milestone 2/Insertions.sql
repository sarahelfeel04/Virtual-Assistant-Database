use HomeSync


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




