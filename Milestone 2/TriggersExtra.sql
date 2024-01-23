

CREATE TRIGGER DeleteGuests
ON Admin
AFTER DELETE
AS
BEGIN
	DELETE FROM Guest
	WHERE guest_of = (SELECT deleted.admin_id FROM deleted)

	DELETE FROM Assigned_to
	WHERE admin_id = (SELECT deleted.admin_id FROM deleted)
END;

GO

--CREATE TRIGGER TO DELETE Log, Recommendation, Communication, RoomSchedule when Users is deleted

CREATE TRIGGER DeleteUser
ON Users
AFTER DELETE
AS
BEGIN
	DELETE FROM Log
	WHERE user_id = (SELECT deleted.id FROM deleted)

	DELETE FROM Recommendation
	WHERE user_id = (SELECT deleted.id FROM deleted)

	DELETE FROM Communication
	WHERE reciever_id = (SELECT deleted.id FROM deleted)

	DELETE FROM RoomSchedule
	WHERE creator_id = (SELECT deleted.id FROM deleted)

END



----CREATE TRIGGER TO DELETE log when device is deleted
GO


CREATE TRIGGER DeleteDevice
ON Device
AFTER DELETE
AS
BEGIN
	DELETE FROM Log
	WHERE device_id = (SELECT deleted.device_id FROM deleted)
END

go

----CREATE TRIGGER TO DELETE assigned_to when Task is deleted

CREATE TRIGGER DeleteTask
ON Task
AFTER DELETE
AS
BEGIN
	DELETE FROM Assigned_to
	WHERE task_id = (SELECT deleted.task_id FROM deleted)
END
----------------------

--CREATE TRIGGER TO UPDATE GUESTS WHEN ADMIN IS UPDATED
GO


CREATE TRIGGER UpdateGuests
ON Admin
AFTER UPDATE
AS
BEGIN
	UPDATE Guest
	SET guest_of = inserted.admin_id
	FROM Guest
	INNER JOIN inserted ON Guest.guest_of = deleted.admin_id

	UPDATE Assigned_to
	SET admin_id = inserted.admin_id
	FROM Assigned_to
	INNER JOIN inserted ON Assigned_to.admin_id = deleted.admin_id
END

GO


--CREATE TRIGGER TO UPDATE Log, Recommendation, Communication, RoomSchedule when Users is deleted
CREATE TRIGGER UpdateUser
ON Users
AFTER UPDATE
AS
BEGIN
	UPDATE Log
	SET user_id = inserted.id
	FROM Log
	INNER JOIN inserted ON Log.user_id = deleted.id

	UPDATE Recommendation
	SET user_id = inserted.id
	FROM Recommendation
	INNER JOIN inserted ON Recommendation.user_id = deleted.id

	UPDATE Communication
	SET reciever_id = inserted.id
	FROM Communication
	INNER JOIN inserted ON Communication.reciever_id = deleted.id

	UPDATE RoomSchedule
	SET creator_id = inserted.id
	FROM RoomSchedule
	INNER JOIN inserted ON RoomSchedule.creator_id = deleted.id
END

GO

----CREATE TRIGGER TO UPDATEwhen device is deleted
CREATE TRIGGER UpdateDevice
ON Device
AFTER UPDATE
AS
BEGIN
	UPDATE Log
	SET device_id = inserted.device_id
	FROM Log
	INNER JOIN inserted ON Log.device_id = deleted.device_id
END

GO

----CREATE TRIGGER TO UPDATE assigned_to when Task is deleted
CREATE TRIGGER UpdateTask
	ON Task
AFTER UPDATE
AS
BEGIN
	UPDATE Assigned_to
	SET task_id = inserted.task_id
	FROM Assigned_to
	INNER JOIN inserted ON Assigned_to.task_id = deleted.task_id
END
