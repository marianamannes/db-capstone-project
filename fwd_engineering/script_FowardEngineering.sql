-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`addresses` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(200) NULL,
  `zipcode` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`customers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(200) NULL,
  `phone` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_addresses1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `LittleLemonDB`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`cuisines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`cuisines` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu_items` (
  `id` INT UNSIGNED ZEROFILL NOT NULL,
  `course_name` VARCHAR(200) NULL,
  `starter_name` VARCHAR(200) NULL,
  `dessert_name` VARCHAR(200) NULL,
  `drink_name` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`menu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cuisine_id` INT UNSIGNED NOT NULL,
  `menu_item_id` INT UNSIGNED ZEROFILL NOT NULL,
  `name` VARCHAR(200) NULL,
  `cost` FLOAT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_menu_cuisines1_idx` (`cuisine_id` ASC) VISIBLE,
  INDEX `fk_menu_menu_items1_idx` (`menu_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_cuisines1`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `LittleLemonDB`.`cuisines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_menu_items1`
    FOREIGN KEY (`menu_item_id`)
    REFERENCES `LittleLemonDB`.`menu_items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT UNSIGNED NOT NULL,
  `menu_id` INT NOT NULL,
  `order_date` TIMESTAMP NOT NULL,
  `quantity` INT NULL,
  `total_cost` FLOAT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_orders_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `LittleLemonDB`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`status` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`deliveries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_id` INT UNSIGNED NOT NULL,
  `orders_id` INT NOT NULL,
  `delivery_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_deliveries_status1_idx` (`status_id` ASC) VISIBLE,
  INDEX `fk_deliveries_orders1_idx` (`orders_id` ASC) VISIBLE,
  CONSTRAINT `fk_deliveries_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `LittleLemonDB`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliveries_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `LittleLemonDB`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staff_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staff_roles` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(200) NULL,
  `department` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `staff_role_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(200) NULL,
  `salary` FLOAT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_staff_staff_roles1_idx` (`staff_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_staff_roles1`
    FOREIGN KEY (`staff_role_id`)
    REFERENCES `LittleLemonDB`.`staff_roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`bookings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT UNSIGNED NOT NULL,
  `staff_id` INT NOT NULL,
  `booking_date` TIMESTAMP NULL,
  `table_number` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bookings_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_bookings_staff1_idx` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookings_customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `LittleLemonDB`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `LittleLemonDB`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
