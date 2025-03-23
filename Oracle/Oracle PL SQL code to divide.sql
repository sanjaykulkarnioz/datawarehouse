--Oracle PL SQL code to divide one variable by another variable and store the result in a third variable with divide by zero error handling
DECLARE
    dividend NUMBER := 10;
    divisor NUMBER := 0;
    result NUMBER;
BEGIN
    BEGIN
        result := dividend / divisor;
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            result := NULL;
        DBMS_OUTPUT.PUT_LINE('Divide by zero error');
    END;
    DBMS_OUTPUT.PUT_LINE('Result: ' || result);
END;

