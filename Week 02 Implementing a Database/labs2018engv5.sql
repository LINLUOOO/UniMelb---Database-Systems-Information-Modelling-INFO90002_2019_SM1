-- Labs2018 Schema Script 
--    NAME
--     labs2018engv5.sql - Create data objects for labs2018 schema
--
--    DESCRIPTION
--      This creates a modified department Store schema including 
--      deliveryitem, Saleitem event tables
--      It is a combination of 
--      labs2018v6 and labs2018rowsv3
--    NOTES
--
--    CREATED by Greg Wadley, David Eccles
--
--    MODIFIED   (MM/DD/YY)
--    deccles     02/21/19 - removed back quotes to remove camel case compliance
--    deccles     02/23/18 - corrected typos and db
--    deccles     02/12/18 - readded FK & remerged row insert
--    deccles     02/12/18 - version 5 DDL updates incorporated
--    deccles     02/08/18 - merged schema and row insert scripts 
--    deccles     01/24/18 - fixed ref integrity errors
--    deccles     01/18/18 - modified for event tables attributes
--    gwadley     12/14/17 - gwadley created the revised ER Model


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Schema labs2018
-- UNCOMMENT the following section for BYOD installs
-- -----------------------------------------------------
-- DROP SCHEMA IF EXISTS labs2018 ;
-- CREATE SCHEMA IF NOT EXISTS labs2018 DEFAULT CHARACTER SET utf8 ;

-- USE labs2018 ;
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table supplier
-- -----------------------------------------------------
DROP TABLE IF EXISTS supplier ;

CREATE TABLE IF NOT EXISTS supplier (
  SupplierID SMALLINT(6) NOT NULL,
  Name VARCHAR(25) NOT NULL,
  Phone CHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (SupplierID))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table delivery
-- -----------------------------------------------------
DROP TABLE IF EXISTS delivery ;

