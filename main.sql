.open softwaredatabase.db
.mode markdown
.once softwaredatabase.md

CREATE TABLE `Ethnicity` ( 
    `EthnicityKey` INTEGER,
    `EthnicityDescription` TEXT,
     PRIMARY KEY (`EthnicityKey`) 
);

CREATE TABLE `Users` ( 
    `UserID` INTEGER,
    `StartDate` DATE Check (`StartDate` <= `EndDate`),
    `EndDate` DATE Check (`EndDate` >= `StartDate`),
    `Profession` TEXT CHECK (`Profession` in ("Instructor", "Staff")),
     PRIMARY KEY (`UserID`)
);

CREATE TABLE `RequestForms` (
     `RequestID` INTEGER,
      `RequestDate` DATE,
      `ResponseID` INTEGER,
      `SoftwareName` TEXT,
      `UserID` INTEGER,
      PRIMARY KEY (`RequestID`),
      FOREIGN KEY (`UserID`) REFERENCES `Users`(`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (`ResponseID`) REFERENCES `Response`(`ResponseID`) ON DELETE CASCADE ON UPDATE CASCADE
); 

CREATE TABLE `PersonalData` ( 
      `UserID` INTEGER,
      `FirstName` TEXT,
      `LastName` TEXT,
      `PhoneNumber` INTEGER CHAR(10) UNIQUE,
      `Ethnicitykey` INTEGER,
      `Email` TEXT NOT NULL UNIQUE CHECK (Email LIKE '%@%.%'),
       PRIMARY KEY (`UserID`),
      FOREIGN KEY (`Ethnicitykey`) REFERENCES `Ethnicity`(`EthnicityKey`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `License` ( 
      `LicenseID` INTEGER,
      `SoftwareID` INTEGER,
      `LicenseType` TEXT,
      `Terms` TEXT,
      `Pricing` NUMERIC CHECK (Pricing>=0), 
      `PricingUnit` TEXT,
      `StartDate` DATE CHECK (`StartDate`<=`EndDate`),
      `EndDate` DATE CHECK (`EndDate`>=`StartDate`),
       PRIMARY KEY (`LicenseID`)
       FOREIGN KEY (`SoftwareID`) REFERENCES `Software`(`SoftwareID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Response` (
    `ResponseID` INTEGER,
    `ResponseDescription` TEXT,
    `ResponseDate` DATE,
    `Status` TEXT CHECK (`Status` in ('Pending', 'Accepted', 'Denied')),
     PRIMARY KEY (`ResponseID`)
);

CREATE TABLE `Machine` ( 
    `MachineID` INTEGER,
    `Location` TEXT,
    `MachineRetireDate` DATE,
    `SoftwareInstallationDate` DATE,
    `SoftwareUninstallationDate` DATE,
    PRIMARY KEY (`MachineID`)
);

CREATE TABLE `Software` (
    `SoftwareID` INTEGER,
    `SoftwareName` TEXT,
    `Version` TEXT,
    `Company` TEXT,
    PRIMARY KEY (`SoftwareID`)
);

CREATE TABLE `MachineUsers` ( 
    `MachineID` INTEGER,
    `UserID` INTEGER,
    PRIMARY KEY (`MachineID`, `UserID`),
    FOREIGN KEY (`MachineID`) REFERENCES `Machine`(`MachineID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`UserID`) REFERENCES `Users`(`UserID`) ON DELETE CASCADE ON UPDATE CASCADE)
;

