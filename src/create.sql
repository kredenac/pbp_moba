-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Moba
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Moba
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Moba` DEFAULT CHARACTER SET utf8 ;
USE `Moba` ;

-- -----------------------------------------------------
-- Table `Moba`.`Player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Moba`.`Player` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `level` INT UNSIGNED NOT NULL DEFAULT 1,
  `experience` INT UNSIGNED NOT NULL DEFAULT 0,
  `wins` INT UNSIGNED NOT NULL DEFAULT 0,
  `losses` INT UNSIGNED NOT NULL DEFAULT 0,
  `rank` INT UNSIGNED NOT NULL DEFAULT 1200,
  `password` VARCHAR(32) NOT NULL DEFAULT '098f6bcd4621d373cade4e832627b4f6',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Moba`.`Map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Moba`.`Map` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `starting_gold` INT NOT NULL,
  `expected_game_length` TIME(0) NOT NULL,
  `min_game_length` TIME(0) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Moba`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Moba`.`Item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `cost` INT UNSIGNED NOT NULL,
  `health` INT NOT NULL DEFAULT 0,
  `defense` INT NOT NULL DEFAULT 0,
  `damage` INT NOT NULL DEFAULT 0,
  `mana` INT NOT NULL DEFAULT 0,
  `speed` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Moba`.`Hero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Moba`.`Hero` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `health` INT UNSIGNED NOT NULL DEFAULT 200,
  `mana` INT NOT NULL DEFAULT 200,
  `damage` INT UNSIGNED NOT NULL DEFAULT 30,
  `defense` INT UNSIGNED NOT NULL DEFAULT 30,
  `speed` FLOAT UNSIGNED NOT NULL DEFAULT 300,
  `passive` VARCHAR(255) NOT NULL DEFAULT 'none',
  `spell1` VARCHAR(255) NOT NULL DEFAULT 'none',
  `spell2` VARCHAR(255) NOT NULL DEFAULT 'none',
  `spell3` VARCHAR(255) NOT NULL DEFAULT 'none',
  `spell4` VARCHAR(255) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Moba`.`Skins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Moba`.`Skins` (
  `cost` INT UNSIGNED NOT NULL DEFAULT 3600,
  `heroId` INT NOT NULL DEFAULT 1,
  `name` VARCHAR(45) NOT NULL,
  `is_on_sale` TINYINT(1) NOT NULL DEFAULT 0,
  INDEX `heroId_idx` (`heroId` ASC),
  PRIMARY KEY (`heroId`, `name`),
  CONSTRAINT `heroId`
    FOREIGN KEY (`heroId`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Moba`.`Shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Moba`.`Shop` (
  `Map_id` INT NOT NULL,
  `Item_id` INT NOT NULL,
  `can_buy_at_start` TINYINT NOT NULL,
  INDEX `fk_Map_has_Item_Item1_idx` (`Item_id` ASC),
  INDEX `fk_Map_has_Item_Map1_idx` (`Map_id` ASC),
  PRIMARY KEY (`Map_id`, `Item_id`),
  CONSTRAINT `fk_Map_has_Item_Map1`
    FOREIGN KEY (`Map_id`)
    REFERENCES `Moba`.`Map` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Map_has_Item_Item1`
    FOREIGN KEY (`Item_id`)
    REFERENCES `Moba`.`Item` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Moba`.`Match`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Moba`.`Match` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `length` TIME(0) NOT NULL DEFAULT '00:30:00',
  `Map_id` INT NOT NULL DEFAULT 1,
  `first_team_won` TINYINT NOT NULL,
  `team1_player1` INT NOT NULL,
  `team1_player2` INT NOT NULL,
  `team1_player3` INT NOT NULL,
  `team1_player4` INT NOT NULL,
  `team1_player5` INT NOT NULL,
  `team2_player1` INT NOT NULL,
  `team2_player2` INT NOT NULL,
  `team2_player3` INT NOT NULL,
  `team2_player4` INT NOT NULL,
  `team2_player5` INT NOT NULL,
  `team1_hero1` INT NOT NULL DEFAULT 1,
  `team1_hero2` INT NOT NULL DEFAULT 1,
  `team1_hero3` INT NOT NULL DEFAULT 1,
  `team1_hero4` INT NOT NULL DEFAULT 1,
  `team1_hero5` INT NOT NULL DEFAULT 1,
  `team2_hero1` INT NOT NULL DEFAULT 1,
  `team2_hero2` INT NOT NULL DEFAULT 1,
  `team2_hero3` INT NOT NULL DEFAULT 1,
  `team2_hero4` INT NOT NULL DEFAULT 1,
  `team2_hero5` INT NOT NULL DEFAULT 1,
  INDEX `fk_Player_has_Map1_Map1_idx` (`Map_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_Match_Player1_idx` (`team1_player1` ASC),
  INDEX `player2_idx` (`team1_player2` ASC),
  INDEX `player5_idx` (`team1_player5` ASC),
  INDEX `player4_idx` (`team1_player4` ASC),
  INDEX `player3_idx` (`team1_player3` ASC),
  INDEX `player6_idx` (`team2_player1` ASC),
  INDEX `player7_idx` (`team2_player2` ASC),
  INDEX `player8_idx` (`team2_player3` ASC),
  INDEX `player9_idx` (`team2_player4` ASC),
  INDEX `player10_idx` (`team2_player5` ASC),
  INDEX `hero1_idx` (`team1_hero1` ASC),
  INDEX `hero2_idx` (`team1_hero2` ASC),
  INDEX `hero3_idx` (`team1_hero3` ASC),
  INDEX `hero4_idx` (`team1_hero4` ASC),
  INDEX `hero5_idx` (`team1_hero5` ASC),
  INDEX `hero6_idx` (`team2_hero1` ASC),
  INDEX `hero7_idx` (`team2_hero2` ASC),
  INDEX `hero8_idx` (`team2_hero3` ASC),
  INDEX `hero9_idx` (`team2_hero4` ASC),
  INDEX `hero10_idx` (`team2_hero5` ASC),
  CONSTRAINT `mapId`
    FOREIGN KEY (`Map_id`)
    REFERENCES `Moba`.`Map` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player1`
    FOREIGN KEY (`team1_player1`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player2`
    FOREIGN KEY (`team1_player2`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player3`
    FOREIGN KEY (`team1_player3`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player4`
    FOREIGN KEY (`team1_player4`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player5`
    FOREIGN KEY (`team1_player5`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player6`
    FOREIGN KEY (`team2_player1`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player7`
    FOREIGN KEY (`team2_player2`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player8`
    FOREIGN KEY (`team2_player3`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player9`
    FOREIGN KEY (`team2_player4`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `player10`
    FOREIGN KEY (`team2_player5`)
    REFERENCES `Moba`.`Player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero1`
    FOREIGN KEY (`team1_hero1`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero2`
    FOREIGN KEY (`team1_hero2`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero3`
    FOREIGN KEY (`team1_hero3`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero4`
    FOREIGN KEY (`team1_hero4`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero5`
    FOREIGN KEY (`team1_hero5`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero6`
    FOREIGN KEY (`team2_hero1`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero7`
    FOREIGN KEY (`team2_hero2`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero8`
    FOREIGN KEY (`team2_hero3`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero9`
    FOREIGN KEY (`team2_hero4`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `hero10`
    FOREIGN KEY (`team2_hero5`)
    REFERENCES `Moba`.`Hero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
