CREATE OR REPLACE PROCEDURE Populate_Date_Dimension AS
    v_start_date DATE := TO_DATE('2022-01-01', 'YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2023-12-31', 'YYYY-MM-DD');
BEGIN
    WHILE v_start_date <= v_end_date LOOP
        INSERT INTO Date_dim (date_key, datee, year, quarter, month, day)
        VALUES (v_start_date - TO_DATE('2022-01-01', 'YYYY-MM-DD') + 1,
                v_start_date,
                EXTRACT(YEAR FROM v_start_date),
                CASE
                    WHEN EXTRACT(MONTH FROM v_start_date) BETWEEN 1 AND 3 THEN 'Q1'
                    WHEN EXTRACT(MONTH FROM v_start_date) BETWEEN 4 AND 6 THEN 'Q2'
                    WHEN EXTRACT(MONTH FROM v_start_date) BETWEEN 7 AND 9 THEN 'Q3'
                    ELSE 'Q4'
                END,
                TO_CHAR(v_start_date, 'Month'),
                EXTRACT(DAY FROM v_start_date));
        
        v_start_date := v_start_date + 1;
    END LOOP;
END Populate_Date_Dimension;
/
BEGIN
    Populate_Date_Dimension;
END;
/

CREATE OR REPLACE PROCEDURE Populate_Time_Dimension AS
BEGIN
    FOR hour IN 0..23 LOOP
        FOR minute IN 0..59 LOOP
            INSERT INTO Time_Dimension (time_key, hour_of_day, minute_of_hour)
            VALUES ((hour * 100) + minute, hour, minute);
        END LOOP;
    END LOOP;

    -- Define time slots
    UPDATE Time_Dimension
    SET time_slot =
        CASE
            WHEN hour_of_day BETWEEN 0 AND 5 THEN 'Night'
            WHEN hour_of_day BETWEEN 6 AND 11 THEN 'Morning'
            WHEN hour_of_day BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Time Dimension populated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/
BEGIN
    Populate_Time_Dimension;
END;
/



CREATE OR REPLACE PROCEDURE Update_Date_Key_Expression AS
BEGIN
    UPDATE Date_dim
    SET date_key = TO_NUMBER(TO_CHAR(datee, 'YYYYMMDD'));
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Date keys updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/
BEGIN
    Update_Date_Key_Expression;
END;
/