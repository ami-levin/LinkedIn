-------------------------------------
-- LinkedIn Learning ----------------
-- Advanced SQL - Window Functions --
-- Ami Levin 2020 -------------------
-- .\DemoDB\PostgreSQL.sql-----------
-------------------------------------

-- CREATE DATABASE animal_shelter;

-- Connect to animal_shelter database
-- \connect animal_shelter

CREATE SCHEMA reference;

-- reference colors
CREATE	TABLE reference.colors 
(
	color VARCHAR (10) NOT NULL PRIMARY KEY
);
INSERT INTO	reference.colors (color)
VALUES
('Black'), ('Brown'), ('Cream'), ('Ginger'), ('Gray'), ('White');

-- reference species
CREATE TABLE reference.species 
(
	species VARCHAR (10) NOT NULL PRIMARY KEY
);
INSERT INTO	reference.species (species)
VALUES
('Cat'), ('Dog'), ('Ferret'), ('Rabbit'), ('Raccoon');

CREATE	TABLE animals
(
	species			VARCHAR (10)		NOT NULL
		REFERENCES reference.species (species) 
		ON UPDATE CASCADE,
	name			VARCHAR (20)		NOT NULL,
	primary_color	VARCHAR (10)		NOT NULL
		REFERENCES reference.colors (color) 
		ON UPDATE CASCADE,
	implant_chip_id	VARCHAR (50)		NOT NULL
		UNIQUE,
	breed			VARCHAR (50)		NULL,
	gender			CHAR (1)			NOT NULL
		CHECK (gender IN ('F', 'M')),
	birth_date		DATE				NOT NULL,
	pattern			VARCHAR (20)		NOT NULL,
	admission_date	DATE				NOT NULL,
	PRIMARY KEY (species, name)
);
INSERT INTO	animals (name, species, primary_color, implant_chip_id, breed, gender, birth_date, pattern, admission_date)
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

CREATE	TABLE persons
(
	email		VARCHAR (100)	NOT NULL PRIMARY KEY,
	first_name	VARCHAR (15)	NOT NULL,
	last_name	VARCHAR (15)	NOT NULL,
	birth_date	DATE			NULL,
	address		VARCHAR (100)	NOT NULL,
	state		VARCHAR (20)	NOT NULL,
	city		VARCHAR (30)	NOT NULL,
	zip_code	CHAR (5)		NOT NULL
);
INSERT INTO	persons (email, first_name, last_name, birth_date, address, state, city, zip_code)
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
('laura.young@gmail.com', 'Laura', 'Young', CAST('1987-05-19' AS DATE), '29 first', 'California', 'Torrance', '90503'),
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
('richard.castillo@icloud.com', 'Richard', 'Castillo', CAST('1978-12-26' AS DATE), '287 River', 'California', 'Culver city', '90233'),
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

CREATE	TABLE staff
(
	email		VARCHAR (100)	NOT NULL PRIMARY KEY
		REFERENCES persons(email) 
		ON UPDATE CASCADE, 
	hire_date 	DATE			NOT NULL
);
INSERT INTO	staff (email, hire_date)
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

CREATE	TABLE staff_roles 
(
	role VARCHAR (20) NOT NULL PRIMARY KEY 
);
INSERT INTO	staff_roles (role)
VALUES
('Assistant'),
('Janitor'),
('Manager'),
('Receptionist'),
('Veterinarian');

CREATE TABLE staff_assignments
(
	role		VARCHAR (20)	NOT NULL
		REFERENCES staff_roles (role) 
		ON UPDATE CASCADE,
	email		VARCHAR (100)	NOT NULL
		REFERENCES staff (email) 
		ON UPDATE CASCADE,
	assigned	DATE			NOT NULL,
	PRIMARY KEY (role, email)
);
INSERT INTO	staff_assignments (email, role, assigned)
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

CREATE	TABLE adoptions
(
	species			VARCHAR (10)	NOT NULL,
	name			VARCHAR (20)	NOT NULL,
	adopter_email	VARCHAR (100)	NOT NULL
		REFERENCES persons (email) 
		ON UPDATE CASCADE,
	adoption_date	DATE			NOT NULL,
	adoption_fee	SMALLINT		NOT NULL
		CHECK (adoption_fee >= (0)),
	PRIMARY KEY (species, name, adopter_email),
	FOREIGN KEY (species, name)
		REFERENCES animals (species, name) 
		ON UPDATE CASCADE
);
INSERT INTO	adoptions (name, species, adopter_email, adoption_date, adoption_fee)
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

