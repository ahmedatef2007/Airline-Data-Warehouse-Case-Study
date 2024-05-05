CREATE TABLE Passenger_dim (
    passenger_key NUMBER PRIMARY KEY,
    passenger_id NUMBER ,
    name VARCHAR2(100),
    type VARCHAR2(20),
    address VARCHAR2(100),
    city VARCHAR2(50),
    country VARCHAR2(50),
    email VARCHAR2(100)
);


CREATE TABLE Passenger_Profile_dim (
    profile_key NUMBER PRIMARY KEY,
    status VARCHAR2(20),
    club_membership VARCHAR2(50),
    mileage_tier VARCHAR2(50),
    membership_status VARCHAR2(20)
);

CREATE TABLE Flight_Type_dim (
    flight_type_key NUMBER PRIMARY KEY,
    zone VARCHAR2(20),
    type VARCHAR2(20)
);

CREATE TABLE Airport_dim (
    airport_key NUMBER PRIMARY KEY,
    airport_id NUMBER ,
    name VARCHAR2(100),
    city VARCHAR2(50),
    country VARCHAR2(50)
);

CREATE TABLE Aircraft_dim (
    aircraft_key NUMBER PRIMARY KEY,
    aircraft_id NUMBER ,
    model VARCHAR2(100),
    capacity NUMBER,
    manufacturer VARCHAR2(100)
);

CREATE TABLE Booking_Channel_dim (
    channel_key NUMBER PRIMARY KEY,
    type VARCHAR2(50)
);

CREATE TABLE Fare_Basis_dim (
    fare_basis_key NUMBER PRIMARY KEY,
    type VARCHAR2(100),
    code VARCHAR2(10) , 
    promoted VARCHAR2(10)
);

CREATE TABLE Class_Upgrade_dim (
    upgrade_key NUMBER PRIMARY KEY,
    purchased_class VARCHAR2(50),
    actual_class VARCHAR2(50),
    change_indicator VARCHAR2(5)
);

CREATE TABLE Payment_Method_dim (
    payment_key NUMBER PRIMARY KEY,
    type VARCHAR2(20)
);


CREATE TABLE Interaction_Type_dim (
    interaction_type_key NUMBER PRIMARY KEY,
    interaction_type_id NUMBER ,
    interaction_type VARCHAR2(50), 
    channel VARCHAR2(50),
    stage_of_interaction VARCHAR2(50)
);

CREATE TABLE Problem_Severity_dim (
    problem_severity_key NUMBER PRIMARY KEY,
    severity_level_id NUMBER ,
    severity_level VARCHAR2(50),
    resolution_status VARCHAR2(50),
    description VARCHAR2(100)
);

CREATE TABLE Date_dim (
    date_key NUMBER PRIMARY KEY,
    datee DATE,
    year NUMBER,
    quarter VARCHAR2(10),
    month VARCHAR2(20),
    day NUMBER
);

CREATE TABLE Time_Dimension (
    time_key NUMBER PRIMARY KEY,
    hour_of_day NUMBER, -- Hour of the day (0-23)
    minute_of_hour NUMBER, -- Minute of the hour (0-59)
    time_slot VARCHAR2(20), -- time slot (e.g., Morning, Afternoon, Evening, Night)
    CONSTRAINT chk_hour CHECK (hour_of_day BETWEEN 0 AND 23),
    CONSTRAINT chk_minute CHECK (minute_of_hour BETWEEN 0 AND 59)
);

