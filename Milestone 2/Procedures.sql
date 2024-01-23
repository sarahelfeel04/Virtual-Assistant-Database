
 

use HomeSync;

go

/* 1.1 Sarah
Register on the website with a unique email along with the needed information. Choose which type
of user you will be using @usertype (Admin).
Signature:
Name: UserRegister.
Input: @usertype varchar(20), @userName varchar(20), @email varchar(50), @first_name varchar(20),
@last_name varchar(20), @birth_date datetime, @password varchar(10).
Output: user_id int.
*/

CREATE PROCEDURE UserRegister 
@usertype varchar(20), 
@email varchar(50), 
@first_name varchar(20), 
@last_name varchar(20), 
@birth_date datetime, 
@password varchar(10),
@user_id int OUTPUT
AS 
BEGIN
IF NOT EXISTS (SELECT 1 FROM Users WHERE email = @email) AND @usertype ='Admin'
BEGIN
	INSERT INTO Users (f_Name,l_Name,password,email, birthdate, type) 
	VALUES (@first_name , @last_name, @password, @email, @birth_date, @usertype);
  
	SELECT @user_id = id
	FROM Users
	WHERE f_Name=@first_Name AND l_Name=@last_name 
	AND email=@email AND password=@password 

  INSERT INTO Admin (admin_id, no_of_guests_allowed) values (@user_id, 30);
END 

ELSE IF NOT EXISTS (SELECT 1 FROM Users WHERE email = @email) AND @usertype ='Guest'
BEGIN
	INSERT INTO Users (f_Name,l_Name,password,email, birthdate, type) 
	VALUES (@first_name , @last_name, @password, @email, @birth_date, @usertype);
  
	SELECT @user_id = id
	FROM Users
	WHERE f_Name=@first_Name AND l_Name=@last_Name 
	AND email=@email AND password=@password 

INSERT INTO Guest (guest_id) values (@user_id);
END   

ELSE
SET @user_id = -1;

END;
GO;


/* 2.1 Sarah
Login using my email and password. In the event that the user is not registered, the @user_id value
will be (-1).
Signature:
Name: UserLogin.
Input: @email varchar(50), @password varchar(10).
Output: @success bit , @user_id int
*/

CREATE PROCEDURE UserLogin
@email varchar(50), @password varchar(10),
@success bit OUTPUT, @user_id int OUTPUT
AS
BEGIN
IF EXISTS (SELECT 1 FROM Users WHERE email = @email AND password = @password)
	BEGIN
	SET @success = 1
	SELECT @user_id = id
	FROM Users
	WHERE email = @email AND password = @password
	END
ELSE
	BEGIN 
	SET @success=0
	SET @user_id = -1;
	END

END;
GO


/* 2.2 Toqa
View all the details of my profile.
Signature:
Name: ViewProfile.
Input: @user_id int.
Output: Table containing the user details.
*/
CREATE PROCEDURE ViewProfile 
@user_id int
AS
BEGIN
SELECT * 
FROM Users
WHERE ID = @user_id;
END;

GO;



/* 2.4 Sarah
View their task. (You should check if the deadline has passed or not if it passed set the status to
done).
Signature:
Name: ViewMyTask.
Input: @user_id int.
Output: Table containing all the details of the tasks
*/

CREATE PROCEDURE ViewMyTask
@user_id int
AS
BEGIN
    UPDATE Task
    SET status = 'Done'
    WHERE creator = @user_id AND due_date < CURRENT_TIMESTAMP;

SELECT *
FROM Task
WHERE creator = @user_id

END;
GO;


/* 2.5 Sarah
Finish their task.
Signature:
Name: FinishMyTask.
Input: @user_id int, @title varchar(50).
Output: Nothing.
*/

CREATE PROCEDURE FinishMyTask
@user_id int, 
@title varchar(50)
AS
BEGIN
    UPDATE Task
    SET status = 'Done'
    WHERE creator = @user_id AND name=@title ;

END;
GO;

/* 2.6 Sarah
View task status given the @user_id and the @creator of the task. (The recently created reports
should be shown first).
Signature:
Name: ViewTask.
Input: @user_id int, @creator int.
Output: Table containing all details of the task(s).
*/

CREATE PROCEDURE ViewTask
@user_id int, 
@creator int
AS
BEGIN
		SELECT t.* 
		FROM Assigned_to a INNER JOIN Task t on a.task_id=t.Task_id 
		WHERE a.admin_id=@creator AND a.user_id=@user_id
		ORDER BY t.creation_date DESC;
		
END;
GO;

/* 2.7 Phebe
View device charge.
Signature:
Name: ViewMyDeviceCharge.
Input: @device_id int.
Output: @charge int, @location int.
*/

