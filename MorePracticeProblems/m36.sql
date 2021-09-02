SELECT 
	o1.SalesOrderID, 
	e.EventName, 
    DATE_FORMAT(o1.EventDateTime, '%Y-%m-%d %h:%i') AS TrackingEventDate, 
    DATE_FORMAT(o2.EventDateTime, '%Y-%m-%d %h:%i') AS NextTrackingEventDate,
    TIMESTAMPDIFF(HOUR, o1.EventDateTime, o2.EventDateTime) AS HoursInStage
	FROM OrderTracking o1
	JOIN TrackingEvent e
		USING(TrackingEventID)
    LEFT JOIN OrderTracking o2
		ON o1.SalesOrderID = o2.SalesOrderID
        AND o1.TrackingEventID + 1 = o2.TrackingEventID
    WHERE o1.SalesOrderID
		IN (68857, 70531, 70421)
	ORDER BY o1.SalesOrderID;