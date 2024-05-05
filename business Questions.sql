-- what flights the company’s frequent flyers mostly take
SELECT count(p.name) as count , a.name AS arrival_airport , aa.name as departure_airport
FROM Segment_Flight_Activity_Fact sfaf
JOIN Passenger_dim p ON sfaf.passenger_key = p.passenger_key
JOIN Passenger_Profile_dim pp ON sfaf.passenger_profile_key = pp.profile_key
JOIN Airport_dim a ON sfaf.arrival_airport_key = a.airport_key
JOIN Airport_dim aa ON sfaf.departure_airport_key = aa.airport_key
where pp.status = 'Active'
group by  a.name , aa.name 
order by count desc;

--Analyze fare basis paid by frequent flyers
SELECT DISTINCT fb.type AS fare_basis_type, COUNT(*) AS frequency
FROM Segment_Flight_Activity_Fact sfaf
JOIN Fare_Basis_dim fb ON sfaf.fare_basis_key = fb.fare_basis_key
JOIN Passenger_Profile_dim pp ON sfaf.passenger_profile_key = pp.profile_key
WHERE pp.club_membership =  'Gold Club'
GROUP BY fb.type;

-- Calculate frequency of upgrades by frequent flyers' Silver Club'
SELECT COUNT(*) AS num_silver_upgrades
FROM Segment_Flight_Activity_Fact sfaf
JOIN Passenger_Profile_dim pp ON sfaf.passenger_profile_key = pp.profile_key
WHERE pp.club_membership = 'Silver Club' AND sfaf.CLASS_UPGRADE_KEY in (select CLASS_UPGRADE_KEY from class_upgrade_dim where change_indicator  = 'Up'  ) ;

-- Calculate frequency of upgrades by frequent flyers 'Gold Club'
SELECT COUNT(*) AS num_gold_upgrades
FROM Segment_Flight_Activity_Fact sfaf
JOIN Passenger_Profile_dim pp ON sfaf.passenger_profile_key = pp.profile_key
WHERE pp.club_membership = 'Gold Club' AND sfaf.CLASS_UPGRADE_KEY in (select CLASS_UPGRADE_KEY    from class_upgrade_dim where change_indicator  = 'Up'  ) ;


--Identify responses to special fare promotions by frequent flyers
SELECT DISTINCT p.name AS passenger_name , count( sfaf.ticket_number) as Promoted_Tickets
FROM Segment_Flight_Activity_Fact sfaf
JOIN Passenger_dim p ON sfaf.passenger_key = p.passenger_key
JOIN Passenger_Profile_dim pp ON sfaf.passenger_profile_key = pp.profile_key
join Fare_Basis_dim fb on sfaf.fare_basis_key = fb.fare_basis_key 
WHERE pp.club_membership ='Gold Club' AND fb.promoted = 'Yes'
group by  p.name;


--the portion of  passenger in the different club memberships
SELECT 
    pp.club_membership,
    COUNT(p.passenger_key) AS passenger_count
FROM Passenger_Profile_dim pp
join Segment_Flight_Activity_Fact sfaf ON sfaf.passenger_profile_key = pp.profile_key
JOIN Passenger_dim p ON sfaf.passenger_key = p.passenger_key
where pp.status = 'Active'
GROUP BY pp.club_membership;

-- most departured from
SELECT 
    a.name AS departure_airport,
    COUNT(*) AS departure_count
FROM Segment_Flight_Activity_Fact sfaf
JOIN Airport_dim a ON sfaf.departure_airport_key = a.airport_key
GROUP BY a.name
ORDER BY departure_count DESC;

-- most arrived  airport 
SELECT 
    a.name AS arrival_airport,
    COUNT(*) AS arrival_count
FROM Segment_Flight_Activity_Fact sfaf
JOIN Airport_dim a ON sfaf.arrival_airport_key = a.airport_key
GROUP BY a.name
ORDER BY arrival_count DESC;


SELECT country, COUNT(*) AS total_passengers
FROM Passenger_dim
GROUP BY country;

SELECT ft.type, SUM(fare_price) AS total_revenue
FROM Segment_Flight_Activity_Fact s
JOIN Flight_Type_dim ft ON s.flight_type_key = ft.flight_type_key
GROUP BY ft.type;



--What are the preferred booking channels for reservations?

  SELECT bc.TYPE, COUNT (*) AS frequency
    FROM    Booking_Channel_dim bc
         JOIN
            Reservation_Fact rf
         ON bc.channel_key = rf.booking_channel_key
GROUP BY bc.TYPE
ORDER BY frequency DESC;



--Which flights are preferred by frequent flyers?
  SELECT ft.TYPE AS flight_type, COUNT (ff.ticket_number) AS ticket_count
    FROM    Frequent_Flyers_Fact ff
         JOIN
            Flight_Type_dim ft
         ON ff.flight_type_key = ft.flight_type_key
GROUP BY ft.TYPE
ORDER BY COUNT (ff.ticket_number) DESC;



--How often do frequent flyers upgrade their class?
SELECT ff.ticket_number, cu.purchased_class, cu.actual_class
FROM Frequent_Flyers_Fact ff
JOIN Class_Upgrade_dim cu ON ff.upgrade_key = cu.upgrade_key;



--How do frequent flyers earn and redeem their miles?
SELECT ff.ticket_number, rd.redemption_type, rd.redemption_category, rd.redemption_description
FROM Frequent_Flyers_Fact ff
JOIN Redeem_dim rd ON ff.redeem_key = rd.redeem_key;


--What is the total net price earned from reservations for each quarter of a specific year?
SELECT dd.quarter, SUM(rf.net_price) AS total_net_price
FROM Reservation_Fact rf
JOIN Date_dim dd ON rf.reservation_date_key = dd.date_key
WHERE dd.year = 2022
GROUP BY dd.quarter;


--Number of  Resolved Complaints 
SELECT COUNT(*) AS Resolved_Complaints
FROM Customer_Care_Fact c
JOIN Problem_Severity_dim ps ON c.problem_severity_key = ps.problem_severity_key
JOIN Interaction_Type_dim it ON c.interaction_type_key = it.interaction_type_key
WHERE ps.resolution_status = 'Resolved' 
AND it.interaction_type = 'Complaint';

--Total number of interactions per severity level:
SELECT ps.severity_level, COUNT(*) AS Total_Interactions
FROM Customer_Care_Fact c
JOIN Problem_Severity_dim ps ON c.problem_severity_key = ps.problem_severity_key
GROUP BY ps.severity_level;

--Number of interactions by interaction type and channel:
SELECT it.interaction_type, it.channel, COUNT(*) AS Total_Interactions
FROM Customer_Care_Fact c
JOIN Interaction_Type_dim it ON c.interaction_type_key = it.interaction_type_key
GROUP BY it.interaction_type, it.channel;