CREATE PROCEDURE ViewMyDeviceCharge
@device_id int,
@charge int OUTPUT, 
@location int OUTPUT
AS
BEGIN
SELECT @charge = battery_status  ,@location= room
FROM Device 
WHERE device_id = @device_id
END;

GO;


/* 2.8 Phebe
Book a room with other users.
Signature:
Name: AssignRoom.
Input: @user_id int,@room_id int.
Output: Nothing.
*/

CREATE PROCEDURE AssignRoom
    @user_id INT,
    @room_id INT
AS
BEGIN
IF EXISTS (SELECT 1 FROM Room WHERE room_id = @room_id AND status <> 'Booked')
AND EXISTS (SELECT 1 FROM Users WHERE id = @user_id )
    BEGIN
        UPDATE Users
        SET room = @room_id
        WHERE id = @user_id;

        UPDATE Room
        SET status = 'Booked'
        WHERE room_id = @room_id;
END;
ELSE
print 'room booked'
END;

GO;

/* 2.9 Sarah
Create events on the system.
Signature:
Name: CreateEvent.
Input:@event_id Int @user_id int, @name varchar(50), @description varchar(200), @location varchar(40),@reminder_date datetime ,@other_user_id int.
Output: Nothing
*/

CREATE PROCEDURE CreateEvent
@event_id int,
@user_id int, 
@name varchar(50), 
@description varchar(200), 
@location varchar(40), 
@reminder_date datetime,
@other_user_id int

AS 
BEGIN 
IF EXISTS (select 1 from Calendar where name=@name AND event_id=@event_id 
AND user_assigned_to=@user_id AND description=@description 
AND location=@location AND reminder_date=@reminder_date)
print 'event exists already'

ELSE
BEGIN
	INSERT INTO Calendar (event_id, user_assigned_to, name, description, location, reminder_date)
	VALUES (@event_id, @user_id, @name, @description, @location, @reminder_date);

	IF @other_user_id IS NOT NULL
	INSERT INTO Calendar (event_id, user_assigned_to, name, description, location, reminder_date)
	VALUES (@event_id, @other_user_id, @name, @description, @location, @reminder_date);
	

END
END
GO;

/* 2.10 Sarah
Assign user to attend event.
Signature:
Name: AssignUser.
Input: @user_id int, @event_id int.
Output: @user_id and all details of the event that the employee is assigned to.
*/

CREATE PROCEDURE AssignUser
@user_id int, 
@event_id int
AS
BEGIN
IF EXISTS (SELECT 1 FROM Calendar WHERE event_id = @event_id)
	BEGIN
	if exists(SELECT 1 FROM Calendar WHERE user_assigned_to=@user_id)
	PRINT 'User already assigned to event'
ELSE
begin
		DECLARE @name varchar(50); 
		DECLARE @description varchar(200);
		DECLARE @location varchar(40); 
		DECLARE @reminder_date datetime; 
		
		SELECT @name = name, @description=description, @location=location, @reminder_date=reminder_date
		FROM Calendar
		WHERE event_id=@event_id
		
	
		INSERT INTO Calendar (event_id, user_assigned_to, name, description, location, reminder_date)
		VALUES (@event_id, @user_id, @name, @description, @location, @reminder_date);
	
		
		SELECT *
		FROM Calendar
		WHERE event_id=@event_id AND user_assigned_to=@user_id;
		end
	END;
ELSE
    PRINT 'Event does not exist';

END;

GO

/* 2.11 Sarah
Add a reminder to a task.
Signature:
Name: AddReminder.
Input: @task_id int, @reminder datetime.
Output: Nothing.
*/

CREATE PROCEDURE AddReminder
@task_id int, 
@reminder datetime
AS
BEGIN
IF NOT EXISTS (select 1 from Task where Task_id=@task_id)
print 'task does not exist'
ELSE
BEGIN
	UPDATE Task
	SET reminder_date = @reminder
	WHERE Task_id = @task_id;
END
END
GO;

/* 2.12 Sarah
Uninvite a specific user to an event.
Signature:
Name: Uninvited.
Input: @event_id int, @user_id int.
Output: Nothing.
*/

CREATE PROCEDURE Uninvited
@event_id int, 
@user_id int
AS
BEGIN
	IF NOT EXISTS (select 1 from Calendar where event_id=@event_id AND user_assigned_to=@user_id)
	print 'Event does not exist'
	ELSE
	DELETE 
	FROM Calendar 
	WHERE event_id=@event_id AND user_assigned_to=@user_id;
END;
GO;



/* 2.13 Sarah
Update the deadline of a specific task.
Signature:
Name: UpdateTaskDeadline.
Input: @deadline datetime, @task_id int.
Output: Nothing.
*/

