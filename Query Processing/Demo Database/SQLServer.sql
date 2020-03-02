------------------------------------
-- LinkedIn Learning ---------------
-- Advanced SQL - Query Processing -
-- Ami Levin 2020 ------------------
-- .\DemoDB\SQLServer.sql ----------
------------------------------------

USE master;
GO

IF	DB_ID('Animal_Shelter') IS NOT NULL
BEGIN
	ALTER DATABASE Animal_Shelter SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Animal_Shelter;
END;
GO

CREATE DATABASE Animal_Shelter;
GO

USE Animal_Shelter;
GO

BEGIN TRANSACTION;
GO

CREATE SCHEMA Reference;
GO

-- Reference Colors
CREATE	TABLE Reference.Colors 
(
	Color VARCHAR(10) NOT NULL 
		PRIMARY KEY
);
INSERT INTO	Reference.Colors (Color)
VALUES
('Black'), ('Brown'), ('Cream'), ('Ginger'), ('Gray'), ('White');

-- Reference Species
CREATE TABLE Reference.Species 
(
	Species VARCHAR(10) NOT NULL 
		PRIMARY KEY
);
INSERT INTO	Reference.Species (Species)
VALUES
('Cat'), ('Dog'), ('Ferret'), ('Rabbit'), ('Raccoon');