CREATE TABLE Segment_Flight_Activity_Fact (
    confirmation_number VARCHAR2(100),
    ticket_number VARCHAR2(100),
    segment_sequence_number NUMBER,
    passenger_key NUMBER,
    passenger_profile_key NUMBER,
    aircraft_key NUMBER,
    departure_airport_key NUMBER,
    arrival_airport_key NUMBER,
    booking_channel_key NUMBER,
    flight_type_key NUMBER,
    fare_basis_key NUMBER,
    payment_method_key NUMBER,
    class_upgrade_key NUMBER,
    scheduled_departure_date_key NUMBER,
    actual_departure_date_key NUMBER,
    scheduled_departure_time_key NUMBER,
    actual_departure_time_key NUMBER,
    scheduled_arrival_date_key NUMBER,
    actual_arrival_date_key NUMBER,
    scheduled_arrival_time_key NUMBER,
    actual_arrival_time_key NUMBER,
    fare_price NUMBER,
    taxes NUMBER,
    overweight_luggage NUMBER,
    upgrade_fees NUMBER,
    net_price NUMBER,
    cost NUMBER,
    profit NUMBER,
    CONSTRAINT pk_segment_flight_fact PRIMARY KEY (
        passenger_key,
        passenger_profile_key,
        aircraft_key,
        departure_airport_key,
        arrival_airport_key,
        booking_channel_key,
        flight_type_key,
        fare_basis_key,
        payment_method_key,
        class_upgrade_key,
        scheduled_departure_date_key,
        actual_departure_date_key,
        scheduled_departure_time_key,
        actual_departure_time_key,
        scheduled_arrival_date_key,
        actual_arrival_date_key,
        scheduled_arrival_time_key,
        actual_arrival_time_key
    ),
    CONSTRAINT fk_faf_ppkey FOREIGN KEY (passenger_key) REFERENCES Passenger_dim (passenger_key),
    CONSTRAINT fk_faf_pprofile FOREIGN KEY (passenger_profile_key) REFERENCES Passenger_Profile_dim (profile_key),
    CONSTRAINT fk_faf_aircraft FOREIGN KEY (aircraft_key) REFERENCES Aircraft_dim (aircraft_key),
    CONSTRAINT fk_faf_departure_airport FOREIGN KEY (departure_airport_key) REFERENCES Airport_dim (airport_key),
    CONSTRAINT fk_faf_arrival_airport FOREIGN KEY (arrival_airport_key) REFERENCES Airport_dim (airport_key),
    CONSTRAINT fk_faf_booking_channel FOREIGN KEY (booking_channel_key) REFERENCES Booking_Channel_dim (channel_key),
    CONSTRAINT fk_faf_flight_type_id FOREIGN KEY (flight_type_key) REFERENCES Flight_Type_dim (flight_type_key),
    CONSTRAINT fk_faf_fare_basis FOREIGN KEY (fare_basis_key) REFERENCES Fare_Basis_dim (fare_basis_key),
    CONSTRAINT fk_faf_payment_method FOREIGN KEY (payment_method_key) REFERENCES Payment_Method_dim (payment_key),
    CONSTRAINT fk_faf_class_upgrade FOREIGN KEY (class_upgrade_key) REFERENCES Class_Upgrade_dim (upgrade_key),
    CONSTRAINT fk_faf_sch_departure_date FOREIGN KEY (scheduled_departure_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_faf_actl_departure_date FOREIGN KEY (actual_departure_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_faf_sch_departure_time FOREIGN KEY (scheduled_departure_time_key) REFERENCES Time_Dimension (time_key),
    CONSTRAINT fk_faf_act_departure_time FOREIGN KEY (actual_departure_time_key) REFERENCES Time_Dimension (time_key),
    CONSTRAINT fk_faf_sch_arrival_date FOREIGN KEY (scheduled_arrival_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_faf_act_arrival_date FOREIGN KEY (actual_arrival_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_faf_sch_arrival_time FOREIGN KEY (scheduled_arrival_time_key) REFERENCES Time_Dimension (time_key),
    CONSTRAINT fk_faf_actual_arrival_time FOREIGN KEY (actual_arrival_time_key) REFERENCES Time_Dimension (time_key)
);




CREATE TABLE Customer_Care_Fact (
    passenger_key NUMBER,
    passenger_profile_key NUMBER,
    interaction_type_key NUMBER,
    problem_severity_key NUMBER,
    flight_type_key NUMBER,
    date_key NUMBER,
    time_key NUMBER,
    ticket_number VARCHAR2(100),
    CONSTRAINT pk_customer_care_fact PRIMARY KEY (
        passenger_key,
        passenger_profile_key,
        interaction_type_key,
        problem_severity_key,
        flight_type_key,
        date_key,
        time_key
    ),
    CONSTRAINT fk_ccf_passenger_id FOREIGN KEY (passenger_key) REFERENCES Passenger_dim (passenger_key),
    CONSTRAINT fk_ccf_passenger_profile_key FOREIGN KEY (passenger_profile_key) REFERENCES Passenger_Profile_dim (profile_key),
    CONSTRAINT fk_ccf_interaction_type_id FOREIGN KEY (interaction_type_key) REFERENCES Interaction_Type_dim (interaction_type_key),
    CONSTRAINT fk_ccf_problem_severity_id FOREIGN KEY (problem_severity_key) REFERENCES Problem_Severity_dim (problem_severity_key),
    CONSTRAINT fk_ccf_flight_key FOREIGN KEY (flight_type_key) REFERENCES Flight_Type_dim (flight_type_key),
    CONSTRAINT fk_ccf_date_key FOREIGN KEY (date_key) REFERENCES Date_Dim (date_key),
    CONSTRAINT fk_ccf_time_key FOREIGN KEY (time_key) REFERENCES Time_Dimension (time_key)
);



CREATE TABLE Trip_Flight_Activity_Fact (
    ticket_number VARCHAR2(100),
    passenger_key NUMBER,
    passenger_profile_key NUMBER,
    departure_airport_key NUMBER,
    arrival_airport_key NUMBER,
    booking_channel_key NUMBER,
    flight_type_key NUMBER,
    scheduled_departure_date_key NUMBER,
    actual_departure_date_key NUMBER,
    scheduled_arrival_date_key NUMBER,
    actual_arrival_date_key NUMBER,
    total_segments NUMBER,
    total_fare_price NUMBER,
    total_taxes NUMBER,
    total_overweight_luggage NUMBER,
    total_upgrade_fees NUMBER,
    total_net_price NUMBER,
    total_cost NUMBER,
    total_profit NUMBER,
    total_overnight_stays NUMBER,
    CONSTRAINT pk_trip_flight_activity_fact PRIMARY KEY (
        passenger_key,
        passenger_profile_key,
        departure_airport_key,
        arrival_airport_key,
        booking_channel_key,
        flight_type_key,
        scheduled_departure_date_key,
        actual_departure_date_key,
        scheduled_arrival_date_key,
        actual_arrival_date_key
    ),
    CONSTRAINT fk_taf_passenger_key FOREIGN KEY (passenger_key) REFERENCES Passenger_dim (passenger_key),
    CONSTRAINT fk_taf_passenger_profile_key FOREIGN KEY (passenger_profile_key) REFERENCES Passenger_Profile_dim (profile_key),
    CONSTRAINT fk_taf_departure_airport_key FOREIGN KEY (departure_airport_key) REFERENCES Airport_dim (airport_key),
    CONSTRAINT fk_taf_arrival_airport_key FOREIGN KEY (arrival_airport_key) REFERENCES Airport_dim (airport_key),
    CONSTRAINT fk_taf_booking_channel_key FOREIGN KEY (booking_channel_key) REFERENCES Booking_Channel_dim (channel_key),
    CONSTRAINT fk_taf_flight_type_id FOREIGN KEY (flight_type_key) REFERENCES Flight_Type_dim (flight_type_key),
    CONSTRAINT fk_taf_sch_departure_date_key FOREIGN KEY (scheduled_departure_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_taf_act_departure_date_key FOREIGN KEY (actual_departure_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_taf_sch_arrival_date_key FOREIGN KEY (scheduled_arrival_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_taf_act_arrival_date_key FOREIGN KEY (actual_arrival_date_key) REFERENCES Date_dim (date_key)
);




CREATE TABLE Reservation_Fact (
    passenger_key NUMBER,
    ticket_number VARCHAR2(100),
    PAYMENT_KEY NUMBER,
    booking_channel_key NUMBER,
    departure_date_key NUMBER,
    arrival_date_key NUMBER,
    reservation_date_key NUMBER,
    flight_type_key NUMBER,
    fare_basis_key NUMBER,
    price NUMBER,
    taxes NUMBER,
    net_price NUMBER,
    CONSTRAINT pk_reservation_fact PRIMARY KEY (
        passenger_key,
        PAYMENT_KEY,
        booking_channel_key,
        departure_date_key,
        arrival_date_key,
        reservation_date_key,
        flight_type_key,
        fare_basis_key
    ),
    CONSTRAINT fk_rf_passenger_key FOREIGN KEY (passenger_key) REFERENCES Passenger_dim (passenger_key),
    CONSTRAINT fk_rf_payment_key FOREIGN KEY (PAYMENT_KEY) REFERENCES Payment_Method_dim (payment_key),
    CONSTRAINT fk_rf_booking_channel_key FOREIGN KEY (booking_channel_key) REFERENCES Booking_Channel_dim (channel_key),
    CONSTRAINT fk_rf_departure_date_key FOREIGN KEY (departure_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_rf_arrival_date_key FOREIGN KEY (arrival_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_rf_reservation_date_key FOREIGN KEY (reservation_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_rf_flight_key FOREIGN KEY (flight_type_key) REFERENCES Flight_type_dim (flight_type_key),
    CONSTRAINT fk_rf_fare_basis_key FOREIGN KEY (fare_basis_key) REFERENCES Fare_Basis_dim (fare_basis_key)
);



CREATE TABLE Customer_Experience_dim (
    customer_experience_key NUMBER PRIMARY KEY,
    priority_check_in VARCHAR2(3),
    priority_boarding VARCHAR2(3),
    priority_baggage VARCHAR2(3)
);



CREATE TABLE Redeem_dim (
    redeem_key NUMBER PRIMARY KEY,
    redeem_id number , 
    redemption_type VARCHAR2(50),
    redemption_category VARCHAR2(50),
    redemption_description VARCHAR2(100)
);


CREATE TABLE Frequent_Flyers_Fact (
    member_key NUMBER,
    passenger_profile_key NUMBER,
    ticket_number VARCHAR2(100),
    customer_experience_key NUMBER,
    flight_type_key NUMBER,
    flight_date_key NUMBER,
    redeem_key NUMBER,
    miles_earned NUMBER,
    miles_redeemed NUMBER,
    class_upgrade_key NUMBER,
    CONSTRAINT pk_frequent_flyers_fact PRIMARY KEY (
        member_key,
        passenger_profile_key,
        customer_experience_key,
        flight_type_key,
        flight_date_key,
        redeem_key,
        class_upgrade_key
    ),
    CONSTRAINT fk_ff_member_key FOREIGN KEY (member_key) REFERENCES Passenger_dim (passenger_key),
    CONSTRAINT fk_ff_passenger_profile_key FOREIGN KEY (passenger_profile_key) REFERENCES Passenger_Profile_dim (profile_key),
    CONSTRAINT fk_ff_customer_experience_key FOREIGN KEY (customer_experience_key) REFERENCES Customer_Experience_dim (customer_experience_key),
    CONSTRAINT fk_ff_flight_type_key FOREIGN KEY (flight_type_key) REFERENCES Flight_Type_dim (flight_type_key),
    CONSTRAINT fk_ff_flight_date_key FOREIGN KEY (flight_date_key) REFERENCES Date_dim (date_key),
    CONSTRAINT fk_ff_redeem_key FOREIGN KEY (redeem_key) REFERENCES Redeem_dim (redeem_key),
    CONSTRAINT fk_ff_class_upgrade_key FOREIGN KEY (class_upgrade_key) REFERENCES Class_Upgrade_dim (upgrade_key)
);