CREATE TABLE `MachineSoftware` ( 
    `MachineID` INTEGER,
    `SoftwareID` INTEGER,
    PRIMARY KEY (`MachineID`, `SoftwareID`),
    FOREIGN KEY (`SoftwareID`) REFERENCES `Software`(`SoftwareID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`MachineID`) REFERENCES `Machine`(`MachineID`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO MachineSoftware(`MachineID`, `SoftwareID`)
    VALUES (1234,115),
    (1235,115),
    (1237, 112),
    (1234, 113)
;
 
INSERT INTO MACHINE (`MachineID`, `Location`, `MachineRetireDate`, `SoftwareInstallationDate`, `SoftwareUninstallationDate`)
      VALUES (1234, 'Library', '2026-12-31', '2023-12-21', '2026-09-31'),
      (1235, 'Boone', '2030-12-31', '2024-12-31', '2028-09-31'),
      (1236, 'Mccain','2031-12-31', '2025-12-31', '2029-09-31'),
      (1237, 'Covell','2032-12-31', '2026-12-31', '2030-09-31');

INSERT INTO MachineUsers (`MachineID`, `UserID`) VALUES 
    (1234, 1),
    (1235,1),
    (1236,3),
    (1237,4);

INSERT INTO `License`(`LicenseID`, `SoftwareID`, `LicenseType`, `Terms`, `Pricing`, `PricingUnit`, `StartDate`, `EndDate`)
VALUES (1234567, 112, 'MS Site', 'Can install as many copies as needed on campus and on laptops controlled by the school. Includes all service patches, updates, and version changes', 12500,'5 yrs', '2009-07-01', '2013-07-01'),
    (2234567, 113, 'MS Site', 'Can install as many copies as needed on campus and on laptops controlled by the school. Includes all service patches, updates, and version changes', 12500,'5 yrs', '2009-07-01', '2013-07-01'),
    (3234567, 114, 'MS Instructional', 'Used for instructional purposes only. Cannot be used for school development projects', 3000,'5 yrs', '2010-07-01', '2015-07-01'),
    (4234567, 115, 'Adobe1', 'Reduced price per installed copy, maximum of 25 active copies', 450, 'Per active copy', '2009-07-01', '2015-07-01'),
    (5234567, 116, 'Open Source', 'Free for use as long as registered', 0, NULL, '2009-07-01', '2020-07-01'),
    (6234567, 117, 'LanguageSoft1', '25 copies', 5200, 'For 25 copies', '2012-07-01', '2016-07-01');

-- 
INSERT INTO `Software` (`SoftwareID`,`SoftwareName`,`Version`,`Company`)
VALUES (112, 'Windows Vista','Business Service Pack 2','Microsoft'),
  (113, 'MS office', '2007', 'Microsoft'),
  (114, 'Visual Studio','Professional 2008','Microsoft'),
  (115, 'PhotoShop', 'CSS3', 'Adobe'),
  (116, 'FileZilla', '5', 'FileZilla'),
  (117, 'German', '2.5', 'LanguageSoft');


-- 

INSERT INTO `Users` (`UserID`,`StartDate`,`EndDate`,`Profession`) 
VALUES (1,'2020-08-24','2028-05-22','Instructor'),
    (2,'2020-01-01','2024-05-22','Staff'),
    (3,'2020-12-05','2021-12-05','Staff'),
    (4,'2020-12-04','2021-01-04','Instructor'),
    (5,'2019-11-01','2020-11-01','Staff');

INSERT INTO `PersonalData` (`UserID`,`FirstName`,`LastName`,`PhoneNumber`, `Ethnicitykey`, `Email`) VALUES
    (2,'Zaynab','El Hakour','2083708662',1,'elhakourzaynab@gmail.com'),
    (3,'Rakeb', 'Abraham Jabessa', '3568933344',2,'rabraham@collegeofidaho.edu'),
    (4,'Bob', 'Marley', '3451203444',3,'bmarley@yahoo.com'),
    (1,'Jonny','Comes','2084532345',4,'Jcomes@collegeofidaho.edu');

INSERT INTO `Ethnicity` (`EthnicityKey`,`EthnicityDescription`)
VALUES (1, 'Moroccan'),
      (2, 'Ethiopian'),
      (3, 'Jamaican'),
      (4, 'American');
-- 
INSERT INTO RequestForms (`RequestID`, `RequestDate`, `ResponseID`, `SoftwareName`, `UserID`)
VALUES (100, '2009-05-20', 10, 'Camtasia', 1),
       (101, '2009-05-22', 11, 'MathType', 2),
       (102, '2009-05-24', 12, 'Grammarly', 3);

INSERT INTO `Response` (`ResponseID`, `ResponseDescription`, `ResponseDate`, `Status`)
VALUES (10, 'We dont currently have a license for Camtasia but will explore acquiring one', '2009-05-24', 'Pending'),
       (11, 'MathType is in the planning list and will send out information once software package is arrived.', '2009-05-26', 'Accepted'),
       (12, 'Unfortunately, Grammarly is for more personal use so we will reject the proposal','2009-05-28', 'Denied');


Create View Department_receiving_Software AS
SELECT 
  S.SoftwareName AS "Software_Name",
  S.Version AS "Software_Version",
  S.Company As "Software_Company",
  L.licensetype AS "License_Type",
  L.terms AS "License_Terms",
  L.pricing AS "License_Pricing",
  L.pricingunit AS "License_pricing_Unit",
  L.startDate  AS "License_startDate",
  L.endDate AS "License_endDate"
FROM Software as S
JOIN License as L on S.softwareid = L.softwareid;

CREATE VIEW Response_Requests_for_users AS 
SELECT 
    Rq.RequestDate AS "Request_Date",
    Ps.FirstName || ' ' || Ps.LastName AS "User_Name",
    Rq.SoftwareName AS "Software_Name",
    Us.StartDate AS "Start_Date_of_Software_use",
    Us.EndDate AS "End_Date_of_Software_use",
    Us.Profession, 
    Rs.ResponseDate AS "Response_Date",
    Rs.ResponseDescription AS "Response_Description",
    Rs.Status AS "Status"
FROM Response as Rs
Join RequestForms as Rq on Rq.ResponseID = Rs.ResponseID
Join Users as Us on Rq.UserID = Us.UserID
Join PersonalData as Ps on Ps.UserID = Us.UserID;
  
CREATE VIEW everything_about_software AS 
SELECT
       pd.FirstName || ' ' || pd.LastName AS "User_Name",
       s.softwareName, 
       s.Version, 
       s.company,  
       l.LicenseType, 
       l.Terms, 
       l.Pricing, 
       l.PricingUnit, 
       l.StartDate AS "License_Start_Date", 
       l.EndDate AS "License_End_Date", 
       m.Location, 
       m.MachineRetireDate,
       m.SoftwareInstallationDate AS "Software_Installation_Date",
       m.SoftwareUninstallationDate AS "Software_Unstallation_Date"
FROM software AS s
JOIN License AS l ON s.SoftwareID = l.SoftwareID
JOIN MachineSoftware AS ms ON s.SoftwareID = ms.SoftwareID
JOIN Machine AS m ON m.MachineID = ms.MachineID
JOIN MachineUsers AS mu ON m.MachineID = mu.MachineID
JOIN Users AS u ON u.UserID = mu.UserID
JOIN PersonalData AS pd ON u.UserID = pd.UserID;

CREATE VIEW PersonalInformation AS
SELECT
  PD.FirstName || ' ' || PD.LastName AS "User_Name",
  PD.PhoneNumber AS "Phone_Number", 
  PD.Email, 
  E.EthnicityDescription AS "Ethnicity_Description", 
  U.StartDate AS "Start_Date_of_Software_use", 
  U.EndDate AS "End_Date_of_Software_use", 
  U.Profession, 
  M.Location, 
  M.MachineRetireDate AS "Machine_Retire_Date", 
  M.SoftwareInstallationDate AS "Software_Installation_Date", 
  M.SoftwareUninstallationDate AS "Software_Uninstallation_Date"
FROM PersonalData AS PD
JOIN Users AS U ON PD.UserID = U.UserID
JOIN Ethnicity AS E ON PD.Ethnicitykey = E.Ethnicitykey
JOIN MachineUsers AS MU ON MU.UserID = U.UserID
JOIN Machine AS M ON MU.MachineID = M.MachineID;

--select * from PersonalInformation;

select * from everything_about_software;

--select * from Response_Requests_for_users;

--select * from Department_receiving_Software;