CREATE PROCEDURE UpdateTaskDeadline
@deadline datetime, 
@task_id int
AS
BEGIN
	IF NOT EXISTS (select 1 from Task where Task_id=@task_id )
	PRINT 'task does not exist'
	ELSE
	UPDATE Task
	SET due_date = @deadline
	WHERE Task_id=@task_id
END;
GO;

/* 2.14 Sarah
View their event given the @event_id and if the @event_id is empty then view all events that
belong to the user order by their date.
Signature:
Name: ViewEvent.
Input: @User_id int, @Event_id int.
Output: Table containing all the events details
*/

CREATE PROCEDURE ViewEvent
@User_id int, 
@Event_id int
AS
BEGIN
IF EXISTS (SELECT 1 FROM Calendar WHERE event_id = @Event_id AND user_assigned_to=@User_id)
SELECT *
FROM Calendar
WHERE event_id = @Event_id AND user_assigned_to=@User_id;

ELSE
SELECT *
FROM Calendar
WHERE user_assigned_to=@User_id
ORDER BY reminder_date;

END;
GO;



/* 2.15 Toqa
View users that have no recommendations.
Signature:
Name: ViewRecommendation.
Input: Nothing.
Output: Table containing names of users.
*/
CREATE PROCEDURE ViewRecommendation
AS
BEGIN
SELECT f_Name , l_name 
FROM Users U
    WHERE U.id NOT IN (SELECT user_id FROM Recommendation);

END;

GO;


/* 2.16 Malak
Create new note.
Signature:
Name: CreateNote.
Input: @User_id int, @note_id int, @title varchar(50), @Content varchar(500), @creation_date
datetime.
Output: Nothing.
*/
CREATE PROCEDURE CreateNote
@User_id int, 
@note_id int,
@title varchar(50), 
@Content varchar(500), 
@date_of_creation datetime
AS
BEGIN
	if @User_id IS NOT NULL AND @note_id IS NOT NULL 
	AND (EXISTS(SELECT * FROM Users WHERE Users.id = @User_id))
	INSERT INTO Notes VALUES (@note_id, @User_id, @Content, @date_of_creation, @title)

	ELSE
	PRINT 'Please enter a valid user id and note id'
END;
go;

/* 2.17 Malak
Receive a transaction.
Signature:
Name: ReceiveMoney.
Input: @sender_id int, @type varchar(30), @amount decimal(13,2), @status varchar(10), @date
datetime.
Output: Nothing.
*/
CREATE PROCEDURE ReceiveMoney
@receiver_id int, 
@type varchar(30), 
@amount decimal(13,2), 
@status varchar(10),
@date datetime
AS
BEGIN
	IF @receiver_id IS NOT NULL 
		AND (EXISTS(SELECT * FROM Users WHERE Users.id = @receiver_id))

	INSERT INTO Finance(user_id, type, amount ,status, date) 
		VALUES (@receiver_id, @type, @amount, @status, @date)
	ELSE
	PRINT 'Please enter a valid user id'
-- insert one record
END;

GO




/* 2.18 Malak
Create a payment on a specific date.
Signature:
Name: PlanPayment.
Input: @sender_id int, @reciever_id int , @amount decimal(13,2), @status varchar(10), @deadline datetime.
Output: Nothing
*/

CREATE PROCEDURE PlanPayment
@sender_id int, 
@reciever_id int , 
@amount decimal(13,2), 
@status varchar(10),
@deadline datetime
AS
BEGIN
if @sender_id IS NOT NULL AND @reciever_id IS NOT NULL
AND (EXISTS(SELECT * FROM Users WHERE Users.id = @sender_id))
AND (EXISTS(SELECT * FROM Users WHERE Users.id = @reciever_id))
	INSERT INTO Finance(user_id, type, amount ,status, deadline)  
	VALUES (@sender_id, 'outgoing', @amount, @status, @deadline),
	(@reciever_id, 'ingoing', @amount, @status , @deadline)
	ELSE
	PRINT 'Please enter a valid sender id and receiver id'
-- insert two record

END;

GO

GO



/* 2.19 Phebe
Send message to user.
Signature:
Name: SendMessage.
Input: @sender_id int, @receiver_id int, @title varchar(30), @content Varchar(200), @timesent
time, @timereceived time.
Output: Nothing.
*/
CREATE PROCEDURE SendMessage
@sender_id int, 
@receiver_id int,
@title varchar(30), 
@content Varchar(200), 
@timesent datetime, 
@timereceived datetime
AS
BEGIN
IF EXISTS (select * from Users where id=@sender_id ) AND EXISTS (select * from Users where id=@receiver_id )
INSERT INTO Communication (sender_id, reciever_id ,content, time_sent , time_received , title)
VALUES( @sender_id, @receiver_id ,@content,@timesent,@timereceived,@title)
ELSE
print 'sender or receiver invalid'
END;

GO


