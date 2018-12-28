select *
from account

CREATE DATABASE MMORPG;

use MMORPG
select * from account
CREATE TABLE ACCOUNT
(account_id INT PRIMARY KEY IDENTITY(0, 1),
email VARCHAR(40) NOT NULL CONSTRAINT UK_Email UNIQUE (email),
phone_number VARCHAR(20) CONSTRAINT UK_account_phone_number UNIQUE (phone_number), 
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL,
account_name VARCHAR(20) NOT NULL CONSTRAINT UK_account_name UNIQUE (account_name),
password_name VARCHAR(20) NOT NULL CONSTRAINT CK_Password CHECK (DATALENGTH([password_name]) >= 8),
birth_date DATE NOT NULL);

CREATE TABLE EMPLOYEE
(employee_id INT PRIMARY KEY IDENTITY(99, 1),
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
phone_number VARCHAR(20) NOT NULL CONSTRAINT UK_employee_phone_number UNIQUE (phone_number),
position VARCHAR(20) NOT NULL,
salary SMALLMONEY NOT NULL,
manager INT,
employee_address VARCHAR(50) NOT NULL,
hire_date DATE NOT NULL);

CREATE TABLE BLACKLIST
(ban_date SMALLDATETIME PRIMARY KEY DEFAULT GETDATE(), 
banned_by INT NOT NULL CONSTRAINT FK_blacklist_banned_by REFERENCES EMPLOYEE(employee_id),
account_id INT NOT NULL REFERENCES ACCOUNT (account_id) ON DELETE CASCADE,
account_name VARCHAR(20) NOT NULL REFERENCES ACCOUNT (account_name), 
reason_banned VARCHAR(20) NOT NULL);

CREATE TABLE TIME_CLOCK
(time_punched_in DATETIME CONSTRAINT PK_time_punched_in PRIMARY KEY (time_punched_in),
employee_id INT NOT NULL CONSTRAINT FK_time_clock_employee_id REFERENCES EMPLOYEE (employee_id) ON DELETE CASCADE,
time_punched_out DATETIME NOT NULL);

CREATE TABLE EMPLOYEE_STATUS
(employee_id INT NOT NULL REFERENCES EMPLOYEE(employee_id),
reason_for_not_working VARCHAR(100),
currently_working CHAR(1) NOT NULL);

CREATE TABLE MICROTRANSACTION
(transaction_date SMALLDATETIME PRIMARY KEY,
account_id INT NOT NULL REFERENCES ACCOUNT(account_id),
amount_purchased SMALLMONEY NOT NULL);

CREATE TABLE MESSAGE_HISTORY
(message_id INT PRIMARY KEY IDENTITY(1,1),
account_id INT NOT NULL REFERENCES ACCOUNT(account_id),
text_message VARCHAR(250) NOT NULL);

CREATE TABLE TERMINATION
(employee_id INT,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
phone_number VARCHAR(20) NOT NULL CONSTRAINT UK_employee_termination_phone_number UNIQUE (phone_number),
position VARCHAR(20) NOT NULL,
salary SMALLMONEY NOT NULL,
manager INT,
employee_address VARCHAR(20) NOT NULL,
hire_date DATE NOT NULL);

CREATE TRIGGER employee_termination
ON EMPLOYEE
AFTER DELETE
AS
BEGIN
	INSERT INTO TERMINATION 
	SELECT * FROM DELETED
END

DELETE
FROM EMPLOYEE
WHERE employee_id = 104;

INSERT INTO ACCOUNT (email, phone_number, first_name, last_name, account_name, password_name, birth_date)
VALUES
('kyleluong@hotmail.com', '7247321794', 'Kyle', 'Luong', 'kyleisawesome2000', 'password123', '1998-06-01');

INSERT INTO ACCOUNT (email, phone_number, first_name, last_name, account_name, password_name, birth_date)
VALUES
('cluelessdough@live.com', '4123456790', 'Pumpkin', 'Spice', 'cinnamonrolls', 'coconutpie', '1992-02-10');

INSERT INTO ACCOUNT (email, phone_number, first_name, last_name, account_name, password_name, birth_date)
VALUES
('smoothskin@yahoo.com', '315-222-1042', 'Lotion', 'Mustache', '123abc', 'abc12345', '2000-04-23');

INSERT INTO ACCOUNT (email, phone_number, first_name, last_name, account_name, password_name, birth_date)
VALUES
('thebuffdaedra@live.com', '900-133-1337', 'Daedra', 'Manpal', 'shayfox', 'iscool2000', '1997-10-27');

INSERT INTO ACCOUNT (email, phone_number, first_name, last_name, account_name, password_name, birth_date)
VALUES
('billyjohnjoe@yahoo.com', '123-456-7890', 'Billy', 'Joe', 'johniscool123', 'therock5000', '1983-11-23');