-- Animals
CREATE	TABLE Animals
(
	Name			VARCHAR(20)			NOT NULL,
	Species			VARCHAR(10)			NOT NULL
		REFERENCES Reference.Species (Species),
	Primary_Color	VARCHAR(10)			NOT NULL
		REFERENCES Reference.Colors (Color),
	Implant_Chip_ID	UNIQUEIDENTIFIER	NOT NULL
		UNIQUE,
	Breed			VARCHAR(50)			NULL,
	Gender			CHAR(1)				NOT NULL
		CHECK (Gender IN ('F', 'M')),
	Birth_Date		DATE				NOT NULL,
	Pattern			VARCHAR(20)			NOT NULL,
	Admission_Date	DATE				NOT NULL,
	PRIMARY KEY (Name, Species)
);
INSERT INTO	Animals (Name, Species, Primary_Color, Implant_Chip_ID, Breed, Gender, Birth_Date, Pattern, Admission_Date)
VALUES
('Abby', 'Dog', 'Black', 'fdfdb6fe-3347-4e80-8c8a-2e3235c6d1de', NULL, 'F', CAST('1999-02-19' AS DATE), 'Tricolor', CAST('2016-07-19' AS DATE)),
('Ace', 'Dog', 'Ginger', '33d50c6b-9d2e-4eb1-8171-0466dee4f349', NULL, 'M', CAST('2005-12-19' AS DATE), 'Bicolor', CAST('2019-06-25' AS DATE)),
('Angel', 'Dog', 'Brown', 'f0769a5e-1a11-49f1-ac80-3f40a32ea158', NULL, 'F', CAST('2001-09-19' AS DATE), 'Tuxedo', CAST('2017-02-04' AS DATE)),
('April', 'Rabbit', 'Gray', 'ccfef7e8-6fad-4ba0-81ea-0611dd229e42', NULL, 'F', CAST('2005-01-27' AS DATE), 'Broken', CAST('2019-04-24' AS DATE)),
('Archie', 'Cat', 'Ginger', '970d7094-ab66-4dca-a0d1-0c16264989af', 'Persian', 'M', CAST('2009-08-26' AS DATE), 'Tricolor', CAST('2016-07-10' AS DATE)),
('Arya', 'Dog', 'Gray', 'cd1528ad-c91d-47ea-9b70-3cacd5bdbe71', NULL, 'F', CAST('2014-04-14' AS DATE), 'Bicolor', CAST('2018-06-10' AS DATE)),
('Aspen', 'Dog', 'Brown', '51d4cfd1-cd25-4c5a-aa52-0bfd771f8886', NULL, 'F', CAST('2010-04-17' AS DATE), 'Tuxedo', CAST('2016-02-09' AS DATE)),
('Bailey', 'Dog', 'Ginger', '36438bc9-e225-4038-97b2-1e28fd287957', NULL, 'F', CAST('2014-09-28' AS DATE), 'Bicolor', CAST('2018-10-01' AS DATE)),
('Baloo', 'Rabbit', 'White', 'f5ce3a02-1ec7-431d-8a76-09369e8d798b', 'English Lop', 'M', CAST('2015-04-27' AS DATE), 'Broken', CAST('2016-08-21' AS DATE)),
('Beau', 'Dog', 'Cream', '4b94a68c-0c97-4f70-9275-35b3a9eee8d9', NULL, 'M', CAST('2016-02-09' AS DATE), 'Solid', CAST('2017-05-24' AS DATE)),
('Benji', 'Dog', 'Gray', '646f0a76-14e4-42e7-9554-3af1ea6cc78f', 'English setter', 'M', CAST('2012-05-21' AS DATE), 'Bicolor', CAST('2018-10-02' AS DATE)),
('Benny', 'Dog', 'Brown', '2ae54bbb-a587-49d5-9a4d-1400a303c4bf', NULL, 'M', CAST('2010-03-04' AS DATE), 'Tuxedo', CAST('2018-09-30' AS DATE)),
('Blue', 'Dog', 'Ginger', '6d296d1d-e14d-4308-8b4f-27f87fe1534e', NULL, 'M', CAST('2003-09-03' AS DATE), 'Bicolor', CAST('2016-04-03' AS DATE)),
('Bon bon', 'Rabbit', 'Gray', 'bce7e239-304a-483d-9e38-05b9b66af496', NULL, 'F', CAST('2002-06-29' AS DATE), 'Broken', CAST('2016-01-03' AS DATE)),
('Boomer', 'Dog', 'Black', '01e2ad60-daa5-4681-b934-40c9dcf7d73a', 'Schnauzer', 'M', CAST('2013-08-11' AS DATE), 'Tricolor', CAST('2017-01-11' AS DATE)),
('Brody', 'Dog', 'Black', 'eb517826-e48a-41ae-a5fb-1bbeca23c05d', 'Schnauzer', 'M', CAST('2007-08-23' AS DATE), 'Tricolor', CAST('2018-12-05' AS DATE)),
('Brutus', 'Dog', 'Ginger', 'b7fad096-7cd1-42a7-85d6-0c3e6599dbeb', 'Weimaraner', 'M', CAST('2011-04-04' AS DATE), 'Bicolor', CAST('2018-08-03' AS DATE)),
('Buddy', 'Cat', 'White', '6d49b3f6-e075-4f33-97a3-1d4878ee1345', NULL, 'M', CAST('2017-01-26' AS DATE), 'Tortoiseshell', CAST('2018-12-20' AS DATE)),
('Callie', 'Dog', 'Cream', '2636f17f-5893-482f-94a7-47eeb715047a', 'English setter', 'F', CAST('2003-08-28' AS DATE), 'Solid', CAST('2017-12-19' AS DATE)),
('Charlie', 'Cat', 'Gray', 'ab967364-43cc-4dd2-a4d9-080f0def56ca', NULL, 'M', CAST('2016-06-16' AS DATE), 'Calico', CAST('2018-02-16' AS DATE)),
('Chico', 'Dog', 'Brown', 'c6614119-945a-45a9-a5a2-3c8f840edc01', NULL, 'M', CAST('2014-03-20' AS DATE), 'Tuxedo', CAST('2019-03-22' AS DATE)),
('Chubby', 'Rabbit', 'Ginger', '561fea02-9c12-43b1-9ea8-071c9eae4c55', NULL, 'M', CAST('2013-02-07' AS DATE), 'Broken', CAST('2017-10-31' AS DATE)),
('Cleo', 'Cat', 'Black', '0897655b-1486-4d5d-ad60-03a855afcaf3', NULL, 'F', CAST('2015-08-13' AS DATE), 'Tortoiseshell', CAST('2019-09-06' AS DATE)),
('Cooper', 'Dog', 'Black', '14f9e97b-6cd4-4ee4-9798-1c4f2376141b', NULL, 'M', CAST('2009-11-15' AS DATE), 'Tricolor', CAST('2017-01-15' AS DATE)),
('Cosmo', 'Cat', 'Cream', '2754b9c9-5df4-4206-818d-21bdd1a093ed', NULL, 'M', CAST('2017-11-09' AS DATE), 'Solid', CAST('2019-05-13' AS DATE)),
('Dolly', 'Dog', 'Gray', 'dbdc4f81-1709-49d6-9f73-1d2099eca35c', NULL, 'F', CAST('2013-09-29' AS DATE), 'Bicolor', CAST('2018-04-27' AS DATE)),
('Emma', 'Dog', 'Black', 'bac4c56d-ebb6-43e3-86f3-36506e17f74d', 'Schnauzer', 'F', CAST('2006-12-26' AS DATE), 'Tricolor', CAST('2019-03-28' AS DATE)),
('Fiona', 'Cat', 'Gray', '90226140-f54e-419d-82e5-0ea81e0e6384', NULL, 'F', CAST('1999-05-23' AS DATE), 'Calico', CAST('2017-01-13' AS DATE)),
('Frankie', 'Dog', 'Gray', 'cc96e651-2f1c-45f8-bce2-26ac8c9868a7', 'English setter', 'M', CAST('2003-09-10' AS DATE), 'Bicolor', CAST('2016-06-20' AS DATE)),
('George', 'Cat', 'Brown', '6fefc95e-7d46-4e25-b90a-0ba75f45d972', NULL, 'M', CAST('2001-10-04' AS DATE), 'Bicolor', CAST('2017-11-24' AS DATE)),
('Ginger', 'Dog', 'Ginger', '9e241a82-ad77-49dc-ad15-0ac8d2e89dde', NULL, 'F', CAST('2015-11-17' AS DATE), 'Bicolor', CAST('2016-11-27' AS DATE)),
('Gizmo', 'Dog', 'Brown', '78556795-4748-447f-a2ce-336b01173a18', NULL, 'M', CAST('2006-01-23' AS DATE), 'Tuxedo', CAST('2019-08-14' AS DATE)),
('Gracie', 'Cat', 'Black', '66691184-06b1-4aa8-89b3-0def5fd9fbe1', NULL, 'F', CAST('2007-11-20' AS DATE), 'Spotted', CAST('2017-05-21' AS DATE)),
('Gus', 'Dog', 'Cream', '104a1427-d921-4d11-b45c-370c70e1578f', 'English setter', 'M', CAST('2014-10-29' AS DATE), 'Solid', CAST('2016-09-28' AS DATE)),
('Hobbes', 'Cat', 'Gray', '8788e7b9-dc20-45ef-8778-0066f60d790d', NULL, 'M', CAST('2002-01-01' AS DATE), 'Spotted', CAST('2016-07-29' AS DATE)),
('Holly', 'Dog', 'Cream', 'dd737e6e-3b26-43b4-ad4b-28398602df74', NULL, 'F', CAST('2011-06-13' AS DATE), 'Solid', CAST('2016-12-30' AS DATE)),
('Hudini', 'Rabbit', 'Cream', 'de295dd6-502f-43e3-b139-06ceb3fa2128', NULL, 'M', CAST('2018-03-22' AS DATE), 'Brindle', CAST('2019-12-10' AS DATE)),
('Humphrey', 'Rabbit', 'Cream', '2a423596-5bf8-41a7-906a-0bd3ea15e17c', 'Belgian Hare', 'M', CAST('2008-12-22' AS DATE), 'Brindle', CAST('2017-12-31' AS DATE)),
('Ivy', 'Cat', 'Brown', '0955c70b-a2b6-4d78-8e4b-1f6386ffc763', 'Turkish Angora', 'F', CAST('2013-05-13' AS DATE), 'Spotted', CAST('2018-05-20' AS DATE)),
('Jake', 'Dog', 'White', '9209d54c-0238-457b-9922-02171e9df0e6', 'Bullmastiff', 'M', CAST('2011-02-27' AS DATE), 'Tuxedo', CAST('2016-12-14' AS DATE)),
('Jax', 'Dog', 'Ginger', '24ad2ed9-e7e6-4571-8a45-3c9361418b07', 'Weimaraner', 'M', CAST('2009-02-06' AS DATE), 'Bicolor', CAST('2017-10-03' AS DATE)),
('Kiki', 'Cat', 'Cream', '4e029101-2326-461c-8ff7-0eb809f110cb', NULL, 'F', CAST('2015-07-07' AS DATE), 'Tricolor', CAST('2019-11-16' AS DATE)),
('King', 'Dog', 'Brown', '793e68eb-b952-4425-b9e2-0406ea01ac53', NULL, 'M', CAST('2015-09-12' AS DATE), 'Tuxedo', CAST('2017-08-29' AS DATE)),
('Kona', 'Dog', 'Gray', 'c87ee041-973f-482c-b5e4-3310b4d80612', NULL, 'F', CAST('2008-10-16' AS DATE), 'Bicolor', CAST('2019-12-13' AS DATE)),
('Layla', 'Dog', 'Cream', 'df2e0bbc-acb7-413c-90bc-2aae37aceb90', NULL, 'F', CAST('2006-03-11' AS DATE), 'Solid', CAST('2018-06-14' AS DATE)),
('Lexi', 'Dog', 'Brown', 'bfd890aa-afb6-4e8f-b60b-0124840eb504', NULL, 'F', CAST('2017-09-17' AS DATE), 'Tuxedo', CAST('2018-06-22' AS DATE)),
('Lily', 'Dog', 'Black', '11de2603-8bcf-49b6-9dde-46f893d93948', 'Schnauzer', 'F', CAST('2001-04-03' AS DATE), 'Tricolor', CAST('2016-06-18' AS DATE)),
('Lucy', 'Dog', 'Brown', '3a389eaf-f623-4cd7-9ec9-2144ca9d244c', 'Weimaraner', 'F', CAST('2003-04-04' AS DATE), 'Tuxedo', CAST('2018-02-22' AS DATE)),
('Luke', 'Dog', 'Gray', 'fd6e5e29-0515-47a8-890d-096f07c83738', NULL, 'M', CAST('2017-04-23' AS DATE), 'Bicolor', CAST('2017-12-23' AS DATE)),
('Lulu', 'Cat', 'Ginger', '9f018ecd-7d17-4027-8751-2167300d6cf3', NULL, 'F', CAST('2003-12-19' AS DATE), 'Calico', CAST('2019-10-09' AS DATE)),
('Luna', 'Dog', 'Cream', '74c3566b-a889-4861-b67e-3570aac7247a', NULL, 'F', CAST('2009-01-14' AS DATE), 'Solid', CAST('2017-03-02' AS DATE)),
('Luna', 'Rabbit', 'Black', '202c2c7d-7a25-449d-ad71-05482b04346f', NULL, 'F', CAST('2010-11-16' AS DATE), 'Broken', CAST('2017-08-18' AS DATE)),
('Mac', 'Dog', 'Gray', '3b55a74d-c5f7-44bc-9e6a-11c446628a0d', 'English setter', 'M', CAST('2006-12-23' AS DATE), 'Bicolor', CAST('2018-01-03' AS DATE)),
('Maddie', 'Dog', 'Brown', '2a37b609-d1f6-475f-a890-0234fcb2f0b8', NULL, 'F', CAST('2014-09-26' AS DATE), 'Tuxedo', CAST('2017-05-02' AS DATE)),
('Max', 'Dog', 'Gray', 'eb92c3b9-19bd-4ab1-b0f3-11dd7adb3cf0', NULL, 'M', CAST('2001-12-01' AS DATE), 'Bicolor', CAST('2017-07-26' AS DATE)),
('Millie', 'Dog', 'Ginger', '7d69f605-c2ff-42ac-a5ac-20b63eb881ca', NULL, 'F', CAST('2015-05-18' AS DATE), 'Bicolor', CAST('2016-10-27' AS DATE)),
('Miss Kitty', 'Cat', 'Black', '1ab8347c-6349-4092-9667-09653a9fd09c', 'Maine Coon', 'F', CAST('2016-09-19' AS DATE), 'Bicolor', CAST('2019-10-19' AS DATE)),
('Misty', 'Cat', 'Ginger', '805281a0-5de6-4ba8-8fb1-11cefe0575e0', 'Siamese', 'F', CAST('2009-02-21' AS DATE), 'Spotted', CAST('2019-06-06' AS DATE)),
('Mocha', 'Dog', 'Brown', '63dc76e7-3431-4455-9ad8-2fe4ff72f4af', NULL, 'F', CAST('2002-09-23' AS DATE), 'Tuxedo', CAST('2019-01-10' AS DATE)),
('Nala', 'Dog', 'Gray', '2929bba7-ed35-43f1-9f3e-01120beb4f8b', 'English setter', 'F', CAST('2018-06-02' AS DATE), 'Bicolor', CAST('2019-07-19' AS DATE)),
('Nova', 'Cat', 'White', '81802526-cae2-40bb-846a-01d2156545b4', 'Sphynx', 'F', CAST('2011-04-07' AS DATE), 'Tortoiseshell', CAST('2017-12-09' AS DATE)),
('Odin', 'Dog', 'Ginger', 'd6088551-bad5-41f6-b9a5-09a3a50cb2ff', NULL, 'M', CAST('2007-07-10' AS DATE), 'Bicolor', CAST('2016-09-15' AS DATE)),
('Oscar', 'Cat', 'White', '18c0c340-e7a3-430e-baf5-13c938287d4f', NULL, 'M', CAST('2008-06-08' AS DATE), 'Bicolor', CAST('2018-02-23' AS DATE)),
('Otis', 'Dog', 'Ginger', 'cb5444d8-39fc-4a56-aa83-17e1bfd6e960', NULL, 'M', CAST('2008-05-15' AS DATE), 'Bicolor', CAST('2018-07-22' AS DATE)),
('Patches', 'Cat', 'Gray', '21247670-2e5a-43ef-acf9-0e794463c466', NULL, 'F', CAST('2014-07-29' AS DATE), 'Bicolor', CAST('2018-11-04' AS DATE)),
('Peanut', 'Rabbit', 'Gray', '99a021d1-5e5a-4499-8759-02b3d89ce9af', NULL, 'M', CAST('2008-10-14' AS DATE), 'Broken', CAST('2018-04-11' AS DATE)),
('Pearl', 'Cat', 'Brown', 'df9291b5-9f82-4ad1-a9fd-1206fd6cd837', 'American Bobtail', 'F', CAST('2012-07-05' AS DATE), 'Tricolor', CAST('2019-04-09' AS DATE)),
('Penelope', 'Cat', 'Brown', '5a6a4dc1-b813-4331-b027-1718eb50bc9e', 'Scottish Fold', 'F', CAST('2000-09-21' AS DATE), 'Tabby', CAST('2017-07-12' AS DATE)),
('Penelope', 'Dog', 'White', 'e4e5609a-9c86-4c59-8eee-47ed74ff04b5', 'Bullmastiff', 'F', CAST('2008-06-28' AS DATE), 'Tuxedo', CAST('2016-01-14' AS DATE)),
('Penny', 'Cat', 'Cream', 'b947b10b-c402-4da5-9713-185fd21065c4', NULL, 'F', CAST('2005-11-02' AS DATE), 'Tricolor', CAST('2017-02-15' AS DATE)),
('Piper', 'Dog', 'Ginger', 'b6bd98c9-5f0d-4ac2-81ad-278acf2afd46', NULL, 'F', CAST('2012-03-08' AS DATE), 'Bicolor', CAST('2016-03-21' AS DATE)),
('Poppy', 'Dog', 'Brown', '10e33eb3-a2d5-4fcd-9428-1dbb389fbb30', 'Weimaraner', 'F', CAST('2011-04-09' AS DATE), 'Tuxedo', CAST('2018-05-05' AS DATE)),
('Prince', 'Dog', 'Cream', '06c5cfcb-2c24-4030-acda-06fb3343a173', NULL, 'M', CAST('2016-11-06' AS DATE), 'Solid', CAST('2017-08-29' AS DATE)),
('Pumpkin', 'Cat', 'Gray', '64085fe7-0f2e-4e80-a170-286f1519fda8', 'Russian Blue', 'M', CAST('2002-12-28' AS DATE), 'Spotted', CAST('2019-01-18' AS DATE)),
('Ranger', 'Dog', 'Ginger', '559412c8-2c13-4a18-8b94-481bc06099de', NULL, 'M', CAST('2015-07-12' AS DATE), 'Bicolor', CAST('2017-09-25' AS DATE)),
('Remi / Remy', 'Dog', 'Cream', '835106aa-cfa5-47fb-ba29-0071d1a1592a', NULL, 'M', CAST('2001-08-12' AS DATE), 'Solid', CAST('2018-10-13' AS DATE)),
('Riley', 'Dog', 'Ginger', 'e042131e-2921-442c-9bbd-107507293bb2', NULL, 'F', CAST('2013-05-01' AS DATE), 'Bicolor', CAST('2019-03-08' AS DATE)),
('Rocky', 'Cat', 'Brown', '6c07246c-3107-4651-8f5c-1eb14d1c5ea5', NULL, 'M', CAST('2009-03-26' AS DATE), 'Solid', CAST('2019-11-18' AS DATE)),
('Roxy', 'Dog', 'Brown', '01dfa05c-86b4-4936-a608-1c59097fa2d3', 'Weimaraner', 'F', CAST('2013-03-28' AS DATE), 'Tuxedo', CAST('2018-07-23' AS DATE)),
('Rusty', 'Dog', 'Ginger', '92ffde28-b23a-4249-a32d-07ba417aa143', NULL, 'M', CAST('2005-01-27' AS DATE), 'Bicolor', CAST('2016-01-05' AS DATE)),
('Sadie', 'Cat', 'Gray', 'c231514d-61c1-4180-b679-0bdba7314fd6', NULL, 'F', CAST('2016-08-24' AS DATE), 'Bicolor', CAST('2016-09-19' AS DATE)),
('Salem', 'Cat', 'Ginger', '59f3aa7b-4d2b-49f6-9964-0155880b0473', 'Sphynx', 'M', CAST('2011-02-26' AS DATE), 'Spotted', CAST('2017-10-29' AS DATE)),
('Sam', 'Cat', 'Gray', '27f6f2b4-3570-43e1-8b64-05a1dc86fd8d', NULL, 'M', CAST('2016-09-18' AS DATE), 'Bicolor', CAST('2018-10-09' AS DATE)),
('Sammy', 'Dog', 'Black', '42d68579-c4be-4dc3-9c35-1c40a9ef7b11', NULL, 'M', CAST('2012-08-24' AS DATE), 'Tricolor', CAST('2018-04-05' AS DATE)),
('Samson', 'Dog', 'Ginger', 'a5fa2dc8-9708-465f-9f64-0b39d31be53a', NULL, 'M', CAST('2008-01-24' AS DATE), 'Bicolor', CAST('2018-12-28' AS DATE)),
('Shadow', 'Dog', 'Black', '02dc6920-79bd-430a-a1ed-3196366f9bfe', NULL, 'M', CAST('2014-07-09' AS DATE), 'Tricolor', CAST('2016-04-07' AS DATE)),
('Shelby', 'Dog', 'Gray', '83f5b5b0-af40-4a45-9bdf-0f8ea289e906', NULL, 'F', CAST('2004-08-04' AS DATE), 'Bicolor', CAST('2016-01-28' AS DATE)),
('Simon', 'Cat', 'Gray', '39ed8368-b8bc-433e-8678-0199bce6259e', NULL, 'M', CAST('2008-07-19' AS DATE), 'Bicolor', CAST('2017-10-23' AS DATE)),
('Skye', 'Dog', 'White', 'b7db3359-2e5d-42ab-af61-0f1d97ee195c', 'Bullmastiff', 'F', CAST('2013-12-10' AS DATE), 'Tuxedo', CAST('2016-04-20' AS DATE)),
('Stanley', 'Cat', 'Cream', '44b218ef-c708-46b7-967e-16c16e4ad577', NULL, 'M', CAST('2005-01-19' AS DATE), 'Tabby', CAST('2019-11-26' AS DATE)),
('Stella', 'Dog', 'Cream', '20ccae0a-96ff-43c1-9fd4-2cf0916620ed', NULL, 'F', CAST('2005-03-11' AS DATE), 'Solid', CAST('2017-02-18' AS DATE)),
('Thomas', 'Cat', 'Brown', '265151dd-f5f0-4dcb-a0e7-0371960d9741', NULL, 'M', CAST('2002-12-11' AS DATE), 'Tricolor', CAST('2018-08-04' AS DATE)),
('Thor', 'Dog', 'Black', 'ed0ba7ee-6694-452f-92ab-19bd52a750df', NULL, 'M', CAST('2011-05-28' AS DATE), 'Tricolor', CAST('2016-07-24' AS DATE)),
('Tigger', 'Cat', 'Brown', '6f39f088-a2ea-40fc-9f7e-0dea387a5b59', 'Turkish Angora', 'M', CAST('2005-06-07' AS DATE), 'Tabby', CAST('2016-01-18' AS DATE)),
('Toby', 'Cat', 'Gray', 'e16f5ab8-9e18-4f58-adf8-00be13e5efa0', NULL, 'M', CAST('2012-04-07' AS DATE), 'Spotted', CAST('2019-08-30' AS DATE)),
('Toby', 'Dog', 'White', 'a457d717-2c6b-4ad2-8383-3974df128d4f', 'Bullmastiff', 'M', CAST('2003-10-05' AS DATE), 'Tuxedo', CAST('2019-05-08' AS DATE)),
('Toby', 'Rabbit', 'White', '01dd3b07-ebd6-4a7f-98bc-0a38aa48b139', NULL, 'M', CAST('2011-10-27' AS DATE), 'Broken', CAST('2019-05-23' AS DATE)),
('Tyson', 'Dog', 'Gray', '193e62eb-31cc-49ae-ad45-46cb9cee0efa', NULL, 'M', CAST('2016-01-09' AS DATE), 'Bicolor', CAST('2018-08-19' AS DATE)),
('Walter', 'Dog', 'Cream', '293ae36f-bfbe-4ebc-b90c-4a2be6055cd1', NULL, 'M', CAST('2001-12-24' AS DATE), 'Solid', CAST('2016-02-21' AS DATE)),
('Whitney', 'Rabbit', 'Black', 'f8fc5dfc-b0f1-4c91-ad34-06d16f2dea33', 'Lionhead', 'F', CAST('2017-03-02' AS DATE), 'Broken', CAST('2017-09-08' AS DATE));