CREATE TABLE vaccinations
(
	name				VARCHAR (20)	NOT NULL,
	species				VARCHAR (10)	NOT NULL,
	vaccination_time	TIMESTAMP		NOT NULL,
	vaccine				VARCHAR (50)	NOT NULL,
	batch				VARCHAR (20)	NOT NULL,
	comments			VARCHAR (500)	NULL,
	email				VARCHAR (100)	NOT NULL
		REFERENCES staff (email) 
		ON UPDATE CASCADE,
	PRIMARY KEY (species, name, vaccine, vaccination_time),
	FOREIGN KEY (species, name)
		REFERENCES animals (species, name) 
		ON UPDATE CASCADE
);
INSERT INTO	vaccinations (name, species, vaccination_time, vaccine, batch, comments, email)
VALUES
('Abby', 'Dog', CAST('2017-04-19T09:01:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'N-178784096', NULL, 'ashley.flores@animalshelter.com'),
('Abby', 'Dog', CAST('2018-04-19T10:44:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'L-107687717', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2017-05-04T10:38:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'L-353180534', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2018-05-04T09:47:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'A-271237673', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2017-05-04T12:49:00.0000000' AS TIMESTAMP), 'Rabies', 'V-180603107', NULL, 'wanda.myers@animalshelter.com'),
('Angel', 'Dog', CAST('2018-05-04T11:18:00.0000000' AS TIMESTAMP), 'Rabies', 'P-118670651', NULL, 'ashley.flores@animalshelter.com'),
('Archie', 'Cat', CAST('2017-11-20T09:35:00.0000000' AS TIMESTAMP), 'Calicivirus', 'J-460970834', NULL, 'ashley.flores@animalshelter.com'),
('Archie', 'Cat', CAST('2017-11-20T13:25:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'F-164759480', NULL, 'ashley.flores@animalshelter.com'),
('Aspen', 'Dog', CAST('2016-09-28T07:36:00.0000000' AS TIMESTAMP), 'Adenovirus', 'M-471677500', NULL, 'wanda.myers@animalshelter.com'),
('Aspen', 'Dog', CAST('2017-09-29T12:35:00.0000000' AS TIMESTAMP), 'Adenovirus', 'V-256362103', NULL, 'wanda.myers@animalshelter.com'),
('Aspen', 'Dog', CAST('2016-09-28T10:01:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'N-147820695', NULL, 'ashley.flores@animalshelter.com'),
('Aspen', 'Dog', CAST('2016-09-28T07:41:00.0000000' AS TIMESTAMP), 'Rabies', 'K-430117096', NULL, 'wanda.myers@animalshelter.com'),
('Aspen', 'Dog', CAST('2017-09-29T07:32:00.0000000' AS TIMESTAMP), 'Rabies', 'B-384980558', NULL, 'ashley.flores@animalshelter.com'),
('Baloo', 'Rabbit', CAST('2016-09-01T07:00:00.0000000' AS TIMESTAMP), 'Rabies', 'V-411899194', NULL, 'wanda.myers@animalshelter.com'),
('Benny', 'Dog', CAST('2019-01-02T09:44:00.0000000' AS TIMESTAMP), 'Adenovirus', 'D-237655965', NULL, 'ashley.flores@animalshelter.com'),
('Benny', 'Dog', CAST('2019-01-02T13:19:00.0000000' AS TIMESTAMP), 'Rabies', 'H-405534627', NULL, 'robin.murphy@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2018-12-27T13:39:00.0000000' AS TIMESTAMP), 'Myxomatosis', 'I-176340730', NULL, 'dennis.hill@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2019-12-27T13:32:00.0000000' AS TIMESTAMP), 'Myxomatosis', 'O-237649828', NULL, 'ashley.flores@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2016-12-26T12:08:00.0000000' AS TIMESTAMP), 'Rabies', 'N-100666243', NULL, 'wanda.myers@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2017-12-27T10:09:00.0000000' AS TIMESTAMP), 'Rabies', 'Z-365201947', NULL, 'wanda.myers@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2018-12-27T11:09:00.0000000' AS TIMESTAMP), 'Rabies', 'O-282699517', NULL, 'robin.murphy@animalshelter.com'),
('Bon bon', 'Rabbit', CAST('2019-12-27T09:23:00.0000000' AS TIMESTAMP), 'Rabies', 'C-219506249', NULL, 'gerald.reyes@animalshelter.com'),
('Boomer', 'Dog', CAST('2019-09-03T11:58:00.0000000' AS TIMESTAMP), 'Rabies', 'D-353567999', NULL, 'gerald.reyes@animalshelter.com'),
('Brutus', 'Dog', CAST('2018-11-28T12:26:00.0000000' AS TIMESTAMP), 'Adenovirus', 'K-99075733 ', NULL, 'wanda.myers@animalshelter.com'),
('Brutus', 'Dog', CAST('2018-11-28T07:17:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'U-104436672', NULL, 'wayne.carter@animalshelter.com'),
('Cooper', 'Dog', CAST('2017-10-13T09:41:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'K-334308175', NULL, 'ashley.flores@animalshelter.com'),
('Dolly', 'Dog', CAST('2018-09-27T08:16:00.0000000' AS TIMESTAMP), 'Adenovirus', 'F-202325284', NULL, 'ashley.flores@animalshelter.com'),
('Dolly', 'Dog', CAST('2019-09-27T10:29:00.0000000' AS TIMESTAMP), 'Adenovirus', 'O-402995062', NULL, 'wayne.carter@animalshelter.com'),
('Dolly', 'Dog', CAST('2018-09-27T14:45:00.0000000' AS TIMESTAMP), 'Rabies', 'T-302536393', NULL, 'robin.murphy@animalshelter.com'),
('Fiona', 'Cat', CAST('2017-12-18T11:15:00.0000000' AS TIMESTAMP), 'Calicivirus', 'C-259489422', NULL, 'wanda.myers@animalshelter.com'),
('Fiona', 'Cat', CAST('2017-12-18T14:17:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'Y-412311976', NULL, 'wanda.myers@animalshelter.com'),
('Ginger', 'Dog', CAST('2017-03-07T08:33:00.0000000' AS TIMESTAMP), 'Adenovirus', 'B-141623834', NULL, 'wanda.myers@animalshelter.com'),
('Gizmo', 'Dog', CAST('2019-08-22T08:52:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'H-384444123', NULL, 'wayne.carter@animalshelter.com'),
('Hobbes', 'Cat', CAST('2016-12-26T12:54:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'X-224232315', NULL, 'ashley.flores@animalshelter.com'),
('Holly', 'Dog', CAST('2019-07-15T13:14:00.0000000' AS TIMESTAMP), 'Rabies', 'D-117727724', NULL, 'robin.murphy@animalshelter.com'),
('Humphrey', 'Rabbit', CAST('2018-08-28T08:09:00.0000000' AS TIMESTAMP), 'Myxomatosis', 'H-250858054', NULL, 'gerald.reyes@animalshelter.com'),
('Humphrey', 'Rabbit', CAST('2018-08-28T09:41:00.0000000' AS TIMESTAMP), 'Rabies', 'U-255625602', NULL, 'robin.murphy@animalshelter.com'),
('Humphrey', 'Rabbit', CAST('2018-08-28T10:08:00.0000000' AS TIMESTAMP), 'Viral Haemorrhagic Disease', 'I-404631209', NULL, 'gerald.reyes@animalshelter.com'),
('Jake', 'Dog', CAST('2017-12-08T07:46:00.0000000' AS TIMESTAMP), 'Adenovirus', 'T-332043529', NULL, 'wanda.myers@animalshelter.com'),
('Lucy', 'Dog', CAST('2018-05-22T07:46:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'L-258258441', NULL, 'ashley.flores@animalshelter.com'),
('Luna', 'Dog', CAST('2019-09-03T13:30:00.0000000' AS TIMESTAMP), 'Adenovirus', 'O-245391721', NULL, 'wayne.carter@animalshelter.com'),
('Misty', 'Cat', CAST('2019-08-09T09:13:00.0000000' AS TIMESTAMP), 'Calicivirus', 'I-259629161', NULL, 'dennis.hill@animalshelter.com'),
('Misty', 'Cat', CAST('2019-08-09T09:00:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'Y-383139393', NULL, 'gerald.reyes@animalshelter.com'),
('Nala', 'Dog', CAST('2019-07-26T13:15:00.0000000' AS TIMESTAMP), 'Adenovirus', 'S-115426515', NULL, 'ashley.flores@animalshelter.com'),
('Nova', 'Cat', CAST('2018-08-13T14:32:00.0000000' AS TIMESTAMP), 'Leukemia Virus', 'E-489987614', NULL, 'ashley.flores@animalshelter.com'),
('Nova', 'Cat', CAST('2018-08-13T11:35:00.0000000' AS TIMESTAMP), 'Rabies', 'C-386537135', NULL, 'ashley.flores@animalshelter.com'),
('Odin', 'Dog', CAST('2019-10-25T14:02:00.0000000' AS TIMESTAMP), 'Adenovirus', 'Z-490194302', NULL, 'robin.murphy@animalshelter.com'),
('Odin', 'Dog', CAST('2017-10-25T07:58:00.0000000' AS TIMESTAMP), 'Rabies', 'N-322162073', NULL, 'ashley.flores@animalshelter.com'),
('Odin', 'Dog', CAST('2019-10-25T09:11:00.0000000' AS TIMESTAMP), 'Rabies', 'L-181928453', NULL, 'wayne.carter@animalshelter.com'),
('Oscar', 'Cat', CAST('2018-03-22T07:15:00.0000000' AS TIMESTAMP), 'Herpesvirus', 'L-196623340', NULL, 'wanda.myers@animalshelter.com'),
('Oscar', 'Cat', CAST('2018-03-22T07:12:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'S-427830689', NULL, 'ashley.flores@animalshelter.com'),
('Oscar', 'Cat', CAST('2018-03-22T13:19:00.0000000' AS TIMESTAMP), 'Rabies', 'K-153175906', NULL, 'ashley.flores@animalshelter.com'),
('Patches', 'Cat', CAST('2019-10-21T09:56:00.0000000' AS TIMESTAMP), 'Leukemia Virus', 'H-151581256', NULL, 'wanda.myers@animalshelter.com'),
('Penelope', 'Cat', CAST('2017-12-22T08:29:00.0000000' AS TIMESTAMP), 'Calicivirus', 'H-233459270', NULL, 'wanda.myers@animalshelter.com'),
('Penelope', 'Cat', CAST('2017-12-22T09:42:00.0000000' AS TIMESTAMP), 'Rabies', 'T-245247914', NULL, 'wanda.myers@animalshelter.com'),
('Penelope', 'Dog', CAST('2017-01-12T12:42:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'M-466473114', NULL, 'ashley.flores@animalshelter.com'),
('Penelope', 'Dog', CAST('2017-01-12T14:39:00.0000000' AS TIMESTAMP), 'Rabies', 'R-249697441', NULL, 'ashley.flores@animalshelter.com'),
('Penelope', 'Dog', CAST('2018-01-12T08:20:00.0000000' AS TIMESTAMP), 'Rabies', 'G-252982705', NULL, 'ashley.flores@animalshelter.com'),
('Poppy', 'Dog', CAST('2018-12-17T09:34:00.0000000' AS TIMESTAMP), 'Rabies', 'W-142526378', NULL, 'robin.murphy@animalshelter.com'),
('Pumpkin', 'Cat', CAST('2019-08-07T11:03:00.0000000' AS TIMESTAMP), 'Herpesvirus', 'R-266824458', NULL, 'gerald.reyes@animalshelter.com'),
('Pumpkin', 'Cat', CAST('2019-08-07T09:09:00.0000000' AS TIMESTAMP), 'Rabies', 'C-414219200', NULL, 'robin.murphy@animalshelter.com'),
('Ranger', 'Dog', CAST('2018-11-28T11:39:00.0000000' AS TIMESTAMP), 'Adenovirus', 'P-300099414', NULL, 'ashley.flores@animalshelter.com'),
('Ranger', 'Dog', CAST('2017-11-28T11:59:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'W-358599750', NULL, 'ashley.flores@animalshelter.com'),
('Ranger', 'Dog', CAST('2018-11-28T07:27:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'K-483728872', NULL, 'wanda.myers@animalshelter.com'),
('Remi / Remy', 'Dog', CAST('2018-11-14T11:49:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'S-337547458', NULL, 'gerald.reyes@animalshelter.com'),
('Roxy', 'Dog', CAST('2019-01-04T07:55:00.0000000' AS TIMESTAMP), 'Adenovirus', 'Q-206330713', NULL, 'ashley.flores@animalshelter.com'),
('Roxy', 'Dog', CAST('2019-01-04T12:58:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'P-281685593', NULL, 'dennis.hill@animalshelter.com'),
('Sadie', 'Cat', CAST('2016-10-06T07:02:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'C-229285711', NULL, 'ashley.flores@animalshelter.com'),
('Sam', 'Cat', CAST('2018-11-09T13:46:00.0000000' AS TIMESTAMP), 'Herpesvirus', 'W-462716953', NULL, 'wanda.myers@animalshelter.com'),
('Sammy', 'Dog', CAST('2018-07-06T12:29:00.0000000' AS TIMESTAMP), 'Adenovirus', 'Q-336566517', NULL, 'wanda.myers@animalshelter.com'),
('Sammy', 'Dog', CAST('2018-07-06T10:58:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'H-245193858', NULL, 'ashley.flores@animalshelter.com'),
('Samson', 'Dog', CAST('2019-11-15T10:11:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'R-497123324', NULL, 'gerald.reyes@animalshelter.com'),
('Shadow', 'Dog', CAST('2016-12-29T08:43:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'T-135880561', NULL, 'wanda.myers@animalshelter.com'),
('Shelby', 'Dog', CAST('2016-04-18T14:04:00.0000000' AS TIMESTAMP), 'Adenovirus', 'L-438221809', NULL, 'ashley.flores@animalshelter.com'),
('Shelby', 'Dog', CAST('2017-04-19T13:33:00.0000000' AS TIMESTAMP), 'Adenovirus', 'U-447076076', NULL, 'wanda.myers@animalshelter.com'),
('Simon', 'Cat', CAST('2018-05-30T14:15:00.0000000' AS TIMESTAMP), 'Calicivirus', 'Q-478638360', NULL, 'gerald.reyes@animalshelter.com'),
('Skye', 'Dog', CAST('2016-08-10T10:51:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'E-236843325', NULL, 'ashley.flores@animalshelter.com'),
('Skye', 'Dog', CAST('2016-08-10T09:53:00.0000000' AS TIMESTAMP), 'Rabies', 'A-171447806', NULL, 'wanda.myers@animalshelter.com'),
('Stella', 'Dog', CAST('2018-01-03T08:20:00.0000000' AS TIMESTAMP), 'Adenovirus', 'K-380962117', NULL, 'ashley.flores@animalshelter.com'),
('Thomas', 'Cat', CAST('2019-05-09T07:25:00.0000000' AS TIMESTAMP), 'Leukemia Virus', 'N-431089273', NULL, 'wayne.carter@animalshelter.com'),
('Thomas', 'Cat', CAST('2019-05-09T12:27:00.0000000' AS TIMESTAMP), 'Rabies', 'Z-112256475', NULL, 'wanda.myers@animalshelter.com'),
('Thor', 'Dog', CAST('2017-03-22T11:45:00.0000000' AS TIMESTAMP), 'Adenovirus', 'U-127749818', NULL, 'ashley.flores@animalshelter.com'),
('Thor', 'Dog', CAST('2019-03-22T14:24:00.0000000' AS TIMESTAMP), 'Adenovirus', 'M-229481627', NULL, 'wanda.myers@animalshelter.com'),
('Thor', 'Dog', CAST('2017-03-22T09:58:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'I-370298118', NULL, 'ashley.flores@animalshelter.com'),
('Thor', 'Dog', CAST('2019-03-22T07:15:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'A-455989697', NULL, 'dennis.hill@animalshelter.com'),
('Tigger', 'Cat', CAST('2018-01-04T13:28:00.0000000' AS TIMESTAMP), 'Leukemia Virus', 'F-321237388', NULL, 'ashley.flores@animalshelter.com'),
('Tigger', 'Cat', CAST('2019-01-04T11:15:00.0000000' AS TIMESTAMP), 'Leukemia Virus', 'P-236394443', NULL, 'gerald.reyes@animalshelter.com'),
('Tigger', 'Cat', CAST('2017-01-04T14:52:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'R-191602716', NULL, 'wanda.myers@animalshelter.com'),
('Tigger', 'Cat', CAST('2019-01-04T08:49:00.0000000' AS TIMESTAMP), 'Panleukopenia Virus', 'T-370701265', NULL, 'dennis.hill@animalshelter.com'),
('Tigger', 'Cat', CAST('2018-01-04T10:27:00.0000000' AS TIMESTAMP), 'Rabies', 'L-382821941', NULL, 'ashley.flores@animalshelter.com'),
('Tigger', 'Cat', CAST('2019-01-04T09:08:00.0000000' AS TIMESTAMP), 'Rabies', 'V-177428557', NULL, 'robin.murphy@animalshelter.com'),
('Walter', 'Dog', CAST('2018-08-27T11:10:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'B-226925017', NULL, 'ashley.flores@animalshelter.com'),
('Walter', 'Dog', CAST('2019-08-27T12:32:00.0000000' AS TIMESTAMP), 'Distemper Virus', 'X-480746334', NULL, 'wayne.carter@animalshelter.com'),
('Walter', 'Dog', CAST('2018-08-27T14:21:00.0000000' AS TIMESTAMP), 'Rabies', 'O-242396268', NULL, 'robin.murphy@animalshelter.com'),
('Walter', 'Dog', CAST('2019-08-27T09:03:00.0000000' AS TIMESTAMP), 'Rabies', 'L-366676246', NULL, 'robin.murphy@animalshelter.com');

CREATE TABLE routine_checkups
(
	species			VARCHAR (10)	NOT NULL,
	name			VARCHAR (20)	NOT NULL,
	CONSTRAINT 	FK_routine_checkups__animals
		FOREIGN KEY (species, name)
		REFERENCES animals (species, name) 
		ON UPDATE CASCADE,
	checkup_time	TIMESTAMP		NOT NULL,
	temperature		DECIMAL (4, 1)	NOT NULL,
	heart_rate		SMALLINT		NOT NULL,
	respiration		SMALLINT		NOT NULL,
	weight			DECIMAL (4, 1)	NOT NULL,
	comments		VARCHAR (500)	NULL,
	performed_by	VARCHAR (100)	NOT NULL
		REFERENCES staff (email) 
		ON UPDATE CASCADE,	
	PRIMARY KEY (species, name, checkup_time)
);
INSERT INTO routine_checkups (species, name, checkup_time, temperature, heart_rate, respiration, weight, comments, performed_by) 
VALUES 
 ('Cat', 'Archie', 	CAST('2016-10-13T08:43:00' AS TIMESTAMP), 101.8 , 175, 27, 9.3 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Archie', 	CAST('2016-12-13T13:22:00' AS TIMESTAMP), 100.0 , 180, 22, 9.3 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Archie', 	CAST('2018-08-13T14:52:00' AS TIMESTAMP), 101.2 , 199, 27, 9.0 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Buddy', 	CAST('2019-01-09T13:07:00' AS TIMESTAMP), 101.7 , 175, 28, 11.3 , NULL, 'dennis.hill@animalshelter.com')
,('Cat', 'Charlie', CAST('2018-02-20T09:53:00' AS TIMESTAMP), 102.0 , 169, 22, 11.5 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Charlie', CAST('2018-03-20T10:40:00' AS TIMESTAMP), 101.3 , 175, 24, 11.8 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Charlie', CAST('2019-02-20T08:22:00' AS TIMESTAMP), 101.0 , 172, 25, 11.8 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Charlie', CAST('2019-03-20T08:31:00' AS TIMESTAMP), 101.2 , 207, 26, 12.2 , NULL, 'dennis.hill@animalshelter.com')
,('Cat', 'Charlie', CAST('2019-05-20T14:23:00' AS TIMESTAMP), 101.0 , 172, 28, 12.2 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Charlie', CAST('2019-06-20T12:52:00' AS TIMESTAMP), 101.0 , 193, 24, 12.7 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Cleo', 	CAST('2019-09-20T09:45:00' AS TIMESTAMP), 101.9 , 201, 25, 11.6 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Cosmo', 	CAST('2019-06-06T13:26:00' AS TIMESTAMP), 101.4 , 167, 22, 11.4 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Ivy', 	CAST('2018-05-22T11:35:00' AS TIMESTAMP), 101.3 , 193, 22, 14.8 , NULL, 'wayne.carter@animalshelter.com')
,('Cat', 'Ivy', 	CAST('2018-06-22T08:27:00' AS TIMESTAMP), 101.4 , 161, 22, 15.1 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Ivy', 	CAST('2018-10-22T09:03:00' AS TIMESTAMP), 101.9 , 177, 25, 14.7 , NULL, 'wayne.carter@animalshelter.com')
,('Cat', 'Ivy', 	CAST('2019-04-22T15:00:00' AS TIMESTAMP), 100.3 , 193, 23, 14.8 , NULL, 'robin.murphy@animalshelter.com')
,('Cat', 'Ivy', 	CAST('2019-05-22T07:27:00' AS TIMESTAMP), 101.0 , 207, 27, 15.2 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Ivy', 	CAST('2019-07-22T08:43:00' AS TIMESTAMP), 100.3 , 204, 24, 15.4 , NULL, 'wayne.carter@animalshelter.com')
,('Cat', 'Ivy', 	CAST('2019-08-22T09:15:00' AS TIMESTAMP), 100.8 , 156, 26, 15.5 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Kiki', 	CAST('2019-11-20T09:13:00' AS TIMESTAMP), 101.3 , 191, 26, 9.7 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Misty', 	CAST('2019-06-10T12:00:00' AS TIMESTAMP), 100.2 , 159, 26, 10.3 , NULL, 'wayne.carter@animalshelter.com')
,('Cat', 'Misty', 	CAST('2019-07-10T12:07:00' AS TIMESTAMP), 101.4 , 175, 28, 10.3 , NULL, 'dennis.hill@animalshelter.com')
,('Cat', 'Misty', 	CAST('2019-10-10T14:59:00' AS TIMESTAMP), 101.6 , 185, 28, 10.2 , NULL, 'wayne.carter@animalshelter.com')
,('Cat', 'Misty', 	CAST('2019-12-10T13:09:00' AS TIMESTAMP), 101.8 , 177, 25, 10.7 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Nova', 	CAST('2018-01-25T10:50:00' AS TIMESTAMP), 101.9 , 156, 27, 9.0 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Oscar', 	CAST('2018-04-02T14:03:00' AS TIMESTAMP), 100.9 , 177, 24, 14.4 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Oscar', 	CAST('2018-05-02T11:50:00' AS TIMESTAMP), 101.0 , 196, 25, 14.4 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Oscar', 	CAST('2018-07-02T08:19:00' AS TIMESTAMP), 101.4 , 172, 28, 14.1 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Oscar', 	CAST('2018-10-02T09:59:00' AS TIMESTAMP), 101.8 , 177, 25, 14.3 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Patches',	CAST('2018-11-13T14:58:00' AS TIMESTAMP), 100.6 , 191, 24, 13.9 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Penny', 	CAST('2017-04-05T11:47:00' AS TIMESTAMP), 100.7 , 159, 26, 14.4 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Sadie', 	CAST('2017-01-10T13:58:00' AS TIMESTAMP), 100.0 , 188, 25, 13.6 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Sadie', 	CAST('2017-08-10T12:00:00' AS TIMESTAMP), 100.9 , 185, 25, 13.2 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Sadie', 	CAST('2018-04-10T11:23:00' AS TIMESTAMP), 101.1 , 159, 23, 13.3 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Sadie', 	CAST('2018-05-10T12:33:00' AS TIMESTAMP), 101.5 , 172, 23, 13.3 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Sadie', 	CAST('2018-07-10T11:55:00' AS TIMESTAMP), 101.7 , 153, 26, 13.7 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Sadie', 	CAST('2018-08-10T08:54:00' AS TIMESTAMP), 100.2 , 199, 26, 13.7 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Sadie', 	CAST('2018-09-10T10:29:00' AS TIMESTAMP), 101.3 , 156, 26, 13.3 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Sam', 	CAST('2018-11-13T11:39:00' AS TIMESTAMP), 100.1 , 164, 26, 8.1 , NULL, 'robin.murphy@animalshelter.com')
,('Cat', 'Sam', 	CAST('2018-12-13T10:52:00' AS TIMESTAMP), 100.0 , 191, 27, 7.8 , NULL, 'robin.murphy@animalshelter.com')
,('Cat', 'Simon', 	CAST('2018-03-28T14:26:00' AS TIMESTAMP), 100.1 , 167, 25, 9.5 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Simon', 	CAST('2019-01-28T12:16:00' AS TIMESTAMP), 101.0 , 167, 26, 9.3 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Simon', 	CAST('2019-02-28T07:34:00' AS TIMESTAMP), 101.0 , 172, 23, 9.5 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Simon', 	CAST('2019-03-28T10:43:00' AS TIMESTAMP), 101.7 , 164, 27, 9.1 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Thomas', 	CAST('2019-02-12T08:05:00' AS TIMESTAMP), 101.8 , 191, 26, 11.6 , NULL, 'dennis.hill@animalshelter.com')
,('Cat', 'Thomas', 	CAST('2019-03-12T07:08:00' AS TIMESTAMP), 101.7 , 161, 22, 11.9 , NULL, 'wayne.carter@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2017-03-02T14:59:00' AS TIMESTAMP), 101.1 , 180, 27, 8.9 , NULL, 'ashley.flores@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2018-04-02T13:40:00' AS TIMESTAMP), 100.2 , 159, 26, 8.8 , NULL, 'wayne.carter@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2018-05-02T13:12:00' AS TIMESTAMP), 102.0 , 193, 27, 8.7 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2018-08-02T09:39:00' AS TIMESTAMP), 101.0 , 204, 28, 8.9 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2018-10-02T08:03:00' AS TIMESTAMP), 100.6 , 153, 27, 9.1 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2018-11-02T11:16:00' AS TIMESTAMP), 101.0 , 185, 24, 9.5 , NULL, 'gerald.reyes@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2019-08-02T14:26:00' AS TIMESTAMP), 100.2 , 159, 25, 9.7 , NULL, 'wanda.myers@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2019-10-02T10:20:00' AS TIMESTAMP), 101.7 , 169, 22, 9.4 , NULL, 'dennis.hill@animalshelter.com')
,('Cat', 'Tigger', 	CAST('2019-12-02T10:56:00' AS TIMESTAMP), 101.2 , 196, 23, 9.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Abby', 	CAST('2017-03-22T14:39:00' AS TIMESTAMP), 101.5 , 81, 16, 20.5 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Abby', 	CAST('2017-11-22T13:52:00' AS TIMESTAMP), 101.3 , 84, 18, 20.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Abby', 	CAST('2018-05-22T09:11:00' AS TIMESTAMP), 101.8 , 84, 20, 20.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Arya', 	CAST('2018-10-22T14:04:00' AS TIMESTAMP), 100.3 , 89, 23, 27.4 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Arya', 	CAST('2019-01-22T11:15:00' AS TIMESTAMP), 101.7 , 116, 19, 27.8 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Arya', 	CAST('2019-02-22T10:11:00' AS TIMESTAMP), 101.0 , 100, 25, 26.8 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Arya', 	CAST('2019-03-22T12:29:00' AS TIMESTAMP), 101.9 , 121, 16, 26.3 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2016-04-25T12:06:00' AS TIMESTAMP), 100.6 , 103, 18, 17.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2016-05-25T09:23:00' AS TIMESTAMP), 102.0 , 73, 31, 17.9 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2016-07-25T11:52:00' AS TIMESTAMP), 101.9 , 73, 29, 18.3 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2016-08-25T09:03:00' AS TIMESTAMP), 101.0 , 92, 22, 17.9 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2017-08-25T14:13:00' AS TIMESTAMP), 100.5 , 108, 26, 18.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2017-09-25T12:57:00' AS TIMESTAMP), 100.0 , 95, 27, 17.6 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2018-10-25T11:32:00' AS TIMESTAMP), 101.9 , 76, 20, 17.2 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2019-04-25T10:54:00' AS TIMESTAMP), 101.6 , 73, 18, 17.6 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2019-06-25T08:13:00' AS TIMESTAMP), 101.5 , 116, 18, 18.2 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2019-07-25T12:01:00' AS TIMESTAMP), 102.0 , 103, 23, 19.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2019-10-25T07:21:00' AS TIMESTAMP), 100.9 , 100, 18, 19.5 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Aspen', 	CAST('2019-11-25T09:49:00' AS TIMESTAMP), 101.9 , 87, 27, 18.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Bailey', 	CAST('2018-11-27T11:18:00' AS TIMESTAMP), 100.8 , 108, 24, 34.7 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Bailey', 	CAST('2019-02-27T10:20:00' AS TIMESTAMP), 101.3 , 119, 23, 35.4 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Bailey', 	CAST('2019-03-27T09:03:00' AS TIMESTAMP), 100.8 , 95, 27, 35.8 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Bailey', 	CAST('2019-06-27T11:07:00' AS TIMESTAMP), 101.1 , 89, 26, 35.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Beau', 	CAST('2017-10-06T08:00:00' AS TIMESTAMP), 101.0 , 81, 21, 16.4 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Benji', 	CAST('2018-10-05T14:22:00' AS TIMESTAMP), 101.0 , 100, 22, 32.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Benji', 	CAST('2018-11-05T13:42:00' AS TIMESTAMP), 102.0 , 127, 21, 31.6 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Benny', 	CAST('2019-01-10T11:19:00' AS TIMESTAMP), 100.9 , 108, 16, 16.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Blue', 	CAST('2017-10-30T12:57:00' AS TIMESTAMP), 101.6 , 73, 16, 27.2 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Blue', 	CAST('2017-11-30T13:22:00' AS TIMESTAMP), 101.3 , 73, 27, 27.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Blue', 	CAST('2018-01-30T12:28:00' AS TIMESTAMP), 101.5 , 111, 16, 27.9 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Blue', 	CAST('2019-01-30T08:25:00' AS TIMESTAMP), 102.0 , 100, 22, 27.0 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Boomer', 	CAST('2017-02-09T08:25:00' AS TIMESTAMP), 101.4 , 95, 16, 33.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Boomer', 	CAST('2017-03-09T13:48:00' AS TIMESTAMP), 101.0 , 84, 28, 33.4 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Boomer', 	CAST('2017-05-09T11:36:00' AS TIMESTAMP), 101.1 , 92, 17, 34.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Boomer', 	CAST('2017-06-09T11:41:00' AS TIMESTAMP), 101.1 , 108, 24, 34.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Callie', 	CAST('2017-12-26T08:01:00' AS TIMESTAMP), 100.0 , 121, 30, 20.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Callie', 	CAST('2018-04-26T13:07:00' AS TIMESTAMP), 100.8 , 100, 18, 20.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Callie', 	CAST('2018-06-26T09:07:00' AS TIMESTAMP), 100.3 , 105, 29, 20.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Callie', 	CAST('2018-07-26T11:55:00' AS TIMESTAMP), 100.3 , 113, 23, 21.5 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Cooper', 	CAST('2017-06-05T11:01:00' AS TIMESTAMP), 101.2 , 79, 23, 22.7 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Cooper', 	CAST('2017-07-05T11:44:00' AS TIMESTAMP), 101.9 , 111, 16, 22.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Cooper', 	CAST('2017-09-05T07:14:00' AS TIMESTAMP), 100.3 , 79, 14, 22.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Cooper', 	CAST('2017-10-05T11:32:00' AS TIMESTAMP), 100.7 , 76, 24, 22.6 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Cooper', 	CAST('2017-12-05T13:32:00' AS TIMESTAMP), 101.5 , 100, 25, 22.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Cooper', 	CAST('2018-01-05T13:08:00' AS TIMESTAMP), 101.3 , 105, 18, 22.5 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Dolly', 	CAST('2018-10-09T14:46:00' AS TIMESTAMP), 101.8 , 121, 23, 26.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Dolly', 	CAST('2019-04-09T13:44:00' AS TIMESTAMP), 101.9 , 105, 30, 27.0 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Dolly', 	CAST('2019-10-09T07:56:00' AS TIMESTAMP), 101.4 , 81, 27, 26.1 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Dolly', 	CAST('2019-12-09T10:27:00' AS TIMESTAMP), 100.1 , 81, 26, 26.2 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Emma', 	CAST('2019-05-07T11:09:00' AS TIMESTAMP), 100.2 , 87, 17, 33.6 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Emma', 	CAST('2019-06-07T09:21:00' AS TIMESTAMP), 101.3 , 95, 23, 33.4 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Emma', 	CAST('2019-10-07T09:44:00' AS TIMESTAMP), 101.3 , 87, 20, 33.2 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Emma', 	CAST('2019-11-07T14:35:00' AS TIMESTAMP), 100.8 , 84, 14, 33.5 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Frankie',	CAST('2016-10-11T14:53:00' AS TIMESTAMP), 101.4 , 92, 24, 25.7 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Frankie',	CAST('2017-01-11T09:25:00' AS TIMESTAMP), 100.6 , 116, 28, 25.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Frankie',	CAST('2018-10-11T08:23:00' AS TIMESTAMP), 100.6 , 103, 28, 25.6 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Frankie',	CAST('2018-12-11T11:07:00' AS TIMESTAMP), 100.5 , 111, 28, 24.8 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Frankie',	CAST('2019-02-11T08:49:00' AS TIMESTAMP), 101.6 , 105, 19, 24.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Frankie',	CAST('2019-03-11T11:03:00' AS TIMESTAMP), 101.6 , 111, 23, 23.7 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Gizmo', 	CAST('2019-10-07T08:51:00' AS TIMESTAMP), 100.2 , 121, 31, 39.9 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Gizmo', 	CAST('2019-11-07T12:23:00' AS TIMESTAMP), 101.4 , 108, 14, 40.8 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Gus', 	CAST('2017-01-17T08:02:00' AS TIMESTAMP), 101.2 , 124, 26, 34.4 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Gus', 	CAST('2018-01-17T08:02:00' AS TIMESTAMP), 101.7 , 87, 23, 33.9 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Holly', 	CAST('2017-02-08T14:14:00' AS TIMESTAMP), 101.4 , 116, 17, 37.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Holly', 	CAST('2017-03-08T11:46:00' AS TIMESTAMP), 100.1 , 121, 25, 37.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Holly', 	CAST('2018-05-08T12:27:00' AS TIMESTAMP), 100.5 , 97, 28, 36.5 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Holly', 	CAST('2018-06-08T14:41:00' AS TIMESTAMP), 100.2 , 100, 23, 36.5 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Holly', 	CAST('2018-08-08T08:11:00' AS TIMESTAMP), 100.7 , 116, 25, 36.6 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Holly', 	CAST('2018-11-08T11:19:00' AS TIMESTAMP), 100.1 , 124, 23, 35.6 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Holly', 	CAST('2019-05-08T12:09:00' AS TIMESTAMP), 100.0 , 127, 15, 36.1 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Holly', 	CAST('2019-07-08T09:49:00' AS TIMESTAMP), 101.7 , 76, 18, 37.1 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Holly', 	CAST('2019-08-08T09:28:00' AS TIMESTAMP), 101.7 , 103, 21, 36.3 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Jake', 	CAST('2017-04-18T12:02:00' AS TIMESTAMP), 101.4 , 73, 18, 29.3 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Jake', 	CAST('2017-05-18T07:27:00' AS TIMESTAMP), 100.6 , 92, 21, 28.5 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Jake', 	CAST('2017-07-18T11:44:00' AS TIMESTAMP), 101.0 , 127, 25, 28.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Jake', 	CAST('2017-10-18T11:38:00' AS TIMESTAMP), 100.5 , 84, 15, 29.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Jake', 	CAST('2017-12-18T11:25:00' AS TIMESTAMP), 100.0 , 73, 28, 29.2 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Jake', 	CAST('2018-04-18T07:13:00' AS TIMESTAMP), 101.6 , 89, 16, 29.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Jake', 	CAST('2018-10-18T11:03:00' AS TIMESTAMP), 100.5 , 113, 21, 29.2 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Jake', 	CAST('2018-12-18T08:24:00' AS TIMESTAMP), 101.1 , 76, 18, 29.2 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Jake', 	CAST('2019-04-18T14:36:00' AS TIMESTAMP), 100.5 , 87, 22, 29.7 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Jake', 	CAST('2019-06-18T11:06:00' AS TIMESTAMP), 101.0 , 92, 23, 29.7 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Jake', 	CAST('2019-07-18T10:56:00' AS TIMESTAMP), 100.6 , 127, 16, 29.4 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Jax', 	CAST('2017-11-22T07:00:00' AS TIMESTAMP), 100.6 , 111, 29, 29.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Jax', 	CAST('2017-12-22T14:29:00' AS TIMESTAMP), 101.9 , 87, 18, 29.3 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Jax', 	CAST('2018-01-22T12:51:00' AS TIMESTAMP), 100.3 , 100, 25, 29.7 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'King', 	CAST('2017-09-07T08:08:00' AS TIMESTAMP), 101.0 , 121, 19, 33.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'King', 	CAST('2018-05-07T07:42:00' AS TIMESTAMP), 101.8 , 111, 26, 33.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'King', 	CAST('2018-06-07T13:59:00' AS TIMESTAMP), 101.3 , 89, 23, 32.7 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'King', 	CAST('2018-08-07T07:08:00' AS TIMESTAMP), 101.0 , 89, 23, 32.7 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'King', 	CAST('2018-11-07T11:45:00' AS TIMESTAMP), 100.4 , 111, 28, 31.9 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'King', 	CAST('2018-12-07T07:50:00' AS TIMESTAMP), 101.5 , 103, 19, 31.0 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Layla', 	CAST('2018-10-26T11:45:00' AS TIMESTAMP), 101.0 , 84, 15, 27.8 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Layla', 	CAST('2018-11-26T09:22:00' AS TIMESTAMP), 100.2 , 95, 23, 27.3 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Layla', 	CAST('2018-12-26T10:05:00' AS TIMESTAMP), 101.9 , 97, 18, 27.9 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Layla', 	CAST('2019-04-26T10:45:00' AS TIMESTAMP), 100.2 , 89, 17, 28.3 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Layla', 	CAST('2019-06-26T13:45:00' AS TIMESTAMP), 100.5 , 121, 18, 27.4 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Layla', 	CAST('2019-11-26T07:41:00' AS TIMESTAMP), 101.8 , 100, 31, 26.9 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Layla', 	CAST('2019-12-26T08:01:00' AS TIMESTAMP), 100.8 , 105, 18, 26.6 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Lily', 	CAST('2016-10-13T10:58:00' AS TIMESTAMP), 100.5 , 84, 26, 33.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Lily', 	CAST('2016-12-13T09:57:00' AS TIMESTAMP), 100.1 , 87, 24, 32.7 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Lily', 	CAST('2017-04-13T13:05:00' AS TIMESTAMP), 101.1 , 108, 28, 32.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Lily', 	CAST('2017-06-13T08:09:00' AS TIMESTAMP), 100.5 , 121, 23, 32.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Lily', 	CAST('2017-10-13T11:19:00' AS TIMESTAMP), 100.4 , 105, 18, 32.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Lily', 	CAST('2017-11-13T12:00:00' AS TIMESTAMP), 101.6 , 87, 18, 33.4 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Lily', 	CAST('2017-12-13T11:58:00' AS TIMESTAMP), 101.7 , 119, 26, 33.7 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Lily', 	CAST('2018-02-13T14:33:00' AS TIMESTAMP), 101.1 , 89, 17, 33.7 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Lily', 	CAST('2018-03-13T10:07:00' AS TIMESTAMP), 102.0 , 95, 29, 33.4 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Lily', 	CAST('2019-02-13T08:57:00' AS TIMESTAMP), 101.1 , 100, 16, 33.9 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Lily', 	CAST('2019-03-13T07:35:00' AS TIMESTAMP), 101.9 , 84, 24, 34.1 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Luke', 	CAST('2018-04-20T12:44:00' AS TIMESTAMP), 101.0 , 111, 23, 15.0 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Luna', 	CAST('2018-05-01T10:52:00' AS TIMESTAMP), 100.2 , 127, 28, 23.8 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Luna', 	CAST('2018-06-01T08:27:00' AS TIMESTAMP), 100.4 , 73, 29, 23.2 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Luna', 	CAST('2018-08-01T11:38:00' AS TIMESTAMP), 101.9 , 81, 15, 24.0 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Luna', 	CAST('2019-08-01T08:46:00' AS TIMESTAMP), 100.9 , 121, 18, 23.3 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Mac', 	CAST('2018-04-03T10:34:00' AS TIMESTAMP), 101.1 , 84, 28, 35.1 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Mac', 	CAST('2018-05-03T12:21:00' AS TIMESTAMP), 100.5 , 73, 18, 34.7 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Maddie', 	CAST('2017-08-01T10:36:00' AS TIMESTAMP), 101.9 , 105, 31, 38.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Maddie', 	CAST('2017-09-01T09:07:00' AS TIMESTAMP), 100.4 , 87, 29, 38.0 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Millie', 	CAST('2016-12-12T08:04:00' AS TIMESTAMP), 100.7 , 124, 31, 29.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Millie', 	CAST('2017-12-12T13:57:00' AS TIMESTAMP), 101.1 , 95, 18, 30.0 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Mocha', 	CAST('2019-05-14T11:10:00' AS TIMESTAMP), 102.0 , 89, 18, 33.3 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Odin', 	CAST('2016-09-30T08:00:00' AS TIMESTAMP), 100.8 , 127, 28, 16.8 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Odin', 	CAST('2017-01-30T11:25:00' AS TIMESTAMP), 101.6 , 76, 18, 16.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Odin', 	CAST('2017-03-30T10:31:00' AS TIMESTAMP), 101.0 , 89, 22, 17.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Odin', 	CAST('2018-07-30T07:22:00' AS TIMESTAMP), 101.7 , 100, 25, 18.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Odin', 	CAST('2018-08-30T10:54:00' AS TIMESTAMP), 101.4 , 108, 26, 18.0 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Odin', 	CAST('2019-01-30T12:44:00' AS TIMESTAMP), 101.2 , 95, 21, 17.4 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Otis', 	CAST('2018-07-23T12:54:00' AS TIMESTAMP), 101.2 , 84, 15, 39.3 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Otis', 	CAST('2018-08-23T11:37:00' AS TIMESTAMP), 100.1 , 97, 28, 39.3 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Otis', 	CAST('2019-04-23T10:07:00' AS TIMESTAMP), 101.8 , 87, 25, 39.2 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Otis', 	CAST('2019-05-23T11:55:00' AS TIMESTAMP), 101.5 , 111, 24, 39.0 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Otis', 	CAST('2019-07-23T09:38:00' AS TIMESTAMP), 101.8 , 76, 26, 38.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2016-02-03T07:29:00' AS TIMESTAMP), 100.7 , 124, 30, 33.2 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2016-03-03T14:55:00' AS TIMESTAMP), 101.0 , 73, 26, 33.7 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2016-05-03T13:34:00' AS TIMESTAMP), 101.9 , 103, 21, 34.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2016-06-03T13:52:00' AS TIMESTAMP), 101.7 , 108, 25, 34.4 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2017-01-03T08:27:00' AS TIMESTAMP), 100.2 , 97, 18, 34.6 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2017-02-03T14:27:00' AS TIMESTAMP), 100.6 , 84, 23, 34.7 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2017-03-03T12:13:00' AS TIMESTAMP), 101.1 , 121, 23, 35.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2018-08-03T14:12:00' AS TIMESTAMP), 101.1 , 103, 28, 34.4 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Penelope', 	CAST('2018-10-03T12:34:00' AS TIMESTAMP), 101.6 , 100, 18, 34.9 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Poppy', 		CAST('2018-06-06T07:15:00' AS TIMESTAMP), 100.2 , 84, 23, 36.4 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Poppy', 		CAST('2018-07-06T14:02:00' AS TIMESTAMP), 101.6 , 92, 23, 36.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Poppy', 		CAST('2018-08-06T14:15:00' AS TIMESTAMP), 101.5 , 76, 18, 36.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Poppy', 		CAST('2018-09-06T12:34:00' AS TIMESTAMP), 101.4 , 73, 27, 36.3 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Ranger', 		CAST('2017-10-03T07:39:00' AS TIMESTAMP), 100.0 , 97, 28, 39.4 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Ranger', 		CAST('2017-11-03T13:28:00' AS TIMESTAMP), 100.2 , 92, 28, 40.3 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Ranger', 		CAST('2018-01-03T12:13:00' AS TIMESTAMP), 100.6 , 84, 23, 40.3 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Ranger', 		CAST('2018-05-03T14:02:00' AS TIMESTAMP), 100.8 , 105, 24, 40.5 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Remi / Remy', CAST('2018-11-12T10:06:00' AS TIMESTAMP), 101.9 , 100, 26, 16.9 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Remi / Remy', CAST('2018-12-12T14:46:00' AS TIMESTAMP), 101.3 , 89, 23, 17.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Remi / Remy', CAST('2019-04-12T14:52:00' AS TIMESTAMP), 101.4 , 100, 25, 16.5 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Riley', 		CAST('2019-06-25T07:56:00' AS TIMESTAMP), 100.6 , 92, 14, 36.7 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Riley', 		CAST('2019-07-25T10:48:00' AS TIMESTAMP), 100.1 , 124, 17, 36.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Riley', 		CAST('2019-09-25T12:42:00' AS TIMESTAMP), 100.7 , 103, 14, 36.1 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Roxy', 		CAST('2018-10-26T07:51:00' AS TIMESTAMP), 100.2 , 121, 18, 34.8 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Roxy', 		CAST('2018-11-26T09:57:00' AS TIMESTAMP), 101.9 , 113, 23, 34.3 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Roxy', 		CAST('2018-12-26T11:02:00' AS TIMESTAMP), 100.3 , 73, 17, 33.9 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Roxy', 		CAST('2019-04-26T13:54:00' AS TIMESTAMP), 100.1 , 79, 23, 33.4 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Roxy', 		CAST('2019-06-26T08:18:00' AS TIMESTAMP), 100.9 , 81, 14, 34.0 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Roxy', 		CAST('2019-07-26T11:04:00' AS TIMESTAMP), 102.0 , 89, 21, 34.1 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Rusty', 		CAST('2016-04-14T08:59:00' AS TIMESTAMP), 101.4 , 81, 28, 36.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2018-04-10T12:00:00' AS TIMESTAMP), 101.2 , 73, 28, 35.2 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2018-05-10T08:14:00' AS TIMESTAMP), 101.7 , 108, 25, 34.7 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2018-07-10T14:24:00' AS TIMESTAMP), 100.2 , 105, 23, 34.9 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2018-08-10T13:05:00' AS TIMESTAMP), 101.4 , 121, 23, 35.5 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2018-12-10T10:18:00' AS TIMESTAMP), 101.1 , 105, 28, 36.0 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2019-04-10T14:20:00' AS TIMESTAMP), 100.6 , 89, 20, 36.6 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2019-10-10T09:13:00' AS TIMESTAMP), 100.4 , 116, 23, 36.6 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Sammy', 		CAST('2019-12-10T14:00:00' AS TIMESTAMP), 101.1 , 92, 23, 36.3 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Samson', 		CAST('2019-02-27T12:06:00' AS TIMESTAMP), 101.0 , 76, 25, 29.1 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Samson', 		CAST('2019-03-27T09:04:00' AS TIMESTAMP), 101.6 , 100, 26, 28.1 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2016-05-19T07:02:00' AS TIMESTAMP), 100.7 , 103, 17, 25.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2016-08-19T07:15:00' AS TIMESTAMP), 102.0 , 87, 22, 25.0 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2016-09-19T12:11:00' AS TIMESTAMP), 100.1 , 73, 29, 25.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2016-10-19T14:08:00' AS TIMESTAMP), 101.9 , 111, 25, 26.4 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2016-12-19T12:55:00' AS TIMESTAMP), 102.0 , 100, 19, 27.3 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2017-01-19T07:02:00' AS TIMESTAMP), 100.3 , 92, 14, 26.7 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2017-04-19T14:12:00' AS TIMESTAMP), 100.8 , 103, 17, 26.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2017-05-19T08:46:00' AS TIMESTAMP), 100.8 , 84, 23, 27.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2017-06-19T14:04:00' AS TIMESTAMP), 101.6 , 113, 20, 26.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2017-07-19T11:23:00' AS TIMESTAMP), 100.7 , 111, 31, 26.0 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Shadow', 		CAST('2017-12-19T13:34:00' AS TIMESTAMP), 100.3 , 111, 19, 25.3 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2018-01-26T13:45:00' AS TIMESTAMP), 100.7 , 89, 15, 26.4 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2018-02-26T14:41:00' AS TIMESTAMP), 100.5 , 92, 21, 27.3 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2018-03-26T09:23:00' AS TIMESTAMP), 101.1 , 111, 18, 28.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2019-02-26T08:08:00' AS TIMESTAMP), 101.2 , 76, 16, 28.1 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2019-03-26T09:23:00' AS TIMESTAMP), 101.5 , 111, 23, 27.6 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2019-04-26T12:05:00' AS TIMESTAMP), 100.1 , 119, 28, 27.0 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2019-06-26T12:07:00' AS TIMESTAMP), 100.9 , 108, 30, 26.9 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Shelby', 		CAST('2019-07-26T11:03:00' AS TIMESTAMP), 100.8 , 79, 17, 27.8 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Stella', 		CAST('2018-09-05T09:42:00' AS TIMESTAMP), 100.4 , 89, 23, 39.1 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Stella', 		CAST('2018-10-05T13:05:00' AS TIMESTAMP), 102.0 , 92, 18, 39.5 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Stella', 		CAST('2018-11-05T08:33:00' AS TIMESTAMP), 102.0 , 76, 27, 39.0 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Stella', 		CAST('2018-12-05T11:03:00' AS TIMESTAMP), 100.6 , 95, 23, 38.2 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Thor', 		CAST('2017-10-05T10:41:00' AS TIMESTAMP), 100.7 , 121, 31, 25.9 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Thor', 		CAST('2017-12-05T10:29:00' AS TIMESTAMP), 100.5 , 81, 27, 26.7 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Thor', 		CAST('2018-04-05T08:50:00' AS TIMESTAMP), 101.2 , 92, 17, 26.2 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Thor', 		CAST('2018-06-05T09:41:00' AS TIMESTAMP), 100.2 , 97, 29, 25.2 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Thor', 		CAST('2018-10-05T09:13:00' AS TIMESTAMP), 100.9 , 100, 27, 24.4 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Thor', 		CAST('2018-11-05T07:26:00' AS TIMESTAMP), 100.1 , 76, 14, 24.9 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Thor', 		CAST('2018-12-05T11:12:00' AS TIMESTAMP), 100.4 , 95, 14, 25.1 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Thor', 		CAST('2019-04-05T09:13:00' AS TIMESTAMP), 100.8 , 73, 23, 25.2 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Thor', 		CAST('2019-06-05T13:48:00' AS TIMESTAMP), 101.1 , 81, 23, 25.1 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Thor', 		CAST('2019-07-05T12:24:00' AS TIMESTAMP), 102.0 , 103, 23, 24.1 , NULL, 'wanda.myers@animalshelter.com')
,('Dog', 'Thor', 		CAST('2019-08-05T08:08:00' AS TIMESTAMP), 102.0 , 97, 23, 24.4 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Thor', 		CAST('2019-09-05T13:17:00' AS TIMESTAMP), 101.6 , 119, 18, 24.8 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Tyson', 		CAST('2019-01-04T09:11:00' AS TIMESTAMP), 101.8 , 84, 31, 38.6 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Tyson', 		CAST('2019-02-04T12:45:00' AS TIMESTAMP), 100.3 , 127, 30, 38.8 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Tyson', 		CAST('2019-03-04T07:53:00' AS TIMESTAMP), 100.1 , 108, 15, 38.9 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Walter', 		CAST('2018-04-05T13:16:00' AS TIMESTAMP), 101.2 , 124, 21, 19.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Walter', 		CAST('2018-06-05T09:21:00' AS TIMESTAMP), 101.0 , 105, 27, 19.5 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Walter', 		CAST('2018-07-05T12:15:00' AS TIMESTAMP), 101.6 , 87, 31, 18.6 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Walter', 		CAST('2018-09-05T07:16:00' AS TIMESTAMP), 100.6 , 127, 25, 18.2 , NULL, 'gerald.reyes@animalshelter.com')
,('Dog', 'Walter', 		CAST('2018-10-05T09:50:00' AS TIMESTAMP), 100.6 , 73, 30, 17.2 , NULL, 'ashley.flores@animalshelter.com')
,('Dog', 'Walter', 		CAST('2018-12-05T12:59:00' AS TIMESTAMP), 101.3 , 97, 23, 17.4 , NULL, 'robin.murphy@animalshelter.com')
,('Dog', 'Walter', 		CAST('2019-08-05T09:30:00' AS TIMESTAMP), 101.0 , 105, 29, 17.0 , NULL, 'wayne.carter@animalshelter.com')
,('Dog', 'Walter', 		CAST('2019-09-05T09:26:00' AS TIMESTAMP), 101.2 , 121, 18, 16.2 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Walter', 		CAST('2019-11-05T09:38:00' AS TIMESTAMP), 100.2 , 100, 31, 15.5 , NULL, 'dennis.hill@animalshelter.com')
,('Dog', 'Walter', 		CAST('2019-12-05T07:36:00' AS TIMESTAMP), 101.7 , 100, 24, 15.8 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'April',	CAST('2019-05-03T07:55:00' AS TIMESTAMP), 101.5 , 129, 54, 7.3 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'April',	CAST('2019-06-03T07:23:00' AS TIMESTAMP), 101.6 , 143, 44, 7.1 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'April',	CAST('2019-07-03T08:15:00' AS TIMESTAMP), 101.7 , 140, 45, 6.9 , NULL, 'wayne.carter@animalshelter.com')
,('Rabbit', 'April',	CAST('2019-10-03T10:48:00' AS TIMESTAMP), 102.3 , 132, 52, 6.8 , NULL, 'gerald.reyes@animalshelter.com')
,('Rabbit', 'April',	CAST('2019-12-03T11:22:00' AS TIMESTAMP), 101.4 , 126, 51, 6.7 , NULL, 'gerald.reyes@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2016-10-12T07:58:00' AS TIMESTAMP), 101.2 , 144, 38, 4.3 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2016-12-12T07:42:00' AS TIMESTAMP), 102.9 , 126, 38, 4.5 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2017-04-12T10:41:00' AS TIMESTAMP), 102.5 , 144, 40, 4.6 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2017-05-12T11:05:00' AS TIMESTAMP), 102.0 , 132, 50, 4.7 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2017-06-12T09:59:00' AS TIMESTAMP), 101.5 , 129, 46, 4.6 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2017-07-12T13:00:00' AS TIMESTAMP), 101.2 , 137, 54, 4.6 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2017-10-12T14:04:00' AS TIMESTAMP), 102.0 , 139, 42, 4.4 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'Baloo',	CAST('2017-12-12T13:15:00' AS TIMESTAMP), 101.5 , 126, 49, 4.6 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Bon bon', 	CAST('2017-02-07T08:27:00' AS TIMESTAMP), 102.5 , 138, 43, 6.0 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Bon bon', 	CAST('2017-03-07T10:42:00' AS TIMESTAMP), 101.0 , 143, 39, 6.0 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Bon bon', 	CAST('2018-05-07T09:14:00' AS TIMESTAMP), 101.0 , 128, 36, 5.8 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'Bon bon', 	CAST('2019-02-07T11:46:00' AS TIMESTAMP), 101.8 , 144, 47, 6.0 , NULL, 'wayne.carter@animalshelter.com')
,('Rabbit', 'Humphrey',	CAST('2018-09-19T09:43:00' AS TIMESTAMP), 102.2 , 142, 41, 4.2 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'Humphrey',	CAST('2018-12-19T08:32:00' AS TIMESTAMP), 101.3 , 134, 43, 4.1 , NULL, 'wayne.carter@animalshelter.com')
,('Rabbit', 'Luna', 	CAST('2017-09-26T14:13:00' AS TIMESTAMP), 101.1 , 136, 45, 6.5 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Luna', 	CAST('2017-12-26T12:52:00' AS TIMESTAMP), 102.6 , 135, 48, 6.5 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'Luna', 	CAST('2018-10-26T10:03:00' AS TIMESTAMP), 102.4 , 142, 45, 6.4 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Luna', 	CAST('2018-11-26T09:20:00' AS TIMESTAMP), 102.9 , 131, 54, 6.4 , NULL, 'robin.murphy@animalshelter.com')
,('Rabbit', 'Luna', 	CAST('2018-12-26T12:42:00' AS TIMESTAMP), 102.6 , 144, 41, 6.3 , NULL, 'dennis.hill@animalshelter.com')
,('Rabbit', 'Peanut', 	CAST('2018-09-18T09:40:00' AS TIMESTAMP), 101.8 , 127, 42, 3.2 , NULL, 'robin.murphy@animalshelter.com')
,('Rabbit', 'Peanut', 	CAST('2018-10-18T08:43:00' AS TIMESTAMP), 101.1 , 135, 46, 3.0 , NULL, 'wayne.carter@animalshelter.com')
,('Rabbit', 'Peanut', 	CAST('2018-12-18T11:15:00' AS TIMESTAMP), 101.6 , 137, 41, 3.2 , NULL, 'gerald.reyes@animalshelter.com')
,('Rabbit', 'Whitney', 	CAST('2017-11-01T13:07:00' AS TIMESTAMP), 102.5 , 135, 52, 6.9 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Whitney', 	CAST('2017-12-01T07:19:00' AS TIMESTAMP), 101.6 , 135, 44, 6.8 , NULL, 'wanda.myers@animalshelter.com')
,('Rabbit', 'Whitney', 	CAST('2018-08-01T09:16:00' AS TIMESTAMP), 101.3 , 135, 48, 6.6 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Whitney', 	CAST('2019-02-01T10:16:00' AS TIMESTAMP), 102.5 , 130, 43, 6.5 , NULL, 'ashley.flores@animalshelter.com')
,('Rabbit', 'Whitney', 	CAST('2019-03-01T10:03:00' AS TIMESTAMP), 102.4 , 137, 47, 6.6 , NULL, 'dennis.hill@animalshelter.com');