/* 2.20 Malak
Change note title for all notes user created.
Signature:
Name: NoteTitle.
Input: @user_id int,@note_title varchar(50).
Output: Nothing.
*/
CREATE PROCEDURE NoteTitle
@user_id int,@note_title varchar(50)
AS
BEGIN
	IF @user_id IS NOT NULL AND @note_title IS NOT NULL
	AND (EXISTS(SELECT * FROM Users WHERE Users.id = @user_id))
	UPDATE Notes
	SET title = @note_title
	WHERE user_id = @user_id

	ELSE
	PRINT 'Please enter a valid user id and note title'
END;

GO

/* 2.21 Phebe
Show all messages received from a spacific user.
Signature:
Name: ShowMessages.
Input: @user_id int, @sender_id int.
Output: Table Containing all details of these massages.
*/

CREATE PROCEDURE ShowMessages
@user_id int, 
@sender_id int
AS
BEGIN
SELECT *
FROM Communication
WHERE (reciever_id = @user_id AND sender_id = @sender_id);
END;

GO


/* 3.1 Toqa
See details of all users and filter them by @user_type
Signature:
Name: ViewUsers.
Input: @user_type varchar(20)
Output: table containing details of the users
*/

CREATE PROCEDURE ViewUsers 
@user_type varchar(20)
AS
BEGIN
IF @user_type = 'Guest' 
SELECT *
FROM Users 
WHERE type='Guest';
else 
SELECT *
FROM Users 
WHERE type='Admin'

END;
GO;

/* 3.2 Sarah
Remove an event from the system.
Signature:
Name: RemoveEvent.
Input: @event_id int, @user_id int.
Output: Nothing.
*/
CREATE PROCEDURE RemoveEvent
@event_id int, 
@user_id int
AS
BEGIN
IF NOT EXISTS (SELECT 1 FROM Calendar WHERE event_id = @event_id AND user_assigned_to=@user_id)
PRINT 'event does not exist'
ELSE
DELETE
FROM Calendar
WHERE event_id = @event_id AND user_assigned_to=@user_id;

END;
GO;


/* 3.3 Phebe
Create schedule for the rooms.
Signature:
Name: CreateSchedule.
Input: @creator_id int, @room_id int, @start_time datetime, @end_time datetime, @action varchar(20).
Output: Nothing.
*/

CREATE PROCEDURE CreateSchedule
@creator_id int, 
@room_id int,
@start_time datetime, 
@end_time datetime, 
@action varchar(20)
AS
BEGIN
IF EXISTS (select * from Admin where admin_id=@creator_id)
AND EXISTS (select * from Room where room_id=@room_id)
INSERT INTO RoomSchedule(creator_id, action, room, start_time, end_time)
    VALUES (@creator_id, @action, @room_id, @start_time, @end_time);
ELSE
print 'user or room does not exist'
END;


GO;


/* 3.4 Malak
Remove a guest from the system.
Signature:
Name: GuestRemove.
Input: @guest_id int, @admin_id int.
Output: @number_of_allowed _guests int.
*/
CREATE PROCEDURE GuestRemove
@guest_id int, 
@admin_id int,
@number_of_allowed_guests int OUTPUT
AS
BEGIN
	IF @guest_id IS NOT NULL AND @admin_id IS NOT NULL
	AND (EXISTS(SELECT * FROM Guest WHERE Guest.guest_id = @guest_id))
	AND (EXISTS(SELECT * FROM Admin WHERE Admin.admin_id = @admin_id))
	BEGIN
	DELETE FROM Users
	WHERE id = @guest_id;

	DECLARE @cnt INT;
	SELECT @cnt = COUNT(*)
	From Guest
	WHERE guest_of = @admin_id;

	DECLARE @limit INT;
	SELECT @limit = no_of_guests_allowed
	FROM Admin
	WHERE admin_ID = @admin_id;
	
	SET @number_of_allowed_guests = @limit - @cnt;
	END
	ELSE 
	PRINT 'Please enter a valid guest id and admin id'

END;

GO


/* 3.5 Malak
Recommend travel destinations for guests under certain age.
Signature:
Name: RecommendTD.
Input: @Guest_id int, @destination varchar(10), @age int , @preference_no int.
Output: Nothing
*/

CREATE PROCEDURE RecommendTD
@Guest_id int, 
@destination varchar(10), 
@age int, 
@preference_no int
AS
BEGIN
	IF @Guest_id IS NOT NULL  
	AND @preference_no IS NOT NULL
	AND EXISTS(SELECT * FROM Guest WHERE Guest.guest_id = @Guest_id)
	AND EXISTS(SELECT * FROM Preferences WHERE Preferences.preference_no = @preference_no AND user_id=@guest_id)
	BEGIN

	IF EXISTS(SELECT * FROM Users WHERE Users.id = @Guest_id AND Users.age < @age)
	INSERT INTO Recommendation VALUES (@Guest_id,'Travel', @preference_no, @destination)
	ELSE
	PRINT 'Please enter a valid age'

	END

	ELSE
	PRINT 'Please enter a valid guest id and preference number'
	--SELECT destination
	--FROM Travel INNER JOIN User_trip ON Travel.trip_no = User_trip.trip_no INNER JOIN [User].ID ON 
