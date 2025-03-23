--Oracle PL-SQL code to add two numbers and store the result in a variable
DECLARE
   a NUMBER := 10;
   b NUMBER := 20;
   c NUMBER;
BEGIN
   c := a + b;
   DBMS_OUTPUT.PUT_LINE('The sum of ' || a || ' and ' || b || ' is ' || c);
END;


