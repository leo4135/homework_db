-- Creation of a test base...

CREATE DATABASE planets;
USE planets;

CREATE TABLE `Sector` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`coords` TEXT(65535),
	`intensity` TEXT(65535),
	`outsiders` TEXT(65535),
	`count` BIGINT,
	`undefined` TEXT(65535),
	`specified` TEXT(65535),
	`notation` TEXT(65535),
	PRIMARY KEY(`id`)
);


CREATE TABLE `Objects` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`type` TEXT(65535),
	`accuracy` TEXT(65535),
	`count` TEXT(65535),
	`time` TEXT(65535),
	`date` TEXT(65535),
	`notation` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `Natural` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`type` TEXT(65535),
	`galaxy` TEXT(65535),
	`accuracy` TEXT(65535),
	`flow` TEXT(65535),
	`conjugate` TEXT(65535),
	`notation` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `Position` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`earth` TEXT(65535),
	`sun` TEXT(65535),
	`moon` TEXT(65535),
	PRIMARY KEY(`id`)
);

CREATE TABLE `System` (
	`id` INT NOT NULL AUTO_INCREMENT UNIQUE,
	`id_sector` INT,
	`id_objects` INT,
	`id_natural` INT,
	`id_position` INT,
	PRIMARY KEY(`id`)
);

ALTER TABLE `System`
ADD FOREIGN KEY(`id_sector`) REFERENCES `Sector`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `System`
ADD FOREIGN KEY(`id_objects`) REFERENCES `Objects`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `System`
ADD FOREIGN KEY(`id_natural`) REFERENCES `Natural`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `System`
ADD FOREIGN KEY(`id_position`) REFERENCES `Position`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;

DELIMITER //

CREATE PROCEDURE update_object_date()
BEGIN
    -- Проверяем, существует ли столбец "date_update"
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'Sector' AND column_name = 'date_update'
    ) THEN
        -- Если столбец не существует, добавляем его
        ALTER TABLE Sector ADD COLUMN date_update TIMESTAMP;
    END IF;

    -- Обновляем значение "date_update" на текущую дату и время
    UPDATE Sector SET date_update = NOW();
END//

DELIMITER ;
DELIMITER //

CREATE TRIGGER update_objects_date_trigger
BEFORE UPDATE ON Sector
FOR EACH ROW
BEGIN
    SET NEW.date_update = NOW();
END//

DELIMITER ;