--check on age 
END;

GO


/* 3.6 Toqa
Access cameras in the house.
Signature:
Name: Servailance.
Input: @user_id int, @location int,@camera_id int .
Output: Nothing.
*/

CREATE PROCEDURE Servailance
@user_id int, @location int,@camera_id int
AS
BEGIN
IF EXISTS (select * from Camera where monitor_id=@user_id)
print 'Monitor already exists'
ELSE
BEGIN
IF EXISTS (select * from Admin where admin_id=@user_id) AND  EXISTS (select * from Room where room_id=@location)
AND  EXISTS (select * from Camera where camera_id=@camera_id)
INSERT INTO Camera(monitor_id,camera_id,room_id)
VALUES (@user_id,@camera_id,@location)
ELSE
print 'user or location or camera dont exist'

END;
END;

GO;


/* 3.7 Phebe
Change status of room.
Signature:
Name: RoomAvailability
Input: @location int, @status varchar(40)
Output: Nothing.
*/
CREATE PROCEDURE RoomAvailability
@location int, 
@status varchar(40)
AS
BEGIN
UPDATE Room
SET status = @status
WHERE room_id =@location
END;


GO;


/* 3.8 Toqa
Create an inventory for a specific item.
Signature:
Name:Sp_ Inventory.
Input: @item_id int„@name varchar(30), @quantity int, @expirydate datetime, @price decimal(10,2),
@manufacturer varchar(30),@category varchar(20)
Output: Nothing.
*/


CREATE PROCEDURE Sp_Inventory
@item_id int,
@name varchar(30),
@quantity int,
@expirydate datetime,
@price decimal(10,2),
@manufacturer varchar(30),
@category varchar(20)
AS
BEGIN
INSERT INTO Inventory(supply_id , name ,quantity,expiry_date ,price , manufacturer ,category )
VALUES (@item_id ,@name , @quantity , @expirydate , @price , @manufacturer ,@category)
END;

GO;

/* 3.9 Toqa
Calculate price of purchasing a certain item.
Signature:
Name: Shopping.
Input: @id int , @quantity int , @total_price decimal(10,2).
Output: @total_price decimal(10,2).
*/

CREATE PROCEDURE Shopping
@id int ,
@quantity int ,
@total_price decimal(10,2) OUTPUT
AS
BEGIN
DECLARE @new_price decimal(10,2)
SELECT @new_price = price
FROM Inventory
WHERE supply_id = @id 

SET @total_price = @new_price * @quantity
END;
GO;



/* 3.10 Phebe
 If current user had an activity set its duration to 1 hour.
Signature:
Name: LogActivityDuration .
Input: @room_id int ,@device_id int, @user_id int,@date datetime, @duration varchar(50).
Output: Nothing.
*/

CREATE PROCEDURE LogActivityDuration
@room_id int ,
@device_id int,
@user_id int,
@date datetime,
@duration varchar(50)
AS
BEGIN
UPDATE Log
SET duration = @duration
WHERE room_id = @room_id AND
     device_id =@device_id AND
     user_id = @user_id AND
     date = @date AND
     activity IS NOT NULL
END;


GO;

/* 3.11 Toqa
Set device consumption for all tablets.
Signature:
Name: TabletConsumption.
Input: @consumption int.
Output: Nothing.
*/
CREATE PROCEDURE TabletConsumption
@consumption int
AS
BEGIN
	UPDATE C
    SET C.consumption = @consumption
    FROM Consumption C
    INNER JOIN Device D ON C.device_id = D.device_id  
    WHERE D.type = 'Tablet';

END;

GO;




/* 3.12 Phebe
Make preferences for Room temperature to be 30 if a user is older then 40 .hint : ussenestedquery
Signature:
Name: MakePreferencesRoomTemp.
Input: @user_id int ,@category varchar(20), @preferences_number int .
Output: Nothing.
*/

CREATE PROCEDURE MakePreferencesRoomTemp
@user_id int ,
@category varchar(20), 
@preferences_number int
AS
BEGIN
IF EXISTS(SELECT * FROM Users WHERE id =@user_id AND age >40)
INSERT INTO Preferences (user_id, preference_no,category,content)
      VALUES (@user_id,@preferences_number,@category, 'Room temperature: 30');
ELSE
print 'normal temperature no change'
END;

