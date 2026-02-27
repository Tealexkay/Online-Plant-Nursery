-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Online_Plant_Nursery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Online_Plant_Nursery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Online_Plant_Nursery` DEFAULT CHARACTER SET utf8 ;
USE `Online_Plant_Nursery` ;

-- -----------------------------------------------------
-- Table `Online_Plant_Nursery`.`CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Plant_Nursery`.`CUSTOMER` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Plant_Nursery`.`PRODUCT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Plant_Nursery`.`PRODUCT` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(45) NULL,
  `ProductName` VARCHAR(45) NULL,
  `Price` DECIMAL(10,2) NULL,
  `StoctQty` INT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Plant_Nursery`.`ORDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Plant_Nursery`.`ORDER` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL,
  `OrderStatus` ENUM('InProcess', 'Completed', 'Cancle') NULL DEFAULT 'Completed',
  `TotalAmount` DECIMAL(10,2) NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_ORDER_CUSTOMER_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER_CUSTOMER`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Online_Plant_Nursery`.`CUSTOMER` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Plant_Nursery`.`ORDERITEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Plant_Nursery`.`ORDERITEM` (
  `OrderItemID` INT NOT NULL AUTO_INCREMENT,
  `Quantity` INT NULL,
  `UnitPrice` DECIMAL(10) NULL,
  `OrderID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  INDEX `fk_ORDERITEM_ORDER1_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_ORDERITEM_PRODUCT1_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `fk_ORDERITEM_ORDER1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `Online_Plant_Nursery`.`ORDER` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDERITEM_PRODUCT1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Online_Plant_Nursery`.`PRODUCT` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Online_Plant_Nursery`.`PAYMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Online_Plant_Nursery`.`PAYMENT` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `PaymentMethod` VARCHAR(45) NULL,
  `Amount` DECIMAL(10) NULL,
  `PaymentStatus` VARCHAR(45) NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`PaymentID`),
  UNIQUE INDEX `PaymentID_UNIQUE` (`PaymentID` ASC) VISIBLE,
  INDEX `fk_PAYMENT_ORDER1_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_PAYMENT_ORDER1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `Online_Plant_Nursery`.`ORDER` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