-- Persons
CREATE	TABLE Persons
(
	Email		VARCHAR(100)	NOT NULL 
		PRIMARY KEY,
	First_Name	VARCHAR(15)		NOT NULL,
	Last_Name	VARCHAR(15)		NOT NULL,
	Birth_Date	DATE			NULL,
	Address		VARCHAR(100)	NOT NULL,
	State		VARCHAR(20)		NOT NULL,
	City		VARCHAR(30)		NOT NULL,
	Zip_Code	CHAR(5)			NOT NULL
);
INSERT INTO	Persons (Email, First_Name, Last_Name, Birth_Date, Address, State, City, Zip_Code)
VALUES
('adam.brown@gmail.com', 'Adam', 'Brown', CAST('1984-12-22' AS DATE), '41 Hill', 'California', 'Norwalk', '90650'),
('alan.cook@hotmail.com', 'Alan', 'Cook', NULL, '115 Sunset', 'California', 'Inglewood', '90301'),
('albert.wood@gmail.com', 'Albert', 'Wood', CAST('1962-01-30' AS DATE), '780 Sixth', 'California', 'Bell Gardens', '90201'),
('anna.thompson@hotmail.com', 'Anna', 'Thompson', CAST('1997-05-11' AS DATE), '716 Meadow', 'California', 'Los Angeles', '90032'),
('anne.parker@icloud.com', 'Anne', 'Parker', CAST('1973-10-21' AS DATE), '130 Eleventh', 'California', 'Carson', '90248'),
('ashley.adams@icloud.com', 'Ashley', 'Adams', CAST('1984-02-23' AS DATE), '101 North', 'California', 'Carson', '90749'),
('ashley.flores@animalshelter.com', 'Ashley', 'Flores', CAST('1976-04-08' AS DATE), '282 North', 'California', 'Carson', '90749'),
('benjamin.edwards@icloud.com', 'Benjamin', 'Edwards', CAST('1990-01-08' AS DATE), '578 Dogwood', 'California', 'Manhattan Beach', '90266'),
('bonnie.davis@icloud.com', 'Bonnie', 'Davis', CAST('1951-01-29' AS DATE), '193 Lake', 'California', 'West Hollywood', '90048'),
('brenda.martin@gmail.com', 'Brenda', 'Martin', CAST('1952-04-16' AS DATE), '129 South', 'California', 'Santa Monica', '90403'),
('bruce.cook@icloud.com', 'Bruce', 'Cook', CAST('1953-01-12' AS DATE), '667 Church', 'California', 'South Whittier', '90605'),
('bruce.harris@hotmail.com', 'Bruce', 'Harris', CAST('1957-11-26' AS DATE), '370 Church', 'California', 'South Whittier', '90605'),
('carol.mitchell@gmail.com', 'Carol', 'Mitchell', CAST('1994-02-11' AS DATE), '506 Cherry', 'California', 'Torrance', '90503'),
('carolyn.nelson@icloud.com', 'Carolyn', 'Nelson', CAST('1985-11-27' AS DATE), '39 Third', 'California', 'Whittier', '90605'),
('catherine.howard@icloud.com', 'Catherine', 'Howard', CAST('1952-03-07' AS DATE), '806 Second', 'California', 'Los Angeles', '90068'),
('catherine.nguyen@hotmail.com', 'Catherine', 'Nguyen', CAST('1946-03-29' AS DATE), '882 Second', 'California', 'Los Angeles', '90068'),
('charles.phillips@gmail.com', 'Charles', 'Phillips', CAST('1980-05-11' AS DATE), '812 Hill', 'California', 'Long Beach', '90813'),
('cynthia.campbell@hotmail.com', 'Cynthia', 'Campbell', CAST('1969-01-02' AS DATE), '902 Eighth', 'California', 'Inglewood', '90307'),
('denise.ortiz@yahoo.com', 'Denise', 'Ortiz', CAST('1982-04-01' AS DATE), '996 Cherry', 'California', 'Santa Monica', '90407'),
('dennis.hill@animalshelter.com', 'Dennis', 'Hill', NULL, '941 Thirteenth', 'California', 'Gardena', '90247'),
('diane.thompson@hotmail.com', 'Diane', 'Thompson', CAST('1998-06-25' AS DATE), '762 Church', 'California', 'Willowbrook', '90059'),
('donna.brooks@hotmail.com', 'Donna', 'Brooks', CAST('1966-04-05' AS DATE), '972 Cherry', 'California', 'Los Angeles', '90068'),
('doris.young@icloud.com', 'Doris', 'Young', CAST('1954-02-15' AS DATE), '511 Ridge', 'California', 'Torrance', '90501'),
('elizabeth.clark@icloud.com', 'Elizabeth', 'Clark', CAST('1949-02-23' AS DATE), '443 Twelfth', 'California', 'Rancho Palos Verdes', '90275'),
('emily.perez@gmail.com', 'Emily', 'Perez', CAST('1971-08-25' AS DATE), '759 Dogwood', 'California', 'Lynwood', '90262'),
('eugene.howard@icloud.com', 'Eugene', 'Howard', CAST('1958-01-20' AS DATE), '647 Eleventh', 'California', 'Inglewood', '90309'),
('evelyn.rodriguez@outlook.com', 'Evelyn', 'Rodriguez', CAST('1965-04-10' AS DATE), '793 Sixth', 'California', 'West Rancho Dominguez', '90059'),
('frances.cook@yahoo.com', 'Frances', 'Cook', CAST('1973-08-13' AS DATE), '351 Forest', 'California', 'Compton', '90220'),
('frances.hill@animalshelter.com', 'Frances', 'Hill', CAST('1953-01-29' AS DATE), '406 Forest', 'California', 'Compton', '90220'),
('frank.smith@icloud.com', 'Frank', 'Smith', CAST('1997-09-20' AS DATE), '390 Jefferson', 'California', 'Walnut Park', '90255'),
('fred.james@gmail.com', 'Fred', 'James', CAST('1972-08-08' AS DATE), '293 Second', 'California', 'Los Angeles', '90069'),
('fred.patel@gmail.com', 'Fred', 'Patel', CAST('1953-03-10' AS DATE), '899 Second', 'California', 'Los Angeles', '90069'),
('george.nzalez@icloud.com', 'George', 'nzalez', CAST('1952-12-11' AS DATE), '209 Cedar', 'California', 'Los Angeles', '90004'),
('george.scott@hotmail.com', 'George', 'Scott', CAST('1982-05-03' AS DATE), '424 Cedar', 'California', 'Los Angeles', '90004'),
('gerald.reyes@animalshelter.com', 'Gerald', 'Reyes', CAST('1956-02-10' AS DATE), '761 Eighth', 'California', 'Long Beach', '90853'),
('gerald.thompson@icloud.com', 'Gerald', 'Thompson', CAST('1994-04-07' AS DATE), '631 Eighth', 'California', 'Long Beach', '90853'),
('gloria.wright@hotmail.com', 'Gloria', 'Wright', CAST('1947-12-21' AS DATE), '439 Fourteenth', 'California', 'Whittier', '90603'),
('grery.evans@icloud.com', 'Grery', 'Evans', CAST('1967-12-22' AS DATE), '481 Seventh', 'California', 'East Rancho Dominguez', '90221'),
('grery.james@icloud.com', 'Grery', 'James', CAST('1994-09-24' AS DATE), '337 Seventh', 'California', 'East Rancho Dominguez', '90221'),
('harold.clark@icloud.com', 'Harold', 'Clark', CAST('1987-09-26' AS DATE), '771 Ninth', 'California', 'Whittier', '90601'),
('harry.wilson@yahoo.com', 'Harry', 'Wilson', CAST('1976-02-06' AS DATE), '886 Elm', 'California', 'Compton', '90223'),
('heather.turner@yahoo.com', 'Heather', 'Turner', CAST('1974-09-11' AS DATE), '909 Twelfth', 'California', 'Paramount', '90723'),
('howard.bailey@gmail.com', 'Howard', 'Bailey', CAST('1995-11-13' AS DATE), '1000 Adams', 'California', 'View Park-Windsor Hills', '90056'),
('irene.mendoza@gmail.com', 'Irene', 'Mendoza', CAST('1985-11-23' AS DATE), '84 Elm', 'California', 'Florence-Graham', '90052'),
('jacqueline.phillips@gmail.com', 'Jacqueline', 'Phillips', NULL, '519 Johnson', 'California', 'Long Beach', '90853'),
('james.ramos@hotmail.com', 'James', 'Ramos', CAST('1962-08-07' AS DATE), '968 Cherry', 'California', 'Carson', '90745'),
('janet.evans@gmail.com', 'Janet', 'Evans', CAST('1980-12-07' AS DATE), '519 Oak', 'California', 'Lakewood', '90711'),
('jeffrey.mez@gmail.com', 'Jeffrey', 'mez', CAST('1961-04-17' AS DATE), '51 Cedar', 'California', 'Whittier', '90603'),
('jerry.cox@icloud.com', 'Jerry', 'Cox', CAST('1958-04-04' AS DATE), '353 Johnson', 'California', 'South Whittier', '90605'),
('jerry.mitchell@icloud.com', 'Jerry', 'Mitchell', CAST('1981-09-22' AS DATE), '732 Johnson', 'California', 'South Whittier', '90605'),
('jesse.cox@yahoo.com', 'Jesse', 'Cox', CAST('1990-07-26' AS DATE), '544 North', 'California', 'South Gate', '90280'),
('jesse.myers@gmail.com', 'Jesse', 'Myers', CAST('1975-02-14' AS DATE), '684 North', 'California', 'South Gate', '90280'),
('jessica.ward@icloud.com', 'Jessica', 'Ward', CAST('1953-11-28' AS DATE), '515 West', 'California', 'Downey', '90242'),
('jimmy.jones@yahoo.com', 'Jimmy', 'Jones', NULL, '226 Fourth', 'California', 'Inglewood', '90303'),
('joan.cooper@icloud.com', 'Joan', 'Cooper', CAST('1986-04-03' AS DATE), '173 West', 'California', 'Compton', '90221'),
('jonathan.mez@hotmail.com', 'Jonathan', 'mez', CAST('1989-07-09' AS DATE), '319 Johnson', 'California', 'Los Angeles', '90069'),
('joyce.nzalez@hotmail.com', 'Joyce', 'nzalez', CAST('1970-07-02' AS DATE), '204 Cedar', 'California', 'View Park-Windsor Hills', '90043'),
('julia.flores@yahoo.com', 'Julia', 'Flores', CAST('1988-01-12' AS DATE), '442 Lake view', 'California', 'Bell Gardens', '90201'),
('julie.adams@gmail.com', 'Julie', 'Adams', CAST('1957-01-31' AS DATE), '133 Hill', 'California', 'Gardena', '90247'),
('julie.price@icloud.com', 'Julie', 'Price', CAST('1962-11-29' AS DATE), '2 Hill', 'California', 'Gardena', '90247'),
('justin.ruiz@hotmail.com', 'Justin', 'Ruiz', CAST('1991-07-13' AS DATE), '157 Church', 'California', 'Gardena', '90247'),
('justin.sanchez@yahoo.com', 'Justin', 'Sanchez', CAST('1992-02-03' AS DATE), '415 Church', 'California', 'Gardena', '90247'),
('karen.smith@icloud.com', 'Karen', 'Smith', CAST('1948-03-01' AS DATE), '110 North', 'California', 'West Rancho Dominguez', '90220'),
('katherine.murphy@gmail.com', 'Katherine', 'Murphy', CAST('1957-05-15' AS DATE), '191 Lincoln', 'California', 'Commerce', '90022'),
('katherine.price@gmail.com', 'Katherine', 'Price', CAST('1997-09-23' AS DATE), '949 Lincoln', 'California', 'Commerce', '90022'),
('kathryn.lopez@icloud.com', 'Kathryn', 'Lopez', CAST('1990-08-30' AS DATE), '622 Madison', 'California', 'Los Angeles', '90034'),
('kathy.thomas@gmail.com', 'Kathy', 'Thomas', CAST('1952-04-08' AS DATE), '427 Main', 'California', 'Lakewood', '90712'),
('kelly.allen@hotmail.com', 'Kelly', 'Allen', NULL, '651 Hickory', 'California', 'Long Beach', '90840'),
('kevin.diaz@hotmail.com', 'Kevin', 'Diaz', CAST('1974-01-18' AS DATE), '262 Jackson', 'California', 'Torrance', '90509'),
('kimberly.morgan@gmail.com', 'Kimberly', 'Morgan', CAST('1956-01-29' AS DATE), '2 Washington', 'California', 'Torrance', '90503'),
('laura.young@gmail.com', 'Laura', 'Young', CAST('1987-05-19' AS DATE), '29 First', 'California', 'Torrance', '90503'),
('linda.kelly@gmail.com', 'Linda', 'Kelly', CAST('1997-04-26' AS DATE), '51 Seventh', 'California', 'Compton', '90221'),
('lisa.perez@icloud.com', 'Lisa', 'Perez', CAST('1949-08-08' AS DATE), '502 River', 'California', 'Hawthorne', '90310'),
('lori.smith@icloud.com', 'Lori', 'Smith', CAST('1977-02-11' AS DATE), '324 Sixth', 'California', 'Signal Hill', '90755'),
('margaret.campbell@hotmail.com', 'Margaret', 'Campbell', CAST('1960-11-03' AS DATE), '424 Eleventh', 'California', 'Los Angeles', '90247'),
('margaret.hall@gmail.com', 'Margaret', 'Hall', CAST('1994-09-15' AS DATE), '344 Eleventh', 'California', 'Los Angeles', '90247'),
('matthew.lopez@gmail.com', 'Matthew', 'Lopez', CAST('1988-02-15' AS DATE), '38 Dogwood', 'California', 'Torrance', '90510'),
('matthew.ward@icloud.com', 'Matthew', 'Ward', CAST('1949-12-04' AS DATE), '240 Dogwood', 'California', 'Torrance', '90510'),
('melissa.lopez@gmail.com', 'Melissa', 'Lopez', NULL, '43 Park', 'California', 'Bell Gardens', '90202'),
('melissa.moore@icloud.com', 'Melissa', 'Moore', CAST('1960-06-27' AS DATE), '156 Park', 'California', 'Bell Gardens', '90202'),
('mildred.gray@yahoo.com', 'Mildred', 'Gray', CAST('1949-03-23' AS DATE), '193 Sixth', 'California', 'Long Beach', '90847'),
('nancy.howard@hotmail.com', 'Nancy', 'Howard', CAST('1970-03-15' AS DATE), '587 Hickory', 'California', 'Carson', '90224'),
('nicholas.rivera@icloud.com', 'Nicholas', 'Rivera', CAST('1993-09-07' AS DATE), '129 Adams', 'California', 'Long Beach', '90853'),
('nicole.evans@gmail.com', 'Nicole', 'Evans', CAST('1954-07-02' AS DATE), '608 Jefferson', 'California', 'Signal Hill', '90755'),
('nicole.mendoza@gmail.com', 'Nicole', 'Mendoza', NULL, '76 Jefferson', 'California', 'Signal Hill', '90755'),
('patricia.wright@icloud.com', 'Patricia', 'Wright', CAST('1953-07-18' AS DATE), '486 Chestnut', 'California', 'Santa Fe Springs', '90670'),
('patrick.hughes@animalshelter.com', 'Patrick', 'Hughes', CAST('1988-10-11' AS DATE), '660 Spruce', 'California', 'La Mirada', '90638'),
('peter.smith@hotmail.com', 'Peter', 'Smith', CAST('1986-08-27' AS DATE), '56 Main', 'California', 'Los Angeles', '90004'),
('phyllis.davis@icloud.com', 'Phyllis', 'Davis', CAST('1993-10-20' AS DATE), '508 Eighth', 'California', 'Santa Monica', '90408'),
('phyllis.moore@gmail.com', 'Phyllis', 'Moore', CAST('1988-09-22' AS DATE), '583 Eighth', 'California', 'Santa Monica', '90408'),
('randy.bailey@icloud.com', 'Randy', 'Bailey', CAST('1973-07-13' AS DATE), '980 Oak', 'California', 'Compton', '90223'),
('richard.castillo@icloud.com', 'Richard', 'Castillo', CAST('1978-12-26' AS DATE), '287 River', 'California', 'Culver City', '90233'),
('robin.miller@yahoo.com', 'Robin', 'Miller', CAST('1965-12-11' AS DATE), '216 Hill', 'California', 'East Los Angeles', '90022'),
('robin.murphy@animalshelter.com', 'Robin', 'Murphy', CAST('1974-10-13' AS DATE), '673 Hill', 'California', 'East Los Angeles', '90022'),
('roger.adams@hotmail.com', 'Roger', 'Adams', CAST('1947-05-09' AS DATE), '639 West', 'California', 'Los Angeles', '90031'),
('roy.rogers@hotmail.com', 'Roy', 'Rogers', CAST('1958-07-29' AS DATE), '836 Twelfth', 'California', 'Los Angeles', '90039'),
('ruby.lopez@yahoo.com', 'Ruby', 'Lopez', CAST('1979-04-05' AS DATE), '808 Cedar', 'California', 'Long Beach', '90804'),
('ryan.garcia@hotmail.com', 'Ryan', 'Garcia', CAST('1975-03-09' AS DATE), '787 Wilson', 'California', 'Downey', '90239'),
('ryan.hill@icloud.com', 'Ryan', 'Hill', CAST('1960-11-03' AS DATE), '105 Wilson', 'California', 'Downey', '90239'),
('ryan.jackson@icloud.com', 'Ryan', 'Jackson', CAST('1947-10-07' AS DATE), '487 Wilson', 'California', 'Downey', '90239'),
('ryan.wright@hotmail.com', 'Ryan', 'Wright', NULL, '600 Wilson', 'California', 'Downey', '90239'),
('samuel.baker@gmail.com', 'Samuel', 'Baker', CAST('1980-01-17' AS DATE), '889 Maple', 'California', 'Los Angeles', '90247'),
('samuel.morales@icloud.com', 'Samuel', 'Morales', NULL, '896 Maple', 'California', 'Los Angeles', '90247'),
('sara.nelson@icloud.com', 'Sara', 'Nelson', CAST('1990-10-15' AS DATE), '340 Fifth', 'California', 'View Park-Windsor Hills', '90043'),
('scott.baker@gmail.com', 'Scott', 'Baker', CAST('1986-01-11' AS DATE), '190 Lake view', 'California', 'Los Angeles', '90089'),
('scott.gutierrez@gmail.com', 'Scott', 'Gutierrez', CAST('1985-11-26' AS DATE), '993 Lake view', 'California', 'Los Angeles', '90089'),
('sean.nelson@icloud.com', 'Sean', 'Nelson', CAST('1986-04-28' AS DATE), '339 Ninth', 'California', 'Los Angeles', '90034'),
('sharon.davis@animalshelter.com', 'Sharon', 'Davis', CAST('1988-09-25' AS DATE), '372 Seventh', 'California', 'Los Angeles', '90068'),
('sharon.thompson@gmail.com', 'Sharon', 'Thompson', CAST('1970-06-24' AS DATE), '688 Seventh', 'California', 'Los Angeles', '90068'),
('shirley.williams@outlook.com', 'Shirley', 'Williams', CAST('1966-08-17' AS DATE), '11 Lincoln', 'California', 'Santa Monica', '90408'),
('stephanie.mez@icloud.com', 'Stephanie', 'mez', CAST('1994-06-26' AS DATE), '539 West', 'California', 'Long Beach', '90899'),
('susan.murphy@icloud.com', 'Susan', 'Murphy', CAST('1961-08-02' AS DATE), '246 Spruce', 'California', 'Long Beach', '90808'),
('theresa.carter@icloud.com', 'Theresa', 'Carter', CAST('1968-08-27' AS DATE), '401 Lincoln', 'California', 'Long Beach', '90831'),
('timothy.anderson@gmail.com', 'Timothy', 'Anderson', CAST('1973-05-08' AS DATE), '33 Seventh', 'California', 'Commerce', '90023'),
('virginia.baker@gmail.com', 'Virginia', 'Baker', CAST('1990-11-25' AS DATE), '6 Jefferson', 'California', 'Santa Monica', '90410'),
('walter.edwards@icloud.com', 'Walter', 'Edwards', CAST('1963-09-04' AS DATE), '137 Church', 'California', 'Pico Rivera', '90661'),
('wanda.gray@icloud.com', 'Wanda', 'Gray', CAST('1963-03-18' AS DATE), '946 Cedar', 'California', 'Los Angeles', '90710'),
('wanda.myers@animalshelter.com', 'Wanda', 'Myers', CAST('1975-02-05' AS DATE), '663 Cedar', 'California', 'Los Angeles', '90710'),
('wayne.carter@animalshelter.com', 'Wayne', 'Carter', CAST('1988-03-15' AS DATE), '341 Washington', 'California', 'Inglewood', '90309'),
('wayne.turner@icloud.com', 'Wayne', 'Turner', CAST('1966-02-18' AS DATE), '350 Washington', 'California', 'Inglewood', '90309');