GO;

/* 3.13 Phebe
View Log entries involving the user.
Signature:
Name: ViewMyLogEntry.
Input: @user_id int.
Output: Table containing all the details of the log.
*/

CREATE PROCEDURE ViewMyLogEntry
@user_id int
AS
BEGIN
SELECT *
FROM Log
WHERE user_id = @user_id
END;

GO;

/* 3.14 Phebe
Update log entries involving the user.
Signature:
Name: UpdateLogEntry.
Input: @user_id int, @room_id int, @device_id int,@activity varchar(30).
Output: Nothing.
*/

CREATE PROCEDURE UpdateLogEntry
@user_id int, 
@room_id int, 
@device_id int,
@activity varchar(30)
AS
BEGIN
IF EXISTS (select * from Room where room_id=@room_id) AND EXISTS (select * from Device where device_id=@device_id)
UPDATE Log 
SET activity = @activity,
     room_id = @room_id,
     device_id = @device_id
 WHERE user_id = @user_id;
 ELSE
 print 'room or device do not exist'
 END;

 GO;

 /* 3.15 Phebe
View rooms that are not being used.
Signature:
Name: ViewRoom.
Input: Nothing.
Output: Table containing all details of the Rooms.
 */

 CREATE PROCEDURE ViewRoom
AS 
BEGIN
SELECT * 
FROM Room
WHERE status <> 'Booked'
END;

Go;

/* 3.16 Phebe
View the details of the booked rooms given @user_id and @room_id . (If @room_id is not booked
then show all rooms that are booked by this user).
Signature:
Name: ViewMeeting.
Input: @room_id int, @user_id int.
Output: Table containing all details of the activity and table containing name of each use
*/

CREATE PROCEDURE ViewMeeting
    @room_id int, 
    @user_id int
AS
BEGIN
    IF EXISTS (SELECT * FROM LOG WHERE room_id = @room_id AND user_id = @user_id)
    BEGIN
        SELECT U.f_Name, U.l_Name, L.activity, L.date, L.duration
        FROM Log L 
        INNER JOIN Users U ON L.user_id = U.id
        WHERE L.room_id = @room_id AND L.user_id = @user_id;
    END
    ELSE
    BEGIN
        SELECT room_id
        FROM Log L 
        WHERE user_id = @user_id;
    END
END;

GO


/* 3.17 Toqa
Add to the tasks.
Signature:
Name: AdminAddTask.
Input: @user_id int , @creator int ,@name varchar(30), @category varchar(20), @priority Int,@status
varchar(20), @reminder datetime , @deadline datetime , @other_user varchar(20), @deadline datetime.
Output: Nothing.
*/

CREATE PROCEDURE AdminAddTask 
@user_id int ,
@creator int ,
@name varchar(30),
@category varchar(20),
@priority Int,
@status varchar(20),
@reminder datetime ,
@deadline datetime ,
@other_user int

---there is 2 deadline , so we removed one of them
AS
BEGIN

IF EXISTS (select * from Admin where admin_id = @creator)
BEGIN 
	INSERT INTO Task(name ,creation_date,due_date,category,creator ,status,reminder_date,priority)
	VALUES (@name,CURRENT_TIMESTAMP,@deadline,@category,@creator ,@status,@reminder,@priority)
	declare @task_id int 
	select top 1 @task_id=task_id from Task where creator = @creator order by task_id desc
	print @task_id
	IF EXISTS (select 1 from Users where id = @user_id)
	      INSERT INTO Assigned_to VALUES (@creator, @task_id, @user_id)
	ELSE
	     print 'user does not exist'
	IF @other_user IS NOT NULL  AND EXISTS (select * from Users where id=@other_user)
	     INSERT INTO Assigned_to VALUES (@creator, @task_id, @other_user)
	ELSE
	     print 'other user does not exist'
END
ELSE
    print 'creator does not exist'
END;
GO;


/* 3.18 Sarah
 Add Guests to the system , generate passwords for them and reserve rooms under their name.
Signature:
Name: AddGuest.
Input: @email varchar(30), @first_name varchar(10) ,@address varchar (30),@password varchar(30),@guest_of
int,@room_id int
Output: @number_of_allowed _guests in
*/


CREATE PROCEDURE AddGuest
  @email varchar(50), 
  @first_name varchar(20), 
  @last_name varchar(20), 
  @address varchar(30), 
  @password varchar(10),
  @guest_of int,
  @room_id int, 
  @birth_date datetime,
  @number_of_allowed_guests int OUTPUT
