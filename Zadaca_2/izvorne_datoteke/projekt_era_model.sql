-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema WebDiP2022x007
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema WebDiP2022x007
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `WebDiP2022x007` DEFAULT CHARACTER SET utf8 ;
USE `WebDiP2022x007` ;

-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Uloga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Uloga` (
  `Uloga_ID` INT NOT NULL,
  `Naziv` ENUM("Adminstrator", "Moderatro", "Registirani korsnik", "Ne registirani korisnik") NOT NULL,
  PRIMARY KEY (`Uloga_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Korisnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Korisnik` (
  `Korsinik_ID` INT NOT NULL,
  `Ime` VARCHAR(50) NOT NULL,
  `Prezime` VARCHAR(50) NOT NULL,
  `Lozinka` CHAR(64) NOT NULL,
  `Lozinka_Sha256` CHAR(64) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `Slika_Korisnika` MEDIUMBLOB NOT NULL,
  `Broj_Neuspjesnih_Prijava` SMALLINT(5) NULL,
  `Datum_Vrijeme_Registracije` DATETIME NOT NULL,
  `Blokiran` TINYINT(1) NULL,
  `Uloga_ID` INT NOT NULL,
  PRIMARY KEY (`Korsinik_ID`),
  UNIQUE INDEX `Korsinik_ID_UNIQUE` (`Korsinik_ID` ASC) ,
  INDEX `fk_Korisnik_Uloga1_idx` (`Uloga_ID` ASC) ,
  CONSTRAINT `fk_Korisnik_Uloga1`
    FOREIGN KEY (`Uloga_ID`)
    REFERENCES `WebDiP2022x007`.`Uloga` (`Uloga_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Nekretnina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Nekretnina` (
  `Nekretnina_ID` INT NOT NULL,
  `Tip_Nekretnine` VARCHAR(30) NOT NULL,
  `Opis_Nekretnine` MEDIUMTEXT NOT NULL,
  `Kvadratura` FLOAT NOT NULL,
  `Slika_Nekretnine` MEDIUMBLOB NOT NULL,
  `Cijena_Najma` FLOAT NOT NULL,
  `Status_Nekretnine` ENUM("Unajmljen", "Slobodan") NOT NULL,
  PRIMARY KEY (`Nekretnina_ID`),
  UNIQUE INDEX `Nekretnina_UNIQUE` (`Nekretnina_ID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Popis nekretnina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Popis nekretnina` (
  `Popis_Nekretnina_ID` INT NOT NULL,
  `Podmiren_Najam` TINYINT NULL,
  `Podmirena_Pričuva` TINYINT NULL,
  `Trenutni_Datum` DATETIME NOT NULL,
  `Korisnik_ID` INT NOT NULL,
  `Nekretnina_ID` INT NOT NULL,
  PRIMARY KEY (`Popis_Nekretnina_ID`),
  INDEX `fk_Popis nekretnina_Korisnik1_idx` (`Korisnik_ID` ASC) ,
  INDEX `fk_Popis nekretnina_Nekretnina1_idx` (`Nekretnina_ID` ASC) ,
  CONSTRAINT `fk_Popis nekretnina_Korisnik1`
    FOREIGN KEY (`Korisnik_ID`)
    REFERENCES `WebDiP2022x007`.`Korisnik` (`Korsinik_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Popis nekretnina_Nekretnina1`
    FOREIGN KEY (`Nekretnina_ID`)
    REFERENCES `WebDiP2022x007`.`Nekretnina` (`Nekretnina_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Nedostatci nekretnina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Nedostatci nekretnina` (
  `Nedostatci_Nekretnina_ID` INT NOT NULL,
  `Opis` MEDIUMTEXT NULL,
  `Važnost` ENUM("Nisko", "Srednje", "Visoko") NULL,
  `Korisnik_ID` INT NOT NULL,
  `Nekretnina_ID` INT NOT NULL,
  PRIMARY KEY (`Nedostatci_Nekretnina_ID`),
  INDEX `fk_Nedostatci nekretnina_Korisnik_idx` (`Korisnik_ID` ASC) ,
  INDEX `fk_Nedostatci nekretnina_Nekretnina1_idx` (`Nekretnina_ID` ASC) ,
  CONSTRAINT `fk_Nedostatci nekretnina_Korisnik`
    FOREIGN KEY (`Korisnik_ID`)
    REFERENCES `WebDiP2022x007`.`Korisnik` (`Korsinik_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nedostatci nekretnina_Nekretnina1`
    FOREIGN KEY (`Nekretnina_ID`)
    REFERENCES `WebDiP2022x007`.`Nekretnina` (`Nekretnina_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Mjesečna pričuva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Mjesečna pričuva` (
  `Pričuva_ID` INT NOT NULL,
  `Datum_Pričuve` DATETIME NOT NULL,
  `Cijena_Pričuve` FLOAT NOT NULL,
  `Broj_Plačenih` INT NULL,
  `Broj_NePlačenih` INT NULL,
  `Korisnik_ID` INT NOT NULL,
  `Nekretnina_ID` INT NOT NULL,
  PRIMARY KEY (`Pričuva_ID`),
  UNIQUE INDEX `Pričuva_ID_UNIQUE` (`Pričuva_ID` ASC) ,
  INDEX `fk_Mjesečna pričuva_Korisnik1_idx` (`Korisnik_ID` ASC) ,
  INDEX `fk_Mjesečna pričuva_Nekretnina1_idx` (`Nekretnina_ID` ASC) ,
  CONSTRAINT `fk_Mjesečna pričuva_Korisnik1`
    FOREIGN KEY (`Korisnik_ID`)
    REFERENCES `WebDiP2022x007`.`Korisnik` (`Korsinik_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mjesečna pričuva_Nekretnina1`
    FOREIGN KEY (`Nekretnina_ID`)
    REFERENCES `WebDiP2022x007`.`Nekretnina` (`Nekretnina_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Nedostatci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Nedostatci` (
  `Nedostatci_ID` INT NOT NULL,
  `Status_Nedostataka` VARCHAR(50) NULL,
  `Opis` MEDIUMTEXT NULL,
  `Korisnik_ID` INT NOT NULL,
  `Nekretnina_ID` INT NOT NULL,
  PRIMARY KEY (`Nedostatci_ID`),
  UNIQUE INDEX `Nedostatci_ID_UNIQUE` (`Nedostatci_ID` ASC) ,
  INDEX `fk_Nedostatci_Korisnik1_idx` (`Korisnik_ID` ASC) ,
  INDEX `fk_Nedostatci_Nekretnina1_idx` (`Nekretnina_ID` ASC) ,
  CONSTRAINT `fk_Nedostatci_Korisnik1`
    FOREIGN KEY (`Korisnik_ID`)
    REFERENCES `WebDiP2022x007`.`Korisnik` (`Korsinik_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nedostatci_Nekretnina1`
    FOREIGN KEY (`Nekretnina_ID`)
    REFERENCES `WebDiP2022x007`.`Nekretnina` (`Nekretnina_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WebDiP2022x007`.`Ugovor o najmu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WebDiP2022x007`.`Ugovor o najmu` (
  `Ugovor_Najam_ID` INT NOT NULL,
  `Datum_Ugovora` DATETIME NOT NULL,
  `Korisnik_ID` INT NOT NULL,
  `Nekretnina_ID` INT NOT NULL,
  PRIMARY KEY (`Ugovor_Najam_ID`),
  UNIQUE INDEX `Ugovor_Najam_ID_UNIQUE` (`Ugovor_Najam_ID` ASC) ,
  INDEX `fk_Ugovor o najmu_Korisnik1_idx` (`Korisnik_ID` ASC) ,
  INDEX `fk_Ugovor o najmu_Nekretnina1_idx` (`Nekretnina_ID` ASC) ,
  CONSTRAINT `fk_Ugovor o najmu_Korisnik1`
    FOREIGN KEY (`Korisnik_ID`)
    REFERENCES `WebDiP2022x007`.`Korisnik` (`Korsinik_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ugovor o najmu_Nekretnina1`
    FOREIGN KEY (`Nekretnina_ID`)
    REFERENCES `WebDiP2022x007`.`Nekretnina` (`Nekretnina_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
