
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 06/29/2023 14:10:35
-- --------------------------------------------------
USE master;
GO
CREATE DATABASE [PrzychodniaProjectDB];
GO
SET QUOTED_IDENTIFIER OFF;
GO
USE [PrzychodniaProjectDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_chorobawizyta]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Choroby_wizyty] DROP CONSTRAINT [FK_chorobawizyta];
GO
IF OBJECT_ID(N'[dbo].[FK_chorobawizytanr]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Choroby_wizyty] DROP CONSTRAINT [FK_chorobawizytanr];
GO
IF OBJECT_ID(N'[dbo].[FK_wizytalekarz]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Wizyty] DROP CONSTRAINT [FK_wizytalekarz];
GO
IF OBJECT_ID(N'[dbo].[FK_wizytapacjent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Wizyty] DROP CONSTRAINT [FK_wizytapacjent];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Choroby]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Choroby];
GO
IF OBJECT_ID(N'[dbo].[Choroby_wizyty]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Choroby_wizyty];
GO
IF OBJECT_ID(N'[dbo].[Lekarze]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Lekarze];
GO
IF OBJECT_ID(N'[dbo].[Pacjenci]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pacjenci];
GO
IF OBJECT_ID(N'[dbo].[sysdiagrams]', 'U') IS NOT NULL
    DROP TABLE [dbo].[sysdiagrams];
GO
IF OBJECT_ID(N'[dbo].[Wizyty]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Wizyty];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Choroby'
CREATE TABLE [dbo].[Choroby] (
    [nr_choroby] varchar(10)  NOT NULL,
    [opis_choroby] varchar(100)  NOT NULL
);
GO

-- Creating table 'Lekarze'
CREATE TABLE [dbo].[Lekarze] (
    [nr_lekarza] int  NOT NULL,
    [imie_lekarza] varchar(20)  NOT NULL,
    [nazwisko_lekarza] varchar(30)  NOT NULL
);
GO

-- Creating table 'Pacjenci'
CREATE TABLE [dbo].[Pacjenci] (
    [pesel_pacjenta] char(11)  NOT NULL,
    [imie_pacjenta] varchar(20)  NOT NULL,
    [nazwisko_pacjenta] varchar(30)  NOT NULL,
    [ulica] varchar(50)  NOT NULL,
    [kod_pocztowy] char(6)  NOT NULL,
    [miejscowosc] varchar(30)  NOT NULL
);
GO

-- Creating table 'sysdiagrams'
CREATE TABLE [dbo].[sysdiagrams] (
    [name] nvarchar(128)  NOT NULL,
    [principal_id] int  NOT NULL,
    [diagram_id] int IDENTITY(1,1) NOT NULL,
    [version] int  NULL,
    [definition] varbinary(max)  NULL
);
GO

-- Creating table 'Wizyty'
CREATE TABLE [dbo].[Wizyty] (
    [nr_wizyty] bigint IDENTITY(1,1) NOT NULL,
    [data_wizyty] datetime  NOT NULL,
    [pesel_pacjenta] char(11)  NOT NULL,
    [nr_lekarza] int  NOT NULL
);
GO

-- Creating table 'Choroby_wizyty'
CREATE TABLE [dbo].[Choroby_wizyty] (
    [nr_choroby] varchar(10)  NOT NULL,
    [nr_wizyty] bigint  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [nr_choroby] in table 'Choroby'
ALTER TABLE [dbo].[Choroby]
ADD CONSTRAINT [PK_Choroby]
    PRIMARY KEY CLUSTERED ([nr_choroby] ASC);
GO

-- Creating primary key on [nr_lekarza] in table 'Lekarze'
ALTER TABLE [dbo].[Lekarze]
ADD CONSTRAINT [PK_Lekarze]
    PRIMARY KEY CLUSTERED ([nr_lekarza] ASC);
GO

-- Creating primary key on [pesel_pacjenta] in table 'Pacjenci'
ALTER TABLE [dbo].[Pacjenci]
ADD CONSTRAINT [PK_Pacjenci]
    PRIMARY KEY CLUSTERED ([pesel_pacjenta] ASC);
GO

-- Creating primary key on [diagram_id] in table 'sysdiagrams'
ALTER TABLE [dbo].[sysdiagrams]
ADD CONSTRAINT [PK_sysdiagrams]
    PRIMARY KEY CLUSTERED ([diagram_id] ASC);
GO

-- Creating primary key on [nr_wizyty] in table 'Wizyty'
ALTER TABLE [dbo].[Wizyty]
ADD CONSTRAINT [PK_Wizyty]
    PRIMARY KEY CLUSTERED ([nr_wizyty] ASC);
GO

-- Creating primary key on [nr_choroby], [nr_wizyty] in table 'Choroby_wizyty'
ALTER TABLE [dbo].[Choroby_wizyty]
ADD CONSTRAINT [PK_Choroby_wizyty]
    PRIMARY KEY CLUSTERED ([nr_choroby], [nr_wizyty] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [nr_lekarza] in table 'Wizyty'
ALTER TABLE [dbo].[Wizyty]
ADD CONSTRAINT [FK_wizytalekarz]
    FOREIGN KEY ([nr_lekarza])
    REFERENCES [dbo].[Lekarze]
        ([nr_lekarza])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_wizytalekarz'
CREATE INDEX [IX_FK_wizytalekarz]
ON [dbo].[Wizyty]
    ([nr_lekarza]);
GO

-- Creating foreign key on [pesel_pacjenta] in table 'Wizyty'
ALTER TABLE [dbo].[Wizyty]
ADD CONSTRAINT [FK_wizytapacjent]
    FOREIGN KEY ([pesel_pacjenta])
    REFERENCES [dbo].[Pacjenci]
        ([pesel_pacjenta])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_wizytapacjent'
CREATE INDEX [IX_FK_wizytapacjent]
ON [dbo].[Wizyty]
    ([pesel_pacjenta]);
GO

-- Creating foreign key on [nr_choroby] in table 'Choroby_wizyty'
ALTER TABLE [dbo].[Choroby_wizyty]
ADD CONSTRAINT [FK_Choroby_wizyty_Choroby]
    FOREIGN KEY ([nr_choroby])
    REFERENCES [dbo].[Choroby]
        ([nr_choroby])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [nr_wizyty] in table 'Choroby_wizyty'
ALTER TABLE [dbo].[Choroby_wizyty]
ADD CONSTRAINT [FK_Choroby_wizyty_Wizyty]
    FOREIGN KEY ([nr_wizyty])
    REFERENCES [dbo].[Wizyty]
        ([nr_wizyty])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Choroby_wizyty_Wizyty'
CREATE INDEX [IX_FK_Choroby_wizyty_Wizyty]
ON [dbo].[Choroby_wizyty]
    ([nr_wizyty]);
GO

-- Uzupe³nienie tabeli 'Choroby'
INSERT INTO [dbo].[Choroby] ([nr_choroby], [opis_choroby])
VALUES ('CH001', 'Grypa'),
('CH002', 'Zapalenie gard³a'),
('CH003', 'Bóle g³owy');

-- Uzupe³nienie tabeli 'Lekarze'
INSERT INTO [dbo].[Lekarze] ([nr_lekarza], [imie_lekarza], [nazwisko_lekarza])
VALUES (1, 'Jan', 'Kowalski'),
(2, 'Anna', 'Nowak'),
(3, 'Piotr', 'Nowicki');

-- Uzupe³nienie tabeli 'Pacjenci'
INSERT INTO [dbo].[Pacjenci] ([pesel_pacjenta], [imie_pacjenta], [nazwisko_pacjenta], [ulica], [kod_pocztowy], [miejscowosc])
VALUES ('12345678901', 'Adam', 'Nowak', 'ul. Kwiatowa 1', '12-345', 'Warszawa'),
('98765432109', 'Ewa', 'Kowalska', 'ul. S³oneczna 2', '98-765', 'Kraków'),
('56789012345', 'Tomasz', 'Wójcik', 'ul. Ogrodowa 3', '56-789', 'Gdañsk');

-- Uzupe³nienie tabeli 'Wizyty'
INSERT INTO [dbo].[Wizyty] ([data_wizyty], [pesel_pacjenta], [nr_lekarza])
VALUES ('2023-06-30 10:00:00', '12345678901', 1),
('2023-07-01 14:30:00', '98765432109', 2),
('2023-07-02 09:15:00', '56789012345', 3);

-- Uzupe³nienie tabeli 'Choroby_wizyty'
INSERT INTO [dbo].[Choroby_wizyty] ([nr_choroby], [nr_wizyty])
VALUES ('CH001', 1),
('CH002', 2),
('CH003', 3);
-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------