AS
BEGIN
  DECLARE @admin_exists int;

  SELECT @admin_exists = COUNT(*)
  FROM Users
  WHERE id = @guest_of AND type = 'Admin';

  IF @admin_exists = 0
  BEGIN
    PRINT 'Admin does not exist';
  END
  ELSE
  BEGIN
    SELECT @number_of_allowed_guests = COUNT(*)
    FROM Guest
    WHERE guest_of = @guest_of;

    IF (@number_of_allowed_guests < (SELECT no_of_guests_allowed FROM Admin WHERE admin_id = @guest_of))
    BEGIN
      INSERT INTO Users (f_Name, l_Name, password, email, room, type, birthdate) 
      VALUES (@first_name, @last_name, @password, @email, @room_id, 'Guest', @birth_date);
  
      DECLARE @user_id int;

      SELECT @user_id = id
      FROM Users
      WHERE f_Name = @first_name AND l_Name = @last_name AND email = @email AND password = @password AND room = @room_id AND birthdate = @birth_date;

      INSERT INTO Guest (guest_id, guest_of, address) 
      VALUES (@user_id, @guest_of, @address);
 
      SELECT @number_of_allowed_guests = COUNT(*)
      FROM Guest
      WHERE guest_of = @guest_of;

      SET @number_of_allowed_guests = (SELECT no_of_guests_allowed FROM Admin WHERE admin_id = @guest_of) - @number_of_allowed_guests;
    END
    ELSE
    BEGIN
      PRINT 'No more guests allowed';
    END
  END
END;


GO;

/* 3.19 Sarah
Assign task to a specific User.
Signature:
Name: AssignTask.
Input: @user_id int , @task_id int , @creator_id int.
Output: Nothing.
*/


CREATE PROCEDURE AssignTask
@user_id int, 
@task_id int,
@creator_id int
AS
BEGIN
	
	IF EXISTS (SELECT 1 FROM Task WHERE Task_id = @task_id AND creator=@creator_id) 
	AND EXISTS (SELECT 1 FROM Users WHERE Users.id=@user_id)
		INSERT INTO Assigned_to VALUES (@creator_id, @task_id, @user_id)
	ELSE
	print 'task does not exist'

END;
GO;



/* 3.20 Phebe
Delete last message sent.
Signature:
Name: DeleteMsg.
Input: Nothing.
Output: Nothing.
*/
CREATE PROCEDURE  DeleteMsg
AS
BEGIN
DELETE
FROM Communication
WHERE time_sent = (SELECT MAX(time_sent) FROM Communication);
END;
GO;


/* 3.21 Malak
Add outgoing flight itinerary for a specific flight.
Signature:
Name: AddItinerary.
Input: @@trip_no int,@flight_num varchar(30) ,@flight_date datetime ,@destination varchar(40).
Output: Nothing
*/

CREATE PROCEDURE AddItinerary
@trip_id int,
@flight_num varchar(30) ,
@flight_date datetime ,
@destination varchar(40)
AS
BEGIN
	IF @trip_id IS NOT NULL 
		UPDATE Travel
		SET outgoing_flight_date = @flight_date,
			outgoing_flight_num = @flight_num, 
			destination = @destination
		WHERE trip_no = @trip_id
		
	ELSE
	PRINT 'Please enter a valid trip id'
END;

GO
/* 3.22 Malak
Change flight date to next year for all flights in current year.
Signature:
Name: ChangeFlight.
Input: Nothing.
Output: Nothing
*/

CREATE PROCEDURE ChangeFlight
AS
BEGIN
	UPDATE Travel
	SET ingoing_flight_date = DATEADD(YEAR, 1, ingoing_flight_date)
	WHERE YEAR(ingoing_flight_date) = YEAR(GETDATE());

	UPDATE Travel
	SET outgoing_flight_date = DATEADD(YEAR, 1, outgoing_flight_date)
	WHERE YEAR(outgoing_flight_date) = YEAR(GETDATE());
	
	END;

GO

/* 3.23 Malak
Update incoming flights.
Signature:
Name: UpdateFlight.
Input: @date datetime, @time time, @destination varchar(15)
Output: Nothing
*/

CREATE PROCEDURE UpdateFlight
@trip_id INT,
@date datetime, 
@destination varchar(15)
AS
BEGIN
	IF @trip_id IS NOT NULL 
	AND EXISTS(SELECT * FROM Travel WHERE Travel.trip_no = @trip_id)

	UPDATE Travel
	SET ingoing_flight_date = @date, destination = @destination
	WHERE trip_no = @trip_id
	ELSE
	PRINT 'Please enter a valid trip id'

END;

GO



/* 3.24 Phebe
Add a new device.
Signature:
Name: AddDevice.
Input:@device_id int, @status varchar(20), @battery int,@location int, @type varchar(20).
Output: Nothing.
*/

CREATE PROCEDURE  AddDevice
@device_id int, 
@status varchar(20), 
@battery int,
@location int, 
@type varchar(20)
AS
BEGIN
IF EXISTS (SELECT * FROM Room where room_id=@location)
INSERT INTO Device (device_id, room, type, status, battery_status) 
      VALUES (@device_id,@location,@type, @status , @battery)