INSERT INTO EMPLOYEE (first_name, last_name, phone_number, position, salary, employee_address, hire_date)
VALUES
('Eric', 'Dang', '724-931-0157', 'CEO', 137201, '1500 Admiral Street', '1997-08-09');

INSERT INTO EMPLOYEE (first_name, last_name, phone_number, position, salary, manager,  employee_address, hire_date)
VALUES
('John', 'Johnson', '724-111-2351', 'Manager', 85000, 100, '50 Finley Ave', '1994-06-02');

INSERT INTO EMPLOYEE (first_name, last_name, phone_number, position, salary, manager, employee_address, hire_date)
VALUES
('Wilson', 'Applesauce', '412-299-3001', 'CSR', 35000, 101, '23 Walnut Drive', '1995-08-02');

INSERT INTO EMPLOYEE (first_name, last_name, phone_number, position, salary, manager, employee_address, hire_date)
VALUES
('Thomas', 'Thompson', '123-456-9081', 'CSR', 35500, 101, '20 Apple Drive', '1999-01-30');

INSERT INTO EMPLOYEE (first_name, last_name, phone_number, position, salary, manager, employee_address, hire_date)
VALUES
('Wade', 'Wilson', '234-111-5555', 'CSR', 39000, 101, '64 Snake Avenue', '2005-12-31');

INSERT INTO BLACKLIST (ban_date, banned_by, account_id, account_name, reason_banned)
VALUES
('2018-01-30 10:59:00', 102, 1, 'kyleisawesome2000', 'Banned for hacking.');

INSERT INTO BLACKLIST(ban_date, banned_by, account_id, account_name, reason_banned)
VALUES
('2018-02-28 16:20:21', 103, 2, 'cinnamonrolls', 'Harassing people.');

INSERT INTO TIME_CLOCK(time_punched_in, employee_id, time_punched_out)
VALUES
('2018-02-05 12:04:33', 100, '2018-02-05 16:03:32');

INSERT INTO TIME_CLOCK(time_punched_in, employee_id, time_punched_out)
VALUES
('2018-02-05 9:11:16', 101, '2018-02-05 17:10:02');

INSERT INTO TIME_CLOCK(time_punched_in, employee_id, time_punched_out)
VALUES
('2018-02-06 11:47:53', 102, '2018-02-06 19:48:02');

INSERT INTO EMPLOYEE_STATUS (employee_id, reason_for_not_working, currently_working)
VALUES
(100, 'Vacation for 2 weeks', 'N');

INSERT INTO EMPLOYEE_STATUS (employee_id, currently_working)
VALUES
(101, 'Y');

INSERT INTO EMPLOYEE_STATUS (employee_id, currently_working)
VALUES
(102, 'Y');

INSERT INTO EMPLOYEE_STATUS (employee_id, currently_working)
VALUES
(103, 'Y');


INSERT INTO MICROTRANSACTION(transaction_date, account_id, amount_purchased)
VALUES
(GETDATE(), 2, 25);

INSERT INTO MICROTRANSACTION(transaction_date, account_id, amount_purchased)
VALUES
(GETDATE(), 2, 10);

INSERT INTO MICROTRANSACTION(transaction_date, account_id, amount_purchased)
VALUES
(GETDATE(), 3, 100);

INSERT INTO MESSAGE_history(account_id, text_message)
VALUES
(2, 'hey!! how its going john');

INSERT INTO MESSAGE_history(account_id, text_message)
VALUES
(5, 'nothing much, how about you');

INSERT INTO MESSAGE_history(account_id, text_message)
VALUES
(2, 'creating a final project for my SQL class! :)');

SELECT employee_id, first_name + ' ' + last_name AS Employee_Name, account_id, banned_by, account_name, reason_banned
FROM EMPLOYEE
INNER JOIN BLACKLIST ON EMPLOYEE.employee_id = BLACKLIST.banned_by
WHERE employee_id = 102;

SELECT EMPLOYEE.employee_id, first_name + ' ' + last_name AS Employee_Name, time_punched_in, currently_working
FROM ((EMPLOYEE
INNER JOIN EMPLOYEE_STATUS ON EMPLOYEE.employee_id = EMPLOYEE_STATUS.employee_id)
INNER JOIN TIME_CLOCK ON EMPLOYEE.employee_id = TIME_CLOCK.employee_id)
WHERE EMPLOYEE.employee_id = 102;

SELECT ACCOUNT.account_id, first_name + ' ' + last_name AS FullName, text_message
FROM ACCOUNT
INNER JOIN MESSAGE_HISTORY ON ACCOUNT.account_id = MESSAGE_HISTORY.account_id
WHERE ACCOUNT.account_id = 2;

UPDATE EMPLOYEE
SET first_name = 'Erik'
WHERE employee_id = 100;

SELECT * FROM TERMINATION;



DBCC CHECKIDENT ('[EMPLOYEE]', RESEED, 99);
GO

