-- ---------------
-- txn_account.sql
-- ---------------

-- Confirm autocommit is off 
SET AUTOCOMMIT=0; -- This allows transactions in MySQL 
SELECT @@autocommit;

-- Transaction; 
 START TRANSACTION; -- An explicit start - but after any commit a NEW transaction begins

-- Statement 2
 SELECT * FROM ACCOUNT;

--  (declare a temporary variable amount persistent for this session) 
 set @amount = 100;

-- Statement 3

 UPDATE ACCOUNT set balance = balance - @amount where id =1;

-- Statement 4 confirm deduction from savings but not yet deposited to credit
 SELECT * FROM ACCOUNT;
 
--  Statement 5 deposit the amount into the credit account 
 UPDATE ACCOUNT set balance = balance + @amount where id = 2;
 
-- Statement 6 confirm all changes 
 SELECT * FROM ACCOUNT;
 
-- Statement 7 EXPLICIT COMMIT;
 COMMIT; 

-- ALL CHANGES PERMANENT CAN NOT BE UNDONE WITH ROLLBACK
-- Try
 
 
 
 
 
 
 
 
 -- REVERSE The work MANUALLY
-- UPDATE ACCOUNT set balance = balance + @amount where id =1;
 
--  SELECT * FROM ACCOUNT;
 
-- UPDATE ACCOUNT set balance = balance - @amount where id = 2;
 