ELSE
print 'room does not exist'
END;
GO;


/* 3.25 Malak
Find the location of all devices out of battery.
Signature:
Name: OutOfBattery.
Input: Nothing.
Output: List of rooms
*/

CREATE PROCEDURE OutOfBattery
AS
BEGIN
	SELECT Room.*
	FROM Device INNER JOIN Room ON Device.room = Room.room_id
	WHERE battery_status = 0
END;

GO


/* 3.26 Malak
Set the status of all devices out of battery to charging.
Signature:
Name: Charging.
Input: Nothing.
Output: Nothing
*/

CREATE PROCEDURE Charging
AS
BEGIN
	UPDATE Device
	SET battery_status =100
	WHERE battery_status = 0
END;

GO



/* 3.27 Toqa
Set the number of allowed guests for an admin.
Signature:
Name: GuestsAllowed.
Input: @admin_id int,@number_of_guests int
Output: Nothing.
*/

CREATE PROCEDURE GuestsAllowed
@admin_id int,
@number_of_guests int
AS
BEGIN
IF EXISTS (select 1 from Admin where admin_id=@admin_id )
UPDATE Admin 
SET no_of_guests_allowed = @number_of_guests
WHERE admin_id = @admin_id;
ELSE
print 'admin does not exist'
END;

GO;

/* 3.28 Malak
Add a penalty for all unpaid transactions where the deadline has passed.
Signature:
Name: Penalize.
Input: @Penalty_amount int.
Output: Nothing.
*/

CREATE PROCEDURE Penalize 
@Penalty_amount int
AS
BEGIN
	UPDATE Finance
	SET penalty = @Penalty_amount
	WHERE deadline<GETDATE()
END;

GO


/* 3.29 Toqa
Get the number of all guests currently present for a certain admin.
Signature:
Name: GuestNumber.
Input: @admin_id int.
Output: The Number of all guests currently present .
*/

CREATE PROCEDURE GuestNumber
@admin_id int
AS
BEGIN
SELECT  COUNT(*)
FROM Admin A 
INNER JOIN Guest G ON A.admin_id = G.guest_of
WHERE A.admin_id = @admin_id;
END;
GO

/* 3.30 Toqa
Get the youngest user in the system (hint : use limit).
Signature:
Name: Youngest.
Input: Nothing.
Output: The youngest user in the system.
*/

CREATE PROCEDURE Youngest
AS
BEGIN
SELECT TOP 1 f_Name ,l_Name ,age 
FROM Users
ORDER BY age ASC

END;

GO;



/* 3.31 Malak
Get the users whose average income per month is greater then a specific amount.
Signature:
Name: AveragaPayment.
Input: @amount decimal (10,2).
Output: Table Containing users names
*/

CREATE PROCEDURE AveragePayment
@amount decimal (10,2)
AS
BEGIN
	SELECT Users.f_name,Users.l_name
	FROM Users 
	INNER JOIN Admin ON Users.id = Admin.admin_id
	WHERE Admin.salary > @amount;
END;

go


/* 3.32 Toqa
Get sum the sum of all purchases needed in the home inventory (assuming you need only 1 of each
missing item) .
Signature:
Name: Purchase.
Input: Nothing.
Output: The sum amount
*/

CREATE PROCEDURE Purchase
AS
BEGIN
SELECT SUM(price)
FROM Inventory
WHERE quantity < 1;
END;
GO;



/* 3.33 Phebe
Get the location where more then two devices have a dead battery.
Signature:
Name: NeedCharge.
Input: Nothing.
Output: Table Containing locations.
*/


CREATE PROCEDURE NeedCharge
AS
BEGIN
--NOTE: WE CANNOT SELECT DEVICE ID ALONE BECAUSE OF THE GROUP BY, 
--WE CAN ONLY SELECT THE GROUPED BY ATTRIBUTE AND AN AGGREGATE FUNCTION
SELECT room
FROM Device
WHERE  battery_status = 0 
GROUP BY room 
HAVING COUNT(device_id) >2;
END;
GO;



/* 3.34 Sarah
Get the admin with more then 2 guests.
Signature:
Name: Admins.
Input: Nothing.
Output: Table containing Admins names.
*/

CREATE PROCEDURE Admins
AS
BEGIN
    SELECT u.f_name, u.l_name
    FROM Users u
    INNER JOIN (
        SELECT a.admin_id
        FROM Admin a
        INNER JOIN Guest g ON a.admin_id = g.guest_of
        GROUP BY a.admin_id
        HAVING COUNT(g.guest_of) > 2
    ) AS a ON u.id = a.admin_id;
END;

GO