-- Staff
CREATE	TABLE Staff
(
	Email		VARCHAR(100)	NOT NULL 
		PRIMARY KEY
		REFERENCES Persons(Email), 
	Hire_Date DATE			NOT NULL
);
INSERT INTO	Staff (Email, Hire_Date)
VALUES
('ashley.flores@animalshelter.com', CAST('2016-01-01' AS DATE)),
('dennis.hill@animalshelter.com', CAST('2018-10-07' AS DATE)),
('frances.hill@animalshelter.com', CAST('2016-01-01' AS DATE)),
('gerald.reyes@animalshelter.com', CAST('2018-03-20' AS DATE)),
('patrick.hughes@animalshelter.com', CAST('2018-12-15' AS DATE)),
('robin.murphy@animalshelter.com', CAST('2018-08-15' AS DATE)),
('sharon.davis@animalshelter.com', CAST('2016-01-01' AS DATE)),
('wanda.myers@animalshelter.com', CAST('2016-01-01' AS DATE)),
('wayne.carter@animalshelter.com', CAST('2018-04-02' AS DATE));

-- Staff Roles
CREATE	TABLE Staff_Roles 
(
	Role VARCHAR(20) NOT NULL PRIMARY KEY 
);
INSERT INTO	Staff_Roles (Role)
VALUES
('Assistant'),
('Janitor'),
('Manager'),
('Receptionist'),
('Veterinarian');

