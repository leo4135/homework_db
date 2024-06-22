-- Creation of a test base...

CREATE DATABASE bank;
USE bank;

CREATE TABLE `physical` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`id_bor` INT,
	`surname` VARCHAR(255),
	`patronymic` VARCHAR(255),
	`passport` VARCHAR(255),
	`inn` VARCHAR(11),
	`snils` VARCHAR(11),
	`driverslic` VARCHAR(255),
	`other` VARCHAR(255),
	`notice` VARCHAR(255),
	`name` VARCHAR(255),
	PRIMARY KEY(`id`)
);

INSERT INTO physical (id, name, surname, patronymic, passport, inn, snils, driverslic) VALUES
(1, 'Ivan', 'Baranov', 'Mihailovich', '1235123', '30947839174', '31947839174', '849271'),
(2, 'Petr', 'Fedorov', 'Dmitryevich', '4655123', '21947839174', '13947839174', '879271'),
(3, 'Dmitry', 'Novikov', 'Leonidovich', '9025123', '90947839174', '21947839174', '129271'),
(4, 'Dave', 'Comunov', 'Stanislavovich', '9745123', '13947839174', '21947839174', '549271'),
(5, 'Nikita', 'Safronov', 'Ivanovich', '0235123' , '31947839174', '30947839174', '769271');


CREATE TABLE `borrowed` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`id_phys` INT NOT NULL,
	`amount` BIGINT NOT NULL DEFAULT 0,
	`percent` INT NOT NULL DEFAULT 0,
	`bet` INT NOT NULL DEFAULT 0,
	`term` DATE,
	`conditions` TEXT(65535),
	`notation` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `organization` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`id_org` INT,
	`id_phys` INT NOT NULL,
	`percent` INT NOT NULL DEFAULT 0,
	`amount` BIGINT NOT NULL DEFAULT 0,
	`bet` INT NOT NULL DEFAULT 0,
	`term` DATE,
	`conditions` TEXT(65535),
	`notation` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `bank` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`inn` VARCHAR(11),
	`type` BINARY(1),
	`adress` VARCHAR(255),
	`amount` BIGINT,
	`conditions` TEXT(65535),
	`notation` TEXT(65535),
	`contracts` TEXT(65535),
	PRIMARY KEY(`id`)
);

ALTER TABLE `borrowed`
ADD FOREIGN KEY(`id_phys`) REFERENCES `physical`(`id`)
ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE `organization`
ADD FOREIGN KEY(`id_phys`) REFERENCES `physical`(`id`)
ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE `physical`
ADD FOREIGN KEY(`id_bor`) REFERENCES `bank`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;



