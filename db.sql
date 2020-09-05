drop database if exists booking;
create database booking;
use booking;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `booking` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
UPDATE mysql.user SET authentication_string=PASSWORD('pass') WHERE User='root';
FLUSH PRIVILEGES;
-- -----------------------------------------------------
-- Table `booking`.`CarModel`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`CarModel` (
  `CarModelId` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `CarType` ENUM('Convertible','SUV','Mini','Regular') NOT NULL ,
  `ModelName` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`CarModelId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`Color`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`Color` (
  `ColorId` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `ColorName` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`ColorId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`Car`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`Car` (
  `CarId` INT UNSIGNED NOT NULL ,
  `ModelId` MEDIUMINT UNSIGNED NOT NULL ,
  `ColorId` SMALLINT UNSIGNED NOT NULL ,
  `Milage` MEDIUMINT UNSIGNED NOT NULL ,
  `RegistrationNumber` VARCHAR(6) NOT NULL ,
  PRIMARY KEY (`CarId`) ,
  INDEX `fk_Car_CarModel1` (`ModelId` ASC) ,
  INDEX `fk_Car_Color1` (`ColorId` ASC) ,
  CONSTRAINT `fk_Car_CarModel1`
    FOREIGN KEY (`ModelId` )
    REFERENCES `booking`.`CarModel` (`CarModelId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Car_Color1`
    FOREIGN KEY (`ColorId` )
    REFERENCES `booking`.`Color` (`ColorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`Customer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`Customer` (
  `CustomerId` INT UNSIGNED NOT NULL ,
  `FirstName` VARCHAR(45) NOT NULL ,
  `LastName` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`CustomerId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`Phone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`Phone` (
  `PhoneId` INT UNSIGNED NOT NULL ,
  `PhoneType` ENUM('CELL','WORK','HOME') NOT NULL ,
  `Number`  VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`PhoneId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`CustomerPhone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`CustomerPhone` (
  `CustomerId` INT UNSIGNED NOT NULL ,
  `PhoneId` INT UNSIGNED NOT NULL ,
  INDEX `fk_CustomerPhone_Customer` (`CustomerId` ASC) ,
  INDEX `fk_CustomerPhone_Phone1` (`PhoneId` ASC) ,
  CONSTRAINT `fk_CustomerPhone_Customer`
    FOREIGN KEY (`CustomerId` )
    REFERENCES `booking`.`Customer` (`CustomerId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerPhone_Phone1`
    FOREIGN KEY (`PhoneId` )
    REFERENCES `booking`.`Phone` (`PhoneId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`RentalStation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`RentalStation` (
  `RentalStationId` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `Name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`RentalStationId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`CarRentalStation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`CarRentalStation` (
  `CarRentalStationId` INT UNSIGNED NOT NULL ,
  `CarId` INT UNSIGNED NOT NULL ,
  INDEX `fk_CarRentalStation_Car1` (`CarId` ASC) ,
  INDEX `fk_CarRentalStation_RentalStation1` (`CarRentalStationId` ASC) ,
  CONSTRAINT `fk_CarRentalStation_Car1`
    FOREIGN KEY (`CarId` )
    REFERENCES `booking`.`Car` (`CarId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CarRentalStation_RentalStation1`
    FOREIGN KEY (`CarRentalStationId` )
    REFERENCES `booking`.`RentalStation` (`RentalStationId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booking`.`CustomerRental`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `booking`.`CustomerRental` (
  `CustomerId` INT UNSIGNED NOT NULL ,
  `RentalStationId` INT UNSIGNED NOT NULL ,
  `CarId` INT UNSIGNED NOT NULL ,
  `RentFrom` DATE NOT NULL ,
  `RentTo` DATE NOT NULL ,
  INDEX `RentStart` (`RentFrom` ASC) ,
  INDEX `RentEnd` (`RentTo` ASC) ,
  INDEX `fk_CustomerRental_RentalStation1` (`RentalStationId` ASC) ,
  INDEX `fk_CustomerRental_Car1` (`CarId` ASC) ,
  INDEX `fk_CustomerRental_Customer1` (`CustomerId` ASC) ,
  CONSTRAINT `fk_CustomerRental_RentalStation1`
    FOREIGN KEY (`RentalStationId` )
    REFERENCES `booking`.`RentalStation` (`RentalStationId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerRental_Car1`
    FOREIGN KEY (`CarId` )
    REFERENCES `booking`.`Car` (`CarId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CustomerRental_Customer1`
    FOREIGN KEY (`CustomerId` )
    REFERENCES `booking`.`Customer` (`CustomerId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `booking`.`CarModel`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`CarModel` (`CarModelId`, `CarType`, `ModelName`) VALUES (1, 'Mini', 'Ford Fiesta');
INSERT INTO `booking`.`CarModel` (`CarModelId`, `CarType`, `ModelName`) VALUES (2, 'Regular', 'Volvo V40 Automatic');
INSERT INTO `booking`.`CarModel` (`CarModelId`, `CarType`, `ModelName`) VALUES (3, 'Regular', 'Volvo S40 Eco');
INSERT INTO `booking`.`CarModel` (`CarModelId`, `CarType`, `ModelName`) VALUES (4, 'SUV', 'Volvo XC60');
INSERT INTO `booking`.`CarModel` (`CarModelId`, `CarType`, `ModelName`) VALUES (5, 'SUV', 'Ford Transit');
INSERT INTO `booking`.`CarModel` (`CarModelId`, `CarType`, `ModelName`) VALUES (6, 'Convertible', 'Volvo C70');

COMMIT;
show tables;
select * from CarModel;
-- -----------------------------------------------------
-- Data for table `booking`.`Color`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`Color` (`ColorId`, `ColorName`) VALUES (1, 'Red');
INSERT INTO `booking`.`Color` (`ColorId`, `ColorName`) VALUES (2, 'Blue');
INSERT INTO `booking`.`Color` (`ColorId`, `ColorName`) VALUES (3, 'Green');
INSERT INTO `booking`.`Color` (`ColorId`, `ColorName`) VALUES (4, 'White');
INSERT INTO `booking`.`Color` (`ColorId`, `ColorName`) VALUES (5, 'Purple');
INSERT INTO `booking`.`Color` (`ColorId`, `ColorName`) VALUES (6, 'Yellow');

COMMIT;

-- -----------------------------------------------------
-- Data for table `booking`.`Car`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (1, 1, 1, 4324, 'GDS245');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (2, 1, 2, 74322, 'HRE263');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (3, 4, 4, 2544, 'HGS845');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (4, 3, 5, 7355, 'PAL146');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (5, 6, 6, 7353, 'RAI842');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (6, 4, 2, 5363, 'WFD930');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (7, 6, 5, 37678, 'FDE152');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (8, 5, 4, 3577, 'JSD472');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (9, 2, 6, 2312, 'JUR622');
INSERT INTO `booking`.`Car` (`CarId`, `ModelId`, `ColorId`, `Milage`, `RegistrationNumber`) VALUES (10, 1, 2, 3633, 'IRl892');

COMMIT;

-- -----------------------------------------------------
-- Data for table `booking`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`Customer` (`CustomerId`, `FirstName`, `LastName`) VALUES (1, 'Adam', 'Johansson');
INSERT INTO `booking`.`Customer` (`CustomerId`, `FirstName`, `LastName`) VALUES (2, 'Bengt', 'Bengtsson');
INSERT INTO `booking`.`Customer` (`CustomerId`, `FirstName`, `LastName`) VALUES (3, 'Maria', 'Salvander');
INSERT INTO `booking`.`Customer` (`CustomerId`, `FirstName`, `LastName`) VALUES (4, 'Jörgen', 'Terven');
INSERT INTO `booking`.`Customer` (`CustomerId`, `FirstName`, `LastName`) VALUES (5, 'Pakko', 'Alijärvi');
INSERT INTO `booking`.`Customer` (`CustomerId`, `FirstName`, `LastName`) VALUES (6, 'Eva', 'Dahlgren');

COMMIT;

-- -----------------------------------------------------
-- Data for table `booking`.`Phone`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (1, 'CELL', '4243234234');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (2, 'CELL', '4564562322');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (3, 'HOME', '2342466734');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (4, 'HOME', '6465465466');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (5, 'HOME', '2436674564');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (6, 'HOME', '6365374574');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (7, 'HOME', '1434645646');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (8, 'WORK', '2346364566');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (9, 'WORK', '5345345436');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (10, 'WORK', '4565463235');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (11, 'WORK', '2343253356');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (12, 'CELL', '3454366747');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (13, 'CELL', '2342325252');
INSERT INTO `booking`.`Phone` (`PhoneId`, `PhoneType`, `Number`) VALUES (14, 'CELL', '2345253453');

COMMIT;

-- -----------------------------------------------------
-- Data for table `booking`.`CustomerPhone`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (1, 1);
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (1, 3);
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (2, 2);
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (3, 4);
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (4, 5);
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (5, 6);
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (5, 8);
INSERT INTO `booking`.`CustomerPhone` (`CustomerId`, `PhoneId`) VALUES (6, 7);

COMMIT;

-- -----------------------------------------------------
-- Data for table `booking`.`RentalStation`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`RentalStation` (`RentalStationId`, `Name`) VALUES (1, 'Stockholm');
INSERT INTO `booking`.`RentalStation` (`RentalStationId`, `Name`) VALUES (2, 'Göteborg');
INSERT INTO `booking`.`RentalStation` (`RentalStationId`, `Name`) VALUES (3, 'Malmö');
INSERT INTO `booking`.`RentalStation` (`RentalStationId`, `Name`) VALUES (4, 'Sundsvall');

COMMIT;

-- -----------------------------------------------------
-- Data for table `booking`.`CarRentalStation`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (1, 1);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (2, 2);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (3, 1);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (4, 1);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (3, 5);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (3, 6);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (1, 7);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (1, 8);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (1, 9);
INSERT INTO `booking`.`CarRentalStation` (`CarRentalStationId`, `CarId`) VALUES (3, 10);

COMMIT;

-- -----------------------------------------------------
-- Data for table `booking`.`CustomerRental`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (1, 1, 4, '2013-03-10', '2013-03-17');
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (2, 3, 5, '2013-03-16', '2013-03-17');
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (3, 2, 2, '2012-11-10', '2012-11-24');
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (1, 1, 3, '2011-04-14', '2011-04-14');
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (5, 4, 7, '2013-03-07', '2013-03-16');
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (6, 1, 9, '2013-04-05', '2013-05-05');
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (2, 3, 4, '2013-03-18', '2013-03-19');
INSERT INTO `booking`.`CustomerRental` (`CustomerId`, `RentalStationId`, `CarId`, `RentFrom`, `RentTo`) VALUES (4, 1, 6, '2013-02-20', '2013-03-12');

COMMIT;




-- ---------------------------------------------- Procedures--------------------------------
DROP PROCEDURE IF EXISTS getCustomersWithMinOneCell;
DELIMITER //
CREATE PROCEDURE getCustomersWithMinOneCell(
)
BEGIN
	SELECT 
	c.CustomerId as CustomerId, 
	c.FirstName as FirstName, 
	c.LastName as LastName, 
    p.Number as PhoneNumber,
    p.PhoneType as PhoneType,
    cp.PhoneId as PhoneId
FROM 
	Customer c 
INNER JOIN CustomerPhone cp
	ON c.CustomerId = cp.CustomerId
INNER JOIN Phone p 
	ON cp.PhoneId=p.PhoneId
    WHERE 
		c.CustomerId IN ( select CustomerId from CustomerPhone where CustomerPhone.PhoneId IN (SELECT CustomerId FROM Phone WHERE PhoneType='CELL')) 
    AND 
    (SELECT COUNT(*) from CustomerPhone where CustomerId=c.CustomerId) > 1
    ;
END //
DELIMITER ;
 
DROP PROCEDURE IF EXISTS getCarsNotRentedWithinInterval;
DELIMITER //
CREATE PROCEDURE getCarsNotRentedWithinInterval(
IN aStart DATE,
IN aEnd DATE
)
BEGIN
	SELECT
   DISTINCT  rc.CarId,
    car.RegistrationNumber,
	cm.ModelName,
    cm.CarType,
    color.ColorName as Color,
    car.Milage
FROM CustomerRental rc 
INNER JOIN Car as car
	ON car.CarId=rc.CarId
INNER JOIN Color as color
	ON car.ColorId=color.ColorId
INNER JOIN CarModel as cm
	ON car.ModelId=cm.CarModelId
WHERE 
	rc.RentFrom >= aStart
    OR 
    rc.RentTo <= aEnd;
END //
DELIMITER ;