-- Staff Assignments
CREATE TABLE Staff_Assignments
(
	Email		VARCHAR(100)	NOT NULL
		REFERENCES Staff (Email) ON UPDATE CASCADE,
	Role		VARCHAR(20)		NOT NULL
		REFERENCES Staff_Roles (Role),
	Assigned	DATE			NOT NULL,
	PRIMARY KEY (Email, Role)
);
INSERT INTO	Staff_Assignments (Email, Role, Assigned)
VALUES
('ashley.flores@animalshelter.com', 'Veterinarian', CAST('2016-01-01' AS DATE)),
('dennis.hill@animalshelter.com', 'Veterinarian', CAST('2018-10-07' AS DATE)),
('frances.hill@animalshelter.com', 'Receptionist', CAST('2016-01-01' AS DATE)),
('gerald.reyes@animalshelter.com', 'Assistant', CAST('2018-03-20' AS DATE)),
('patrick.hughes@animalshelter.com', 'Receptionist', CAST('2018-12-15' AS DATE)),
('robin.murphy@animalshelter.com', 'Assistant', CAST('2018-08-15' AS DATE)),
('sharon.davis@animalshelter.com', 'Manager', CAST('2016-01-01' AS DATE)),
('wanda.myers@animalshelter.com', 'Assistant', CAST('2016-01-01' AS DATE)),
('wayne.carter@animalshelter.com', 'Assistant', CAST('2018-04-02' AS DATE));

