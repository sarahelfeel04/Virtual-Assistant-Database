use HomeSync


--SECTION 1: UNREGISTERED USER--------

--1.1
DECLARE @user_id INT;
EXEC UserRegister 'Guest', 'moahmed@gmail.com', 'Mohamed ', 'Ibrahim', '9/28/1975', 'QRSTU', @user_id OUTPUT;
PRINT @user_id;

--SECTION 2: REGISTERED USER----------

--2.1
DECLARE @user_id INT;
DECLARE @success BIT;
EXEC UserLogin 'moahmed@gmail.com', 'QRSTU', @success OUTPUT, @user_id OUTPUT;
PRINT @user_id;
PRINT @success;

--2.2
EXEC ViewProfile 6

--2.4
EXEC ViewMyTask 3;

--2.5
EXEC FinishMyTask 1, 'Math';

--2.6
EXEC ViewTask 8, 2;

--2.7
declare @charge int
declare @location int
EXEC ViewMyDeviceCharge 2, @charge output, @location output
print @charge
print @location

--2.8
EXEC AssignRoom 9, 8

--2.9
EXEC CreateEvent 3, 2, 'Eid', 'festival', 'Cairo', '06/06/2024', 6

--2.10
EXEC AssignUser 7, 2

--2.11
EXEC AddReminder 1, '12/12/2024'

--2.12
EXEC Uninvited 2, 7

--2.13
EXEC UpdateTaskDeadline '01/02/2024', 3

--2.14
EXEC ViewEvent 9, 1

--2.15
EXEC ViewRecommendation 

--2.16
EXEC CreateNote 6, 3, 'HOMEWORK' , 'CPS', '1/1/2020'

--2.17
EXEC ReceiveMoney 6, 'deposit', 1000,'incoming', '1/1/2020'

--2.18
EXEC PlanPayment 6,8, 1000,'accepted', '1/1/2020'

--2.19
declare @date datetime
set @date = CURRENT_TIMESTAMP
exec SendMessage 3, 4, 'Hi hello', 'message', @date, '11/25/2023'

--2.20
exec NoteTitle 6, 'assignment'

--2.21
exec ShowMessages 6, 1


--SECTION 3: REGISTERED ADMIN ------------------


--3.1
EXEC ViewUsers 'Admin'

--3.2 
EXEC RemoveEvent 3, 2

--3.3
exec CreateSchedule 2, 8, '11/24/2023', '11/25/2023', 'studying'

--3.4
declare @cnt int;
exec GuestRemove 11, 5, @cnt output;
print @cnt;

--3.5
EXEC RecommendTD 6, 'Bahamas', 19, 1

--3.6
EXEC Servailance 2, 7, 1

--3.7
exec RoomAvailability 8, 'free'

--3.8
EXEC Sp_Inventory 4, 'milk', 1, '12/12/2023', 20, 'Juhayna' , 'Food' 

--3.9

declare @total_price DECIMAL(10,2)
EXEC Shopping 2, 2, @total_Price OUTPUT
PRINT @total_price

--3.10
exec LogActivityDuration 3, 2, 4, '11/24/2023', '20'

--3.11
EXEC TabletConsumption 50

--3.12
exec MakePreferencesRoomTemp 11, 'Temperature', 2

--3.13
exec ViewMyLogEntry 4

--3.14
exec UpdateLogEntry 4, 3, 2, 'sleeping'

--3.15
exec ViewRoom 

--3.16
exec ViewMeeting 3, 4

--3.17
EXEC AdminAddTask 6, 2, 'play', 'basketball', 1, 'not done', '12/24/2023', '12/25/2023', 9

--3.18
DECLARE @nrGuests int
EXEC AddGuest 'youssef@gmail.com', 'Youssef', 'Ahmed', 'Sheikh Zayed', 'Yoyo2015',2, 7, '12/13/2000', @nrGuests OUTPUT
PRINT @nrGuests

--3.19
EXEC AssignTask 9, 2, 2

--3.20
exec DeleteMsg 

--3.21
EXEC AddItinerary 1, 200, '10/2/2024','Rome'

--3.22
EXEC ChangeFlight

--3.23
EXEC UpdateFlight 1, '4/4/2024','London'

--3.24
exec AddDevice 6, 'in use', 99, 8, 'SmartPhone' 

--3.25
EXEC OutOfBattery

--3.26
EXEC Charging

--3.27
EXEC GuestsAllowed 5, 4

--3.28
EXEC Penalize 1000

--3.29
EXEC GuestNumber 1

--3.30
EXEC Youngest

--3.31
EXEC AveragePayment 1900

--3.32
EXEC Purchase

--3.33
exec NeedCharge 

--3.34
exec Admins



