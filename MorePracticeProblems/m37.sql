WITH HourDiffTest AS (
	SELECT 
		CASE
			WHEN OnlineOrderFlag = 1
			THEN 'Online'
			ELSE 'Offline'
		END AS OnlineOfflineStatus,
		e.EventName,
		TIMESTAMPDIFF(HOUR, o1.EventDateTime, o2.EventDateTime) AS HoursDiff,
        e.TrackingEventID,
        s.SalesOrderID
		FROM OrderTracking o1
		JOIN TrackingEvent e
			USING(TrackingEventID)
		JOIN SalesOrderHeader s
			USING(SalesOrderID)
		LEFT JOIN OrderTracking o2
			ON o1.SalesOrderID = o2.SalesOrderID
				AND o1.TrackingEventID != o2.TrackingEventID
),

ProcessingInfo AS (
	SELECT
		OnlineOfflineStatus,
		EventName,
		MIN(
			CASE 
				 WHEN HoursDiff > 0
				 THEN HoursDiff
				 ELSE NULL
			END
            ) AS HoursInStage,
        TrackingEventID
		FROM HourDiffTest
		GROUP BY OnlineOfflineStatus, SalesOrderID, TrackingEventID
)

SELECT 
	OnlineOfflineStatus,
    EventName,
    AVG(HoursInStage) AS AverageHoursSpentInStage
    FROM ProcessingInfo
    GROUP BY OnlineOfflineStatus, TrackingEventID
    ORDER BY OnlineOfflineStatus, TrackingEventID;