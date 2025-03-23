--Oracle PL SQL declare a date variable as not null and assign a value to it. In the main body, assign a null value to this variable along with exception handling.
DECLARE
  v_date DATE NOT NULL := '2021-01-01';
BEGIN
    --display the value of the variable
    DBMS_OUTPUT.PUT_LINE('The value of the variable is ' || v_date);
    --v_date := NULL;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred - ' || SQLCODE || ' -ERROR- ' || SQLERRM);
    END;
/

