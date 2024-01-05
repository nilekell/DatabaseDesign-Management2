CREATE SCHEMA IF NOT EXISTS db2_industries_schema;
USE db2_industries_schema;

CREATE TABLE IF NOT EXISTS Companies (
    COMPANY_RANK VARCHAR(255) PRIMARY KEY,
    COMPANY_NAME VARCHAR(255) NOT NULL,
    COUNTRY_TERRITORY VARCHAR(255),
    EMPLOYEES VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Industries (
    INDUSTRY_ID VARCHAR(255) PRIMARY KEY,
    INDUSTRY_NAME VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS CompanyIndustryConnections (
    COMPANY_RANK VARCHAR(255),
    INDUSTRY_ID VARCHAR(255),
    PRIMARY KEY (COMPANY_RANK, INDUSTRY_ID),
    FOREIGN KEY (COMPANY_RANK) REFERENCES Companies(COMPANY_RANK),
    FOREIGN KEY (INDUSTRY_ID) REFERENCES Industries(INDUSTRY_ID)
);

-- Inserting multiple industries at once
INSERT INTO Industries (INDUSTRY_ID, INDUSTRY_NAME) VALUES 
('1', 'Semiconductors'),
('2', 'Electronics'),
('3', 'Electrical Engineering'),
('4', 'Technology Hardware & Equipment'),
('5', 'IT'),
('6', 'Internet'),
('7', 'Software & Services');

-- Inserting multiple companies at once
INSERT INTO Companies (COMPANY_RANK, COMPANY_NAME, COUNTRY_TERRITORY, EMPLOYEES) VALUES 
('1', 'Samsung Electronics', 'South Korea', '266673'),
('2', 'Microsoft', 'United States of America', '221000'),
('3', 'IBM', 'United States of America', '250000'),
('4', 'Alphabet', 'United States of America', '156500'),
('5', 'Apple', 'United States of America', '154000');

-- Inserting multiple company-industry associations at once
INSERT INTO CompanyIndustryConnections (COMPANY_RANK, INDUSTRY_ID) VALUES 
('1', '1'), ('1', '2'), ('1', '3'), ('1', '4'),
('2', '5'), ('2', '6'), ('2', '7'),
('3', '1'), ('3', '2'), ('3', '3'), ('3', '4'),
('4', '5'), ('4', '6'), ('4', '7'),
('5', '1'), ('5', '2'), ('5', '3'), ('5', '4');

DELIMITER //

CREATE PROCEDURE VerifyCompaniesTable()
BEGIN
    -- Assuming we know the expected number of entries, for example, 5
    SELECT COUNT(*) INTO @companyCount FROM Companies;
    IF @companyCount = 5 THEN
        SELECT 'Verification passed: Correct number of entries in Companies.';
    ELSE
        SELECT 'Verification failed: Incorrect number of entries in Companies.';
    END IF;
END //

DELIMITER ;

CALL VerifyCompaniesTable();