CREATE TABLE IF NOT EXISTS delivery (
  DeliveryID INT(11) NOT NULL,
  SupplierID SMALLINT(6) NOT NULL,
  DeliveryDate DATE NOT NULL,
  PRIMARY KEY (DeliveryID),
  INDEX SupplierID (SupplierID ASC),
  CONSTRAINT fk_delivery_supplier
    FOREIGN KEY (SupplierID)
    REFERENCES supplier (SupplierID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table item
-- -----------------------------------------------------
DROP TABLE IF EXISTS item ;

CREATE TABLE IF NOT EXISTS item (
  itemID SMALLINT(6) NOT NULL DEFAULT '0',
  Name VARCHAR(50) NOT NULL,
  Type CHAR(1) NOT NULL,
  Colour VARCHAR(20) NULL DEFAULT NULL,
  itemPrice DECIMAL(9,2) NULL DEFAULT NULL,
  PRIMARY KEY (itemID))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table employee
-- -----------------------------------------------------
DROP TABLE IF EXISTS employee ;

CREATE TABLE IF NOT EXISTS employee (
  employeeID SMALLINT(6) NOT NULL DEFAULT '0',
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Salary DECIMAL(8,2) NULL DEFAULT NULL,
  departmentID SMALLINT(6) NOT NULL,
  BossID SMALLINT(6) NULL DEFAULT NULL,
  DateOfBirth DATE NULL DEFAULT NULL,
  PRIMARY KEY (employeeID),
  INDEX departmentID (departmentID ASC),
  INDEX fk_employee_employee1_idx (BossID ASC),
  CONSTRAINT fk_employee_employee1
    FOREIGN KEY (employeeID)
    REFERENCES employee (BossID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table department
-- -----------------------------------------------------
DROP TABLE IF EXISTS department ;

CREATE TABLE IF NOT EXISTS department (
  departmentID SMALLINT(6) NOT NULL DEFAULT '0',
  Name VARCHAR(50) NOT NULL,
  Floor TINYINT(4) NOT NULL,
  Phone CHAR(10) NULL DEFAULT NULL,
  ManagerID SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (departmentID),
  INDEX ManagerID (ManagerID ASC),
  CONSTRAINT fk_department_employee1
    FOREIGN KEY (ManagerID)
    REFERENCES employee (employeeID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_department_employee2
    FOREIGN KEY (departmentID)
    REFERENCES employee (departmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table deliveryitem
-- -----------------------------------------------------
DROP TABLE IF EXISTS deliveryitem ;

CREATE TABLE IF NOT EXISTS deliveryitem (
  DeliveryId INT(11) NOT NULL,
  itemId SMALLINT(6) NOT NULL,
  departmentID SMALLINT(6) NOT NULL,
  Quantity TINYINT(4) NOT NULL,
  WholesalePrice DECIMAL(9,2) NULL DEFAULT NULL,
  PRIMARY KEY (DeliveryId, itemId, departmentID),
  INDEX fk_deliveryitem_item1_idx (itemId ASC),
  INDEX fk_deliveryitem_department1_idx (departmentID ASC),
  CONSTRAINT fk_deliveryitem_delivery1
    FOREIGN KEY (DeliveryId)
    REFERENCES delivery (DeliveryID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_deliveryitem_item1
    FOREIGN KEY (itemId)
    REFERENCES item (itemID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_deliveryitem_department1
    FOREIGN KEY (departmentID)
    REFERENCES department (departmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table sale
-- -----------------------------------------------------
DROP TABLE IF EXISTS sale ;

CREATE TABLE IF NOT EXISTS sale (
  SaleID INT(11) NOT NULL,
  departmentID SMALLINT(6) NOT NULL,
  SaleDate DATE NOT NULL,
  PRIMARY KEY (SaleID),
  INDEX departmentID (departmentID ASC),
  CONSTRAINT fk_sale_department1
    FOREIGN KEY (departmentID)
    REFERENCES department (departmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table saleitem
-- -----------------------------------------------------
DROP TABLE IF EXISTS saleitem ;

CREATE TABLE IF NOT EXISTS saleitem (
  SaleId INT(11) NOT NULL,
  itemId SMALLINT(6) NOT NULL,
  Quantity TINYINT(4) NOT NULL,
  PRIMARY KEY (SaleId, itemId),
  INDEX fk_Saleitem_item1_idx (itemId ASC),
  CONSTRAINT fk_saleitem_item1
    FOREIGN KEY (itemId)
    REFERENCES item (itemID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_saleitem_sale1
    FOREIGN KEY (SaleId)
    REFERENCES sale (SaleID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

COMMIT;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- labs2018rows 
-- add rows

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- supplier labs2018

insert into supplier values (101,'Global Books & Maps',55240007);
insert into supplier values (102,'Nepalese Corp.',55244552);
insert into supplier values (103,'All Sports Manufacturing',55478252);
insert into supplier values (104,'Sweatshops Unlimited',55244500);
insert into supplier values (105,'All Points_ Inc.',54585252);
insert into supplier values (106,'Sao Paulo Manufacturing',54572755);

-- delivery labs2018
insert into delivery values (11,101,'2017-03-03');
insert into delivery values (12,102,'2017-03-14');
insert into delivery values (13,104,'2017-03-25');
insert into delivery values (14,103,'2017-04-05');
insert into delivery values (15,105,'2017-04-16');
insert into delivery values (16,106,'2017-04-27');
insert into delivery values (17,102,'2017-05-08');
insert into delivery values (18,101,'2017-05-19');
insert into delivery values (19,106,'2017-05-30');
insert into delivery values (20,103,'2017-06-10');
insert into delivery values (21,105,'2017-06-21');
insert into delivery values (22,106,'2017-07-02');
insert into delivery values (23,102,'2017-07-13');
insert into delivery values (24,106,'2017-07-24');
insert into delivery values (25,105,'2017-08-04');
insert into delivery values (26,101,'2017-08-15');


-- employee labs2018
insert into employee values (1,'Alice','Munro',125000,1,NULL,'1966-12-14');
insert into employee values (2,'Ned','Kelly',85000,11,1,'1970-07-16');
insert into employee values (3,'Andrew','Jackson',55000,11,2,'1958-04-01');
insert into employee values (4,'Clare','Underwood',52000,11,2,'1982-09-22');
insert into employee values (5,'Todd','Beamer',68000,8,1,'1965-05-24');
insert into employee values (6,'Nancy','Cartwright',52000,8,5,'1993-04-11');
insert into employee values (7,'Brier','Patch',73000,9,1,'1981-10-16');
insert into employee values (8,'Sarah','Fergusson',86000,9,7,'1978-11-15');
insert into employee values (9,'Sophie','Monk',75000,10,1,'1986-12-15');
insert into employee values (10,'Sanjay','Patel',45000,6,3,'1984-01-28');
insert into employee values (11,'Rita','Skeeter',45000,2,4,'1988-02-22');
insert into employee values (12,'Gigi','Montez',46000,3,4,'1992-03-20');
insert into employee values (13,'Maggie','Smith',46000,3,4,'1991-04-29');
insert into employee values (14,'Paul','Innit ',41000,4,3,'1998-06-02');
insert into employee values (15,'James','Mason',45000,4,3,'1995-07-30');
insert into employee values (16,'Pat','Clarkson',45000,5,3,'1997-08-28');
insert into employee values (17,'Mark','Zhang',45000,7,3,'1996-10-01');

-- department labs2018
insert into department values (1,'Management',5,34,1);
insert into department values (2,'Books',1,81,4);
insert into department values (3,'Clothes',2,24,4);
insert into department values (4,'Equipment',3,57,3);
insert into department values (5,'Furniture',4,14,3);
insert into department values (6,'Navigation',1,41,3);
insert into department values (7,'Recreation',2,29,4);
insert into department values (8,'Accounting',5,35,5);
insert into department values (9,'Purchasing',5,36,7);
insert into department values (10,'Personnel',5,37,9);
insert into department values (11,'Marketing',5,38,2);

-- deliveryitem labs2018
insert into deliveryitem values (11,3,6,4,12.5);
insert into deliveryitem values (11,6,6,2,53);
insert into deliveryitem values (11,10,6,3,11);
insert into deliveryitem values (11,11,6,10,4);
insert into deliveryitem values (11,17,6,19,4);
insert into deliveryitem values (12,3,2,2,13);
insert into deliveryitem values (12,3,6,4,13);
insert into deliveryitem values (12,5,2,8,9);
insert into deliveryitem values (12,5,6,8,9);
insert into deliveryitem values (12,5,7,8,9);
insert into deliveryitem values (12,6,6,4,53);
insert into deliveryitem values (12,9,2,8,11);
insert into deliveryitem values (12,9,6,2,10);
insert into deliveryitem values (12,9,7,2,11);
insert into deliveryitem values (12,10,6,5,11);
insert into deliveryitem values (12,11,6,10,4);
insert into deliveryitem values (12,12,6,8,93);
insert into deliveryitem values (12,13,6,4,26);
insert into deliveryitem values (12,14,7,3,12);
insert into deliveryitem values (12,15,4,1,21);
insert into deliveryitem values (12,16,4,3,22);
insert into deliveryitem values (12,17,2,8,4);
insert into deliveryitem values (12,17,3,15,4);
insert into deliveryitem values (12,17,4,12,4);
insert into deliveryitem values (12,17,5,15,4);
insert into deliveryitem values (12,17,6,17,4);
insert into deliveryitem values (12,19,7,37,148);
insert into deliveryitem values (13,12,3,8,95);
insert into deliveryitem values (13,17,6,23,3.75);
insert into deliveryitem values (14,3,4,8,13.25);
insert into deliveryitem values (14,6,2,2,53);
insert into deliveryitem values (14,11,6,10,4);
insert into deliveryitem values (14,12,3,4,94);
insert into deliveryitem values (14,17,2,1,4);
insert into deliveryitem values (15,1,3,4,87);
insert into deliveryitem values (15,8,3,20,13);
insert into deliveryitem values (15,12,3,4,88);
insert into deliveryitem values (15,14,3,3,15);
insert into deliveryitem values (15,22,3,6,80);
insert into deliveryitem values (15,23,3,8,59);
insert into deliveryitem values (15,24,3,3,107);
insert into deliveryitem values (15,25,3,5,111);
insert into deliveryitem values (16,12,4,5,95);
insert into deliveryitem values (16,14,4,4,16);
insert into deliveryitem values (16,17,4,5,4);
insert into deliveryitem values (12,20,7,5,291);
insert into deliveryitem values (12,21,7,2,237);
insert into deliveryitem values (17,5,2,8,9);
insert into deliveryitem values (17,5,7,1,9);
insert into deliveryitem values (17,9,2,2,11);
insert into deliveryitem values (17,9,7,2,11);
insert into deliveryitem values (18,3,6,4,12.5);
insert into deliveryitem values (18,6,6,4,53);
insert into deliveryitem values (18,10,6,2,11);
insert into deliveryitem values (18,11,6,10,4);
insert into deliveryitem values (19,12,4,5,95);
insert into deliveryitem values (19,14,4,4,15);
insert into deliveryitem values (19,17,4,12,4);
insert into deliveryitem values (20,6,2,1,53);
insert into deliveryitem values (21,8,3,15,13.5);
insert into deliveryitem values (22,14,4,4,14);
insert into deliveryitem values (23,5,2,8,9);
insert into deliveryitem values (23,5,6,2,9);
insert into deliveryitem values (23,5,7,1,9);
insert into deliveryitem values (24,12,4,5,95);
insert into deliveryitem values (24,14,4,4,13);
insert into deliveryitem values (24,17,4,14,4);
insert into deliveryitem values (25,1,3,2,91);
insert into deliveryitem values (25,2,4,1,702);
insert into deliveryitem values (25,3,4,1,14);
insert into deliveryitem values (25,8,3,20,14.5);
insert into deliveryitem values (25,12,2,1,88);
insert into deliveryitem values (25,12,3,2,88);
insert into deliveryitem values (25,12,4,10,88);
insert into deliveryitem values (25,12,5,1,88);
insert into deliveryitem values (25,12,6,2,88);
insert into deliveryitem values (25,17,4,5,4);
insert into deliveryitem values (25,14,2,1,15);
insert into deliveryitem values (25,14,3,2,14);
insert into deliveryitem values (25,14,4,4,13);
insert into deliveryitem values (25,14,5,9,13);
insert into deliveryitem values (25,14,6,3,14);
insert into deliveryitem values (25,14,7,1,15);
insert into deliveryitem values (25,18,3,47,8);
insert into deliveryitem values (25,22,3,2,80);
insert into deliveryitem values (25,23,3,2,59);
insert into deliveryitem values (25,24,3,1,107);
insert into deliveryitem values (25,25,3,5,111);
insert into deliveryitem values (26,3,6,6,12.5);
insert into deliveryitem values (26,5,6,2,9);
insert into deliveryitem values (26,6,6,3,53);
insert into deliveryitem values (26,9,6,2,10);
insert into deliveryitem values (26,10,6,2,11);
insert into deliveryitem values (26,11,6,10,4);
insert into deliveryitem values (26,13,6,4,26);
insert into deliveryitem values (26,17,6,6,4);
insert into deliveryitem values (26,17,2,1,4);


-- sale labs2018
insert into sale values (100,7,'2017-08-19');
insert into sale values (110,6,'2017-08-25');
insert into sale values (120,2,'2017-08-30');
insert into sale values (130,6,'2017-09-05');
insert into sale values (140,5,'2017-09-15');
insert into sale values (150,3,'2017-09-17');
insert into sale values (160,6,'2017-09-25');
insert into sale values (170,4,'2017-10-08');
insert into sale values (180,4,'2017-10-09');
insert into sale values (190,5,'2017-10-12');
insert into sale values (230,2,'2017-10-13');
insert into sale values (200,3,'2017-10-13');
insert into sale values (220,3,'2017-10-13');
insert into sale values (240,6,'2017-10-13');
insert into sale values (210,6,'2017-10-13');
insert into sale values (250,7,'2017-10-14');
insert into sale values (260,7,'2017-10-15');
insert into sale values (270,4,'2017-10-17');
insert into sale values (280,3,'2017-10-18');
insert into sale values (290,2,'2017-10-20');
insert into sale values (300,6,'2017-10-22');
insert into sale values (310,7,'2017-10-24');
insert into sale values (330,2,'2017-10-25');
insert into sale values (320,7,'2017-10-25');
insert into sale values (340,2,'2017-10-26');
insert into sale values (350,3,'2017-10-27');
insert into sale values (360,3,'2017-10-28');
insert into sale values (370,4,'2017-10-29');
insert into sale values (380,6,'2017-11-04');
insert into sale values (390,4,'2017-11-15');
insert into sale values (400,2,'2017-11-23');
insert into sale values (410,6,'2017-11-24');
insert into sale values (420,6,'2017-11-27');
insert into sale values (430,5,'2017-12-04');
insert into sale values (440,6,'2017-12-07');
insert into sale values (450,6,'2017-12-07');
insert into sale values (460,6,'2017-12-10');
insert into sale values (480,3,'2017-12-14');
insert into sale values (470,4,'2017-12-14');
insert into sale values (490,7,'2017-12-14');
insert into sale values (500,3,'2017-12-16');
insert into sale values (510,5,'2017-12-18');
insert into sale values (520,6,'2017-12-20');

-- saleitem labs2018
insert into saleitem values (100,14,1);
insert into saleitem values (100,20,1);
insert into saleitem values (110,6,1);
insert into saleitem values (110,17,3);
insert into saleitem values (120,5,1);
insert into saleitem values (120,9,1);
insert into saleitem values (130,6,1);
insert into saleitem values (130,12,2);
insert into saleitem values (140,12,1);
insert into saleitem values (140,17,1);
insert into saleitem values (150,14,1);
insert into saleitem values (150,17,2);
insert into saleitem values (150,22,1);
insert into saleitem values (160,17,2);
insert into saleitem values (170,3,2);
insert into saleitem values (170,12,1);
insert into saleitem values (170,14,1);
insert into saleitem values (180,3,1);
insert into saleitem values (180,12,1);
insert into saleitem values (190,14,1);
insert into saleitem values (190,17,1);
insert into saleitem values (200,8,2);
insert into saleitem values (200,14,1);
insert into saleitem values (200,17,2);
insert into saleitem values (200,18,3);
insert into saleitem values (200,25,1);
insert into saleitem values (210,14,1);
insert into saleitem values (220,8,1);
insert into saleitem values (220,14,1);
insert into saleitem values (220,17,2);
insert into saleitem values (220,18,1);
insert into saleitem values (220,23,1);
insert into saleitem values (220,24,1);
insert into saleitem values (230,1,1);
insert into saleitem values (230,5,1);
insert into saleitem values (230,6,1);
insert into saleitem values (230,9,1);
insert into saleitem values (230,17,1);
insert into saleitem values (240,3,1);
insert into saleitem values (240,10,1);
insert into saleitem values (240,17,4);
insert into saleitem values (250,19,1);
insert into saleitem values (260,19,1);
insert into saleitem values (260,21,1);
insert into saleitem values (270,3,1);
insert into saleitem values (270,12,1);
insert into saleitem values (270,14,1);
insert into saleitem values (270,17,1);
insert into saleitem values (280,14,1);
insert into saleitem values (280,24,2);
insert into saleitem values (290,1,1);
insert into saleitem values (290,3,1);
insert into saleitem values (290,6,1);
insert into saleitem values (290,17,1);
insert into saleitem values (300,6,1);
insert into saleitem values (300,14,1);
insert into saleitem values (310,19,1);
insert into saleitem values (320,14,2);
insert into saleitem values (320,19,2);
insert into saleitem values (330,5,1);
insert into saleitem values (330,9,1);
insert into saleitem values (330,14,1);
insert into saleitem values (330,17,1);
insert into saleitem values (340,1,1);
insert into saleitem values (340,9,1);
insert into saleitem values (340,17,1);
insert into saleitem values (350,8,2);
insert into saleitem values (350,24,1);
insert into saleitem values (360,8,4);
insert into saleitem values (370,15,1);
insert into saleitem values (370,16,2);
insert into saleitem values (380,3,1);
insert into saleitem values (380,10,3);
insert into saleitem values (380,11,3);
insert into saleitem values (380,12,3);
insert into saleitem values (380,17,3);
insert into saleitem values (390,3,1);
insert into saleitem values (390,12,1);
insert into saleitem values (390,14,1);
insert into saleitem values (390,17,1);
insert into saleitem values (400,1,1);
insert into saleitem values (400,3,1);
insert into saleitem values (400,6,1);
insert into saleitem values (400,12,1);
insert into saleitem values (400,17,1);
insert into saleitem values (410,3,1);
insert into saleitem values (410,6,1);
insert into saleitem values (420,11,1);
insert into saleitem values (420,14,1);
insert into saleitem values (430,17,1);
insert into saleitem values (440,3,1);
insert into saleitem values (440,9,1);
insert into saleitem values (440,11,1);
insert into saleitem values (440,12,2);
insert into saleitem values (450,3,1);
insert into saleitem values (450,11,3);
insert into saleitem values (450,12,1);
insert into saleitem values (460,3,1);
insert into saleitem values (460,9,1);
insert into saleitem values (460,10,1);
insert into saleitem values (460,11,1);
insert into saleitem values (460,12,1);
insert into saleitem values (460,17,1);
insert into saleitem values (470,12,1);
insert into saleitem values (470,14,1);
insert into saleitem values (480,12,2);
insert into saleitem values (480,14,1);
insert into saleitem values (480,17,1);
insert into saleitem values (480,18,1);
insert into saleitem values (490,14,1);
insert into saleitem values (490,20,1);
insert into saleitem values (500,8,1);
insert into saleitem values (500,17,1);
insert into saleitem values (500,18,1);
insert into saleitem values (500,25,1);
insert into saleitem values (510,17,1);
insert into saleitem values (520,3,1);
insert into saleitem values (520,9,1);
insert into saleitem values (520,10,1);
insert into saleitem values (520,11,1);
insert into saleitem values (520,12,1);
insert into saleitem values (520,17,1);

-- item labs2018
insert into item values (1,'Boots Riding','C','Brown',235);
insert into item values (2,'Horse saddle','R','Brown',1895);
insert into item values (3,'Compass - Silva','N','',35.5);
insert into item values (4,'Polo Mallet ','R','Bamboo',45);
insert into item values (5,'Exploring in 10 Easy Lessons','B','',23.95);
insert into item values (6,'Geo positioning system','N','',142.85);
insert into item values (7,'Hammock','F','Multicolour',95.95);
insert into item values (8,'Sun Hat','C','White',35);
insert into item values (9,'How to Win Foreign Friends','B','',29.35);
insert into item values (10,'Map case','E','Brown',30);
insert into item values (11,'Map measure','N','',9.95);
insert into item values (12,'Gortex Rain Coat','C','Green',249.75);
insert into item values (13,'Pocket knife - Steadfast ','E','Brown',70);
insert into item values (14,'Pocket knife - Essential','E','Brown',33);
insert into item values (15,'Camping chair','F','Red',55.95);
insert into item values (16,'BBQ  - Jumbuk','F','',58.9);
insert into item values (17,'Torch','E','',11.75);
insert into item values (18,'Polar Fleece Beanie ','C','Black',22.5);
insert into item values (19,'Tent - 2 person','F','Khaki',399.95);
insert into item values (20,'Tent - 8 person','F','Khaki',785.96);
insert into item values (21,'Tent - 4 person','F','Blue',638.95);
insert into item values (22,'Cowboy Hat','C','Black',215);
insert into item values (23,'Boots - Womens Hiking','C','Grey',160);
insert into item values (24,'Boots - Womens Goretex','C','Grey',289.95);
insert into item values (25,'Boots - Mens Hiking','C','Grey',299.95);


SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

COMMIT;