-- Adoptions
CREATE	TABLE Adoptions
(
	Name			VARCHAR(20)		NOT NULL,
	Species			VARCHAR(10)		NOT NULL,
	Adopter_Email	VARCHAR(100)	NOT NULL
		REFERENCES Persons (Email) ON UPDATE CASCADE,
	Adoption_Date	DATE			NOT NULL,
	Adoption_Fee	SMALLINT		NOT NULL
		CHECK (Adoption_Fee >= (0)),
	PRIMARY KEY (Name, Species, Adopter_Email ),
	FOREIGN KEY (Name, Species)
		REFERENCES Animals (Name, Species) ON UPDATE CASCADE
);
INSERT INTO	Adoptions (Name, Species, Adopter_Email, Adoption_Date, Adoption_Fee)
VALUES
('Abby', 'Dog', 'patrick.hughes@animalshelter.com', CAST('2018-08-30' AS DATE), 58),
('Ace', 'Dog', 'justin.ruiz@hotmail.com', CAST('2019-10-26' AS DATE), 68),
('Archie', 'Cat', 'patrick.hughes@animalshelter.com', CAST('2018-08-30' AS DATE), 82),
('Bailey', 'Dog', 'wayne.turner@icloud.com', CAST('2019-07-26' AS DATE), 50),
('Baloo', 'Rabbit', 'jesse.cox@yahoo.com', CAST('2017-12-16' AS DATE), 58),
('Beau', 'Dog', 'shirley.williams@outlook.com', CAST('2018-04-15' AS DATE), 90),
('Benji', 'Dog', 'sharon.davis@animalshelter.com', CAST('2018-11-18' AS DATE), 97),
('Brody', 'Dog', 'george.scott@hotmail.com', CAST('2019-02-21' AS DATE), 83),
('Brutus', 'Dog', 'virginia.baker@gmail.com', CAST('2019-01-28' AS DATE), 66),
('Buddy', 'Cat', 'karen.smith@icloud.com', CAST('2019-09-27' AS DATE), 73),
('Callie', 'Dog', 'peter.smith@hotmail.com', CAST('2018-09-06' AS DATE), 57),
('Chico', 'Dog', 'lori.smith@icloud.com', CAST('2019-12-29' AS DATE), 86),
('Chubby', 'Rabbit', 'adam.brown@gmail.com', CAST('2018-05-27' AS DATE), 65),
('Cleo', 'Cat', 'melissa.lopez@gmail.com', CAST('2019-12-15' AS DATE), 56),
('Cooper', 'Dog', 'lisa.perez@icloud.com', CAST('2018-01-10' AS DATE), 61),
('Cosmo', 'Cat', 'diane.thompson@hotmail.com', CAST('2019-06-16' AS DATE), 100),
('Dolly', 'Dog', 'laura.young@gmail.com', CAST('2019-12-30' AS DATE), 93),
('Emma', 'Dog', 'melissa.moore@icloud.com', CAST('2019-12-28' AS DATE), 76),
('Fiona', 'Cat', 'jerry.mitchell@icloud.com', CAST('2018-02-23' AS DATE), 96),
('George', 'Cat', 'kevin.diaz@hotmail.com', CAST('2018-09-13' AS DATE), 97),
('Ginger', 'Dog', 'julie.adams@gmail.com', CAST('2017-03-07' AS DATE), 79),
('Gizmo', 'Dog', 'lori.smith@icloud.com', CAST('2019-12-26' AS DATE), 54),
('Gracie', 'Cat', 'gerald.reyes@animalshelter.com', CAST('2017-09-09' AS DATE), 82),
('Gus', 'Dog', 'frances.cook@yahoo.com', CAST('2018-12-29' AS DATE), 96),
('Hobbes', 'Cat', 'timothy.anderson@gmail.com', CAST('2017-11-08' AS DATE), 73),
('Hudini', 'Rabbit', 'kathy.thomas@gmail.com', CAST('2019-12-24' AS DATE), 57),
('Humphrey', 'Rabbit', 'kelly.allen@hotmail.com', CAST('2019-01-17' AS DATE), 85),
('Jake', 'Dog', 'shirley.williams@outlook.com', CAST('2019-11-12' AS DATE), 84),
('Jax', 'Dog', 'wayne.turner@icloud.com', CAST('2018-04-01' AS DATE), 85),
('Kiki', 'Cat', 'james.ramos@hotmail.com', CAST('2019-12-01' AS DATE), 87),
('King', 'Dog', 'charles.phillips@gmail.com', CAST('2019-07-18' AS DATE), 57),
('Lexi', 'Dog', 'virginia.baker@gmail.com', CAST('2018-07-28' AS DATE), 54),
('Lily', 'Dog', 'mildred.gray@yahoo.com', CAST('2019-09-01' AS DATE), 99),
('Lucy', 'Dog', 'richard.castillo@icloud.com', CAST('2018-07-07' AS DATE), 78),
('Luke', 'Dog', 'ryan.garcia@hotmail.com', CAST('2018-05-04' AS DATE), 65),
('Luna', 'Rabbit', 'ryan.wright@hotmail.com', CAST('2019-04-14' AS DATE), 55),
('Mac', 'Dog', 'randy.bailey@icloud.com', CAST('2018-06-12' AS DATE), 51),
('Maddie', 'Dog', 'theresa.carter@icloud.com', CAST('2017-09-18' AS DATE), 87),
('Max', 'Dog', 'roy.rogers@hotmail.com', CAST('2017-09-23' AS DATE), 62),
('Millie', 'Dog', 'richard.castillo@icloud.com', CAST('2018-05-21' AS DATE), 98),
('Miss Kitty', 'Cat', 'anna.thompson@hotmail.com', CAST('2019-11-11' AS DATE), 83),
('Misty', 'Cat', 'frances.hill@animalshelter.com', CAST('2019-12-13' AS DATE), 86),
('Mocha', 'Dog', 'roger.adams@hotmail.com', CAST('2019-07-22' AS DATE), 93),
('Nala', 'Dog', 'wayne.turner@icloud.com', CAST('2019-07-26' AS DATE), 77),
('Nova', 'Cat', 'walter.edwards@icloud.com', CAST('2018-09-03' AS DATE), 98),
('Oscar', 'Cat', 'bruce.harris@hotmail.com', CAST('2018-11-19' AS DATE), 79),
('Otis', 'Dog', 'doris.young@icloud.com', CAST('2019-08-02' AS DATE), 51),
('Peanut', 'Rabbit', 'richard.castillo@icloud.com', CAST('2019-03-21' AS DATE), 83),
('Pearl', 'Cat', 'doris.young@icloud.com', CAST('2019-10-13' AS DATE), 94),
('Penelope', 'Cat', 'emily.perez@gmail.com', CAST('2018-06-02' AS DATE), 54),
('Penelope', 'Dog', 'virginia.baker@gmail.com', CAST('2018-10-22' AS DATE), 54),
('Penny', 'Cat', 'roy.rogers@hotmail.com', CAST('2017-04-08' AS DATE), 66),
('Piper', 'Dog', 'margaret.campbell@hotmail.com', CAST('2016-06-16' AS DATE), 61),
('Poppy', 'Dog', 'phyllis.moore@gmail.com', CAST('2019-03-15' AS DATE), 93),
('Prince', 'Dog', 'virginia.baker@gmail.com', CAST('2018-03-13' AS DATE), 95),
('Pumpkin', 'Cat', 'scott.gutierrez@gmail.com', CAST('2019-09-12' AS DATE), 64),
('Ranger', 'Dog', 'charles.phillips@gmail.com', CAST('2019-01-06' AS DATE), 61),
('Remi / Remy', 'Dog', 'jesse.cox@yahoo.com', CAST('2019-04-29' AS DATE), 61),
('Riley', 'Dog', 'sara.nelson@icloud.com', CAST('2019-09-30' AS DATE), 54),
('Rocky', 'Cat', 'patricia.wright@icloud.com', CAST('2019-11-21' AS DATE), 60),
('Roxy', 'Dog', 'julie.adams@gmail.com', CAST('2019-08-07' AS DATE), 86),
('Rusty', 'Dog', 'jacqueline.phillips@gmail.com', CAST('2016-04-23' AS DATE), 50),
('Sadie', 'Cat', 'jonathan.mez@hotmail.com', CAST('2018-12-07' AS DATE), 85),
('Salem', 'Cat', 'bruce.cook@icloud.com', CAST('2018-02-09' AS DATE), 55),
('Sam', 'Cat', 'frances.cook@yahoo.com', CAST('2018-12-29' AS DATE), 51),
('Shadow', 'Dog', 'wayne.turner@icloud.com', CAST('2018-04-01' AS DATE), 73),
('Skye', 'Dog', 'jerry.mitchell@icloud.com', CAST('2016-09-25' AS DATE), 67),
('Thomas', 'Cat', 'george.scott@hotmail.com', CAST('2019-05-23' AS DATE), 96),
('Toby', 'Rabbit', 'phyllis.moore@gmail.com', CAST('2019-11-26' AS DATE), 96),
('Whitney', 'Rabbit', 'margaret.campbell@hotmail.com', CAST('2019-07-17' AS DATE), 75);

