-- MySQL Script generated by MySQL Workbench
-- Fri Jun 18 22:04:42 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema taskforce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema taskforce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `taskforce` DEFAULT CHARACTER SET utf8 ;
USE `taskforce` ;

-- -----------------------------------------------------
-- Table `taskforce`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`cities` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `coord` POINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(256) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `city_id` INT NULL,
  `password_hash` VARCHAR(32) NOT NULL,
  `birthday` DATE NULL,
  `phone` INT NULL,
  `skype` VARCHAR(45) NULL,
  `avatar_id` INT NULL,
  `option_notification_new_message` TINYINT(1) NULL,
  `option_notification_task_change` TINYINT(1) NULL,
  `option_notification_new_comment` TINYINT(1) NULL,
  `option_privacy_do_not_show_profile` TINYINT(1) NULL,
  `option_privacy_show_contacts_only_to_executor` TINYINT(1) NULL,
  `photos_of_work_id` INT NULL,
  `is_executor` TINYINT(1) NULL,
  `date_of_registration` DATETIME NOT NULL,
  `rating` FLOAT NULL,
  `another_contact` VARCHAR(45) NULL,
  `information_about_user` VARCHAR(45) NULL,
  `date_of_last_visit` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `ID_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `ID_idx` (`city_id` ASC) VISIBLE,
  UNIQUE INDEX `skype_UNIQUE` (`skype` ASC) VISIBLE,
  CONSTRAINT `ID`
    FOREIGN KEY (`city_id`)
    REFERENCES `taskforce`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`tasks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` TINYINT(5) NOT NULL,
  `creator_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `price` INT NULL,
  `attachment_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `deadline` DATETIME NULL,
  `date_of_creation` DATETIME NOT NULL,
  `executor_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `ID_idx1` (`category_id` ASC) VISIBLE,
  INDEX `ID_idx2` (`creator_id` ASC) VISIBLE,
  CONSTRAINT `ID`
    FOREIGN KEY (`category_id`)
    REFERENCES `taskforce`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID`
    FOREIGN KEY (`creator_id`)
    REFERENCES `taskforce`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`responses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`responses` (
  `task_id` INT NOT NULL,
  `responser_id` INT NOT NULL,
  `price` INT NOT NULL,
  `comment` VARCHAR(500) NULL,
  INDEX `ID_idx` (`task_id` ASC) VISIBLE,
  INDEX `ID_idx1` (`responser_id` ASC) VISIBLE,
  CONSTRAINT `ID`
    FOREIGN KEY (`task_id`)
    REFERENCES `taskforce`.`tasks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID`
    FOREIGN KEY (`responser_id`)
    REFERENCES `taskforce`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`attachments_`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`attachments_` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`chats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`chats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `recepient_id` INT NOT NULL,
  `sender_id` INT NOT NULL,
  `message` VARCHAR(500) NOT NULL,
  `viewed` TINYINT(1) NOT NULL DEFAULT 0,
  `time` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`reviews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `reviewer_id` INT NOT NULL,
  `mark` INT NOT NULL,
  `text` TEXT(150) NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`user_id` ASC) VISIBLE,
  INDEX `id_idx1` (`reviewer_id` ASC) VISIBLE,
  CONSTRAINT `ID`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID`
    FOREIGN KEY (`reviewer_id`)
    REFERENCES `taskforce`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`attachments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`attachments` (
  `user_id` INT NULL,
  `attachment_id` INT NULL,
  INDEX `ID_idx` (`user_id` ASC) VISIBLE,
  INDEX `ID_idx1` (`attachment_id` ASC) VISIBLE,
  CONSTRAINT `ID`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID`
    FOREIGN KEY (`attachment_id`)
    REFERENCES `taskforce`.`attachments_` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`attachments_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`attachments_task` (
  `task_id` INT NULL,
  `attachment_id` INT NULL,
  INDEX `ID_idx1` (`attachment_id` ASC) VISIBLE,
  INDEX `ID_idx` (`task_id` ASC) VISIBLE,
  CONSTRAINT `ID`
    FOREIGN KEY (`attachment_id`)
    REFERENCES `taskforce`.`attachments_` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID`
    FOREIGN KEY (`task_id`)
    REFERENCES `taskforce`.`tasks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