CREATE TABLE Vaccinations
(
	Name				VARCHAR(20)		NOT NULL,
	Species				VARCHAR(10)		NOT NULL,
	Vaccination_Time	DATETIME2(7)	NOT NULL,
	Vaccine				VARCHAR(50)		NOT NULL,
	Batch				VARCHAR(20)		NOT NULL,
	Comments			VARCHAR(500)	NULL,
	Email				VARCHAR(100)	NOT NULL
		REFERENCES Staff (Email) ON UPDATE CASCADE,
	PRIMARY KEY (Name, Species, Vaccine, Vaccination_Time),
	FOREIGN KEY (Name, Species)
		REFERENCES Animals (Name, Species)
);
INSERT INTO	Vaccinations (Name, Species, Vaccination_Time, Vaccine, Batch, Comments, Email)
VALUES
('Abby', 'Dog', CAST('2017-04-19T09:01:00.0000000' AS DATETIME2), 'Distemper Virus', 'N-178784096', NULL, 'ashley.flores@animalshelter.com'),
('Abby', 'Dog', CAST('2018-04-19T10:44:00.0000000' AS DATETIME2), 'Distemper Virus', 'L-107687717', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2017-05-04T10:38:00.0000000' AS DATETIME2), 'Distemper Virus', 'L-353180534', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2018-05-04T09:47:00.0000000' AS DATETIME2), 'Distemper Virus', 'A-271237673', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2017-05-04T12:49:00.0000000' AS DATETIME2), 'Rabies', 'V-180603107', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2018-05-04T11:18:00.0000000' AS DATETIME2), 'Rabies', 'P-118670651', NULL, 'ashley.flores@animalshelter.com'),
('Archie', 'Cat', CAST('2017-11-20T09:35:00.0000000' AS DATETIME2), 'Calicivirus', 'J-460970834', NULL, 'ashley.flores@animalshelter.com'),
('Archie', 'Cat', CAST('2017-11-20T13:25:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'F-164759480', NULL, 'ashley.flores@animalshelter.com'),
('Aspen', 'Dog', CAST('2016-09-28T07:36:00.0000000' AS DATETIME2), 'Adenovirus', 'M-471677500', NULL, 'wanda.myers@animalshelter.com'),
('Aspen', 'Dog', CAST('2017-09-29T12:35:00.0000000' AS DATETIME2), 'Adenovirus', 'V-256362103', NULL, 'wanda.myers@animalshelter.com'),
('Aspen', 'Dog', CAST('2016-09-28T10:01:00.0000000' AS DATETIME2), 'Distemper Virus', 'N-147820695', NULL, 'ashley.flores@animalshelter.com'),
('Aspen', 'Dog', CAST('2016-09-28T07:41:00.0000000' AS DATETIME2), 'Rabies', 'K-430117096', NULL, 'wanda.myers@animalshelter.com'),
('Aspen', 'Dog', CAST('2017-09-29T07:32:00.0000000' AS DATETIME2), 'Rabies', 'B-384980558', NULL, 'ashley.flores@animalshelter.com'),
('Baloo', 'Rabbit', CAST('2016-09-01T07:00:00.0000000' AS DATETIME2), 'Rabies', 'V-411899194', NULL, 'wanda.myers@animalshelter.com'),
('Benny', 'Dog', CAST('2019-01-02T09:44:00.0000000' AS DATETIME2), 'Adenovirus', 'D-237655965', NULL, 'ashley.flores@animalshelter.com'),
('Benny', 'Dog', CAST('2019-01-02T13:19:00.0000000' AS DATETIME2), 'Rabies', 'H-405534627', NULL, 'robin.murphy@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2018-12-27T13:39:00.0000000' AS DATETIME2), 'Myxomatosis', 'I-176340730', NULL, 'dennis.hill@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2019-12-27T13:32:00.0000000' AS DATETIME2), 'Myxomatosis', 'O-237649828', NULL, 'ashley.flores@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2016-12-26T12:08:00.0000000' AS DATETIME2), 'Rabies', 'N-100666243', NULL, 'wanda.myers@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2017-12-27T10:09:00.0000000' AS DATETIME2), 'Rabies', 'Z-365201947', NULL, 'wanda.myers@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2018-12-27T11:09:00.0000000' AS DATETIME2), 'Rabies', 'O-282699517', NULL, 'robin.murphy@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2019-12-27T09:23:00.0000000' AS DATETIME2), 'Rabies', 'C-219506249', NULL, 'gerald.reyes@animalshelter.com'),
('Boomer', 'Dog', CAST('2019-09-03T11:58:00.0000000' AS DATETIME2), 'Rabies', 'D-353567999', NULL, 'gerald.reyes@animalshelter.com'),
('Brutus', 'Dog', CAST('2018-11-28T12:26:00.0000000' AS DATETIME2), 'Adenovirus', 'K-99075733 ', NULL, 'wanda.myers@animalshelter.com'),
('Brutus', 'Dog', CAST('2018-11-28T07:17:00.0000000' AS DATETIME2), 'Distemper Virus', 'U-104436672', NULL, 'wayne.carter@animalshelter.com'),
('Cooper', 'Dog', CAST('2017-10-13T09:41:00.0000000' AS DATETIME2), 'Distemper Virus', 'K-334308175', NULL, 'ashley.flores@animalshelter.com'),
('Dolly', 'Dog', CAST('2018-09-27T08:16:00.0000000' AS DATETIME2), 'Adenovirus', 'F-202325284', NULL, 'ashley.flores@animalshelter.com'),
('Dolly', 'Dog', CAST('2019-09-27T10:29:00.0000000' AS DATETIME2), 'Adenovirus', 'O-402995062', NULL, 'wayne.carter@animalshelter.com'),
('Dolly', 'Dog', CAST('2018-09-27T14:45:00.0000000' AS DATETIME2), 'Rabies', 'T-302536393', NULL, 'robin.murphy@animalshelter.com'),
('Fiona', 'Cat', CAST('2017-12-18T11:15:00.0000000' AS DATETIME2), 'Calicivirus', 'C-259489422', NULL, 'wanda.myers@animalshelter.com'),
('Fiona', 'Cat', CAST('2017-12-18T14:17:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'Y-412311976', NULL, 'wanda.myers@animalshelter.com'),
('Ginger', 'Dog', CAST('2017-03-07T08:33:00.0000000' AS DATETIME2), 'Adenovirus', 'B-141623834', NULL, 'wanda.myers@animalshelter.com'),
('Gizmo', 'Dog', CAST('2019-08-22T08:52:00.0000000' AS DATETIME2), 'Distemper Virus', 'H-384444123', NULL, 'wayne.carter@animalshelter.com'),
('Hobbes', 'Cat', CAST('2016-12-26T12:54:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'X-224232315', NULL, 'ashley.flores@animalshelter.com'),
('Holly', 'Dog', CAST('2019-07-15T13:14:00.0000000' AS DATETIME2), 'Rabies', 'D-117727724', NULL, 'robin.murphy@animalshelter.com'),
('Humphrey', 'Rabbit', CAST('2018-08-28T08:09:00.0000000' AS DATETIME2), 'Myxomatosis', 'H-250858054', NULL, 'gerald.reyes@animalshelter.com'),
('Humphrey', 'Rabbit', CAST('2018-08-28T09:41:00.0000000' AS DATETIME2), 'Rabies', 'U-255625602', NULL, 'robin.murphy@animalshelter.com'),
('Humphrey', 'Rabbit', CAST('2018-08-28T10:08:00.0000000' AS DATETIME2), 'Viral Haemorrhagic Disease', 'I-404631209', NULL, 'gerald.reyes@animalshelter.com'),
('Jake', 'Dog', CAST('2017-12-08T07:46:00.0000000' AS DATETIME2), 'Adenovirus', 'T-332043529', NULL, 'wanda.myers@animalshelter.com'),
('Lucy', 'Dog', CAST('2018-05-22T07:46:00.0000000' AS DATETIME2), 'Distemper Virus', 'L-258258441', NULL, 'ashley.flores@animalshelter.com'),
('Luna', 'Dog', CAST('2019-09-03T13:30:00.0000000' AS DATETIME2), 'Adenovirus', 'O-245391721', NULL, 'wayne.carter@animalshelter.com'),
('Misty', 'Cat', CAST('2019-08-09T09:13:00.0000000' AS DATETIME2), 'Calicivirus', 'I-259629161', NULL, 'dennis.hill@animalshelter.com'),
('Misty', 'Cat', CAST('2019-08-09T09:00:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'Y-383139393', NULL, 'gerald.reyes@animalshelter.com'),
('Nala', 'Dog', CAST('2019-07-26T13:15:00.0000000' AS DATETIME2), 'Adenovirus', 'S-115426515', NULL, 'ashley.flores@animalshelter.com'),
('Nova', 'Cat', CAST('2018-08-13T14:32:00.0000000' AS DATETIME2), 'Leukemia Virus', 'E-489987614', NULL, 'ashley.flores@animalshelter.com'),
('Nova', 'Cat', CAST('2018-08-13T11:35:00.0000000' AS DATETIME2), 'Rabies', 'C-386537135', NULL, 'ashley.flores@animalshelter.com'),
('Odin', 'Dog', CAST('2019-10-25T14:02:00.0000000' AS DATETIME2), 'Adenovirus', 'Z-490194302', NULL, 'robin.murphy@animalshelter.com'),
('Odin', 'Dog', CAST('2017-10-25T07:58:00.0000000' AS DATETIME2), 'Rabies', 'N-322162073', NULL, 'ashley.flores@animalshelter.com'),
('Odin', 'Dog', CAST('2019-10-25T09:11:00.0000000' AS DATETIME2), 'Rabies', 'L-181928453', NULL, 'wayne.carter@animalshelter.com'),
('Oscar', 'Cat', CAST('2018-03-22T07:15:00.0000000' AS DATETIME2), 'Herpesvirus', 'L-196623340', NULL, 'wanda.myers@animalshelter.com'),
('Oscar', 'Cat', CAST('2018-03-22T07:12:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'S-427830689', NULL, 'ashley.flores@animalshelter.com'),
('Oscar', 'Cat', CAST('2018-03-22T13:19:00.0000000' AS DATETIME2), 'Rabies', 'K-153175906', NULL, 'ashley.flores@animalshelter.com'),
('Patches', 'Cat', CAST('2019-10-21T09:56:00.0000000' AS DATETIME2), 'Leukemia Virus', 'H-151581256', NULL, 'wanda.myers@animalshelter.com'),
('Penelope', 'Cat', CAST('2017-12-22T08:29:00.0000000' AS DATETIME2), 'Calicivirus', 'H-233459270', NULL, 'wanda.myers@animalshelter.com'),
('Penelope', 'Cat', CAST('2017-12-22T09:42:00.0000000' AS DATETIME2), 'Rabies', 'T-245247914', NULL, 'wanda.myers@animalshelter.com'),
('Penelope', 'Dog', CAST('2017-01-12T12:42:00.0000000' AS DATETIME2), 'Distemper Virus', 'M-466473114', NULL, 'ashley.flores@animalshelter.com'),
('Penelope', 'Dog', CAST('2017-01-12T14:39:00.0000000' AS DATETIME2), 'Rabies', 'R-249697441', NULL, 'ashley.flores@animalshelter.com'),
('Penelope', 'Dog', CAST('2018-01-12T08:20:00.0000000' AS DATETIME2), 'Rabies', 'G-252982705', NULL, 'ashley.flores@animalshelter.com'),
('Poppy', 'Dog', CAST('2018-12-17T09:34:00.0000000' AS DATETIME2), 'Rabies', 'W-142526378', NULL, 'robin.murphy@animalshelter.com'),
('Pumpkin', 'Cat', CAST('2019-08-07T11:03:00.0000000' AS DATETIME2), 'Herpesvirus', 'R-266824458', NULL, 'gerald.reyes@animalshelter.com'),
('Pumpkin', 'Cat', CAST('2019-08-07T09:09:00.0000000' AS DATETIME2), 'Rabies', 'C-414219200', NULL, 'robin.murphy@animalshelter.com'),
('Ranger', 'Dog', CAST('2018-11-28T11:39:00.0000000' AS DATETIME2), 'Adenovirus', 'P-300099414', NULL, 'ashley.flores@animalshelter.com'),
('Ranger', 'Dog', CAST('2017-11-28T11:59:00.0000000' AS DATETIME2), 'Distemper Virus', 'W-358599750', NULL, 'ashley.flores@animalshelter.com'),
('Ranger', 'Dog', CAST('2018-11-28T07:27:00.0000000' AS DATETIME2), 'Distemper Virus', 'K-483728872', NULL, 'wanda.myers@animalshelter.com'),
('Remi / Remy', 'Dog', CAST('2018-11-14T11:49:00.0000000' AS DATETIME2), 'Distemper Virus', 'S-337547458', NULL, 'gerald.reyes@animalshelter.com'),
('Roxy', 'Dog', CAST('2019-01-04T07:55:00.0000000' AS DATETIME2), 'Adenovirus', 'Q-206330713', NULL, 'ashley.flores@animalshelter.com'),
('Roxy', 'Dog', CAST('2019-01-04T12:58:00.0000000' AS DATETIME2), 'Distemper Virus', 'P-281685593', NULL, 'dennis.hill@animalshelter.com'),
('Sadie', 'Cat', CAST('2016-10-06T07:02:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'C-229285711', NULL, 'ashley.flores@animalshelter.com'),
('Sam', 'Cat', CAST('2018-11-09T13:46:00.0000000' AS DATETIME2), 'Herpesvirus', 'W-462716953', NULL, 'wanda.myers@animalshelter.com'),
('Sammy', 'Dog', CAST('2018-07-06T12:29:00.0000000' AS DATETIME2), 'Adenovirus', 'Q-336566517', NULL, 'wanda.myers@animalshelter.com'),
('Sammy', 'Dog', CAST('2018-07-06T10:58:00.0000000' AS DATETIME2), 'Distemper Virus', 'H-245193858', NULL, 'ashley.flores@animalshelter.com'),
('Samson', 'Dog', CAST('2019-11-15T10:11:00.0000000' AS DATETIME2), 'Distemper Virus', 'R-497123324', NULL, 'gerald.reyes@animalshelter.com'),
('Shadow', 'Dog', CAST('2016-12-29T08:43:00.0000000' AS DATETIME2), 'Distemper Virus', 'T-135880561', NULL, 'wanda.myers@animalshelter.com'),
('Shelby', 'Dog', CAST('2016-04-18T14:04:00.0000000' AS DATETIME2), 'Adenovirus', 'L-438221809', NULL, 'ashley.flores@animalshelter.com'),
('Shelby', 'Dog', CAST('2017-04-19T13:33:00.0000000' AS DATETIME2), 'Adenovirus', 'U-447076076', NULL, 'wanda.myers@animalshelter.com'),
('Simon', 'Cat', CAST('2018-05-30T14:15:00.0000000' AS DATETIME2), 'Calicivirus', 'Q-478638360', NULL, 'gerald.reyes@animalshelter.com'),
('Skye', 'Dog', CAST('2016-08-10T10:51:00.0000000' AS DATETIME2), 'Distemper Virus', 'E-236843325', NULL, 'ashley.flores@animalshelter.com'),
('Skye', 'Dog', CAST('2016-08-10T09:53:00.0000000' AS DATETIME2), 'Rabies', 'A-171447806', NULL, 'wanda.myers@animalshelter.com'),
('Stella', 'Dog', CAST('2018-01-03T08:20:00.0000000' AS DATETIME2), 'Adenovirus', 'K-380962117', NULL, 'ashley.flores@animalshelter.com'),
('Thomas', 'Cat', CAST('2019-05-09T07:25:00.0000000' AS DATETIME2), 'Leukemia Virus', 'N-431089273', NULL, 'wayne.carter@animalshelter.com'),
('Thomas', 'Cat', CAST('2019-05-09T12:27:00.0000000' AS DATETIME2), 'Rabies', 'Z-112256475', NULL, 'wanda.myers@animalshelter.com'),
('Thor', 'Dog', CAST('2017-03-22T11:45:00.0000000' AS DATETIME2), 'Adenovirus', 'U-127749818', NULL, 'ashley.flores@animalshelter.com'),
('Thor', 'Dog', CAST('2019-03-22T14:24:00.0000000' AS DATETIME2), 'Adenovirus', 'M-229481627', NULL, 'wanda.myers@animalshelter.com'),
('Thor', 'Dog', CAST('2017-03-22T09:58:00.0000000' AS DATETIME2), 'Distemper Virus', 'I-370298118', NULL, 'ashley.flores@animalshelter.com'),
('Thor', 'Dog', CAST('2019-03-22T07:15:00.0000000' AS DATETIME2), 'Distemper Virus', 'A-455989697', NULL, 'dennis.hill@animalshelter.com'),
('Tigger', 'Cat', CAST('2018-01-04T13:28:00.0000000' AS DATETIME2), 'Leukemia Virus', 'F-321237388', NULL, 'ashley.flores@animalshelter.com'),
('Tigger', 'Cat', CAST('2019-01-04T11:15:00.0000000' AS DATETIME2), 'Leukemia Virus', 'P-236394443', NULL, 'gerald.reyes@animalshelter.com'),
('Tigger', 'Cat', CAST('2017-01-04T14:52:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'R-191602716', NULL, 'wanda.myers@animalshelter.com'),
('Tigger', 'Cat', CAST('2019-01-04T08:49:00.0000000' AS DATETIME2), 'Panleukopenia Virus', 'T-370701265', NULL, 'dennis.hill@animalshelter.com'),
('Tigger', 'Cat', CAST('2018-01-04T10:27:00.0000000' AS DATETIME2), 'Rabies', 'L-382821941', NULL, 'ashley.flores@animalshelter.com'),
('Tigger', 'Cat', CAST('2019-01-04T09:08:00.0000000' AS DATETIME2), 'Rabies', 'V-177428557', NULL, 'robin.murphy@animalshelter.com'),
('Walter', 'Dog', CAST('2018-08-27T11:10:00.0000000' AS DATETIME2), 'Distemper Virus', 'B-226925017', NULL, 'ashley.flores@animalshelter.com'),
('Walter', 'Dog', CAST('2019-08-27T12:32:00.0000000' AS DATETIME2), 'Distemper Virus', 'X-480746334', NULL, 'wayne.carter@animalshelter.com'),
('Walter', 'Dog', CAST('2018-08-27T14:21:00.0000000' AS DATETIME2), 'Rabies', 'O-242396268', NULL, 'robin.murphy@animalshelter.com'),
('Walter', 'Dog', CAST('2019-08-27T09:03:00.0000000' AS DATETIME2), 'Rabies', 'L-366676246', NULL, 'robin.murphy@animalshelter.com');

COMMIT TRANSACTION;
