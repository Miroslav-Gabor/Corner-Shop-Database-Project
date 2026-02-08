
-- -----------------------------------------------------
-- Drop the 'cornerShop' database/schema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS cornerShop;


-- -----------------------------------------------------
-- Create 'cornerShop' database/schema and use this database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS cornerShop;

Use cornerShop;

-- -----------------------------------------------------
-- Create Tables
-- -----------------------------------------------------


-- Create table Category
CREATE TABLE IF NOT EXISTS CATEGORY
( categoryId int auto_increment,
categoryName varchar(60),
description  varchar(255),
PRIMARY KEY(categoryId)
);


-- Create table Product
CREATE TABLE IF NOT exists PRODUCT
(productId int auto_increment,
productName varchar(50),
price decimal(10,2),
quantity int(10),
categoryId int,
PRIMARY KEY(productId),
FOREIGN KEY (categoryId)
REFERENCES CATEGORY(categoryId)
ON UPDATE CASCADE ON DELETE SET NULL
);


-- Create table Supplier
CREATE TABLE IF NOT EXISTS SUPPLIER
(supplierId int auto_increment,
phoneNumber1 varchar(25),
phoneNumber2 varchar(25),
phoneNumber3 varchar(25),
email1 varchar(100),
email2 varchar(100),
email3 varchar (100),
street varchar(50),
town varchar(50),
county varchar(50) null,
country varchar(50),
supplierName varchar (100),
PRIMARY KEY(supplierId)
);

-- -----------------------------------------------------
-- Create table Shift
CREATE TABLE IF NOT EXISTS SHIFT
(shiftId int auto_increment,
startTime datetime,
endTime datetime,
notes varchar(255),
primary key(shiftId)
);



-- Create table Sale
CREATE TABLE IF NOT EXISTS SALE
(saleId int auto_increment,
saleTime datetime,
totalAmount decimal(10,2),
paymentMethod varchar(50),
shiftId int,
PRIMARY KEY(saleId),
CONSTRAINT FK_shiftId FOREIGN KEY(shiftId) 
REFERENCES SHIFT(shiftId) 
ON UPDATE CASCADE ON DELETE SET NULL
);



-- Create table Employee
CREATE TABLE IF NOT EXISTS EMPLOYEE
(employeeId int auto_increment,
firstName varchar(50),
lastName varchar(50),
street varchar(50),
town varchar(50),
county varchar(50),
eircode varchar(50),
phoneNumber1 varchar(25),
phoneNumber2 varchar(25),
email varchar(50),
hireDate datetime,
roleName varchar (50),
managerId int null,
primary key(employeeId),
CONSTRAINT FK_managerId FOREIGN KEY(managerId)
REFERENCES EMPLOYEE(employeeId) 
ON UPDATE CASCADE ON DELETE SET NULL
);



-- Create table Product_Sale
CREATE TABLE IF NOT EXISTS PRODUCT_SALE
(productId int,
saleId int,
quantity int,
price decimal(10,2),
PRIMARY KEY(productId,saleId),
foreign key (productId) REFERENCES Product(productId)
ON UPDATE CASCADE
ON DELETE CASCADE,
foreign key (saleId) References Sale(saleId)
ON UPDATE CASCADE
ON DELETE CASCADE
);



-- Create table Prod_Supplier
CREATE TABLE IF NOT EXISTS PROD_SUPPLIER
(productId int,
supplierId int,
PRIMARY KEY(productId,supplierId),
foreign key (productId) REFERENCES Product(productId),
foreign key (supplierId) References Supplier(supplierId)
ON UPDATE CASCADE
ON DELETE CASCADE
);



-- Create table Employee_Shift
CREATE TABLE IF NOT EXISTS EMPLOYEE_SHIFT
(employeeId int,
shiftId int,
PRIMARY KEY(employeeId,shiftId),
foreign key (employeeId) REFERENCES Employee(employeeId)
ON UPDATE CASCADE
ON DELETE CASCADE,
foreign key (shiftId) References Shift(shiftId)
ON UPDATE CASCADE
ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Inserts
-- -----------------------------------------------------

-- Category Inserts
INSERT INTO CATEGORY (categoryName, description) VALUES
('Dairy', 'Milk-based products'),
('Snacks', 'Biscuits, crisps, nuts'),
('Drinks', 'Beverages'),
('Bakery', 'Bread and pastries'),
('Frozen', 'Frozen foods'),
('Household', 'Cleaning and home supplies'),
('Personal Care', 'Hygiene products'),
('Fruit', 'Fresh fruits'),
('Vegetables', 'Fresh vegetables'),
('Canned Goods', 'Canned goods'),
('Sauces', 'Cooking sauces and condiments'),
('Meat', 'Fresh meats'),
('Seafood', 'Fish and seafood'),
('Cereal', 'Breakfast cereals'),
('Confectionery', 'Sweets and chocolate'),
('Electronics', 'Small electronic items'),
('Stationery', 'Office supplies'),
('Baby Products', 'Infant items'),
('Pets', 'Pet food and accessories'),
('Miscellaneous', 'Other products');

-- Product Inserts
INSERT INTO PRODUCT (productName, price, quantity, categoryId) VALUES
('Whole Milk 1L', 2.20, 50, 1),
('Cheddar Cheese', 2.50, 30, 1),
('Salted Crisps', 1.30, 80, 2),
('Chocolate Bar', 1.20, 100, 15),
('Orange Juice', 1.80, 40, 3),
('White Bread', 1.80, 25, 4),
('Frozen Pizza', 3.50, 20, 5),
('Shampoo', 4.00, 18, 7),
('Bananas (1kg)', 2.10, 35, 8),
('Carrots (1kg)', 2.90, 45, 9),
('Canned Beans', 1.20, 60, 10),
('Tomato Sauce', 2.30, 55, 11),
('Chicken Breast', 5.00, 22, 12),
('Salmon Fillet', 6.50, 15, 13),
('Corn Flakes', 2.00, 28, 14),
('Dog Food 2kg', 6.00, 10, 19),
('Hand Soap', 1.80, 33, 7),
('Blue Pen', 0.99, 120, 17),
('Baby Wipes', 2.40, 25, 18),
('AA Batteries (4 pack)', 3.00, 14, 16);


-- Supplier Inserts
INSERT INTO SUPPLIER (phoneNumber1, phoneNumber2, phoneNumber3,
email1, email2, email3,
street, town, county, country, supplierName) VALUES
('0871111111', '015555111', '015555112', 'info@freshdairy.ie', 'sales@freshdairy.ie', 'support@freshdairy.ie', '12 Milk Lane', 'Dublin', 'Dublin', 'Ireland', 'Fresh Dairy Ltd'),
('0872222222', '016666222', '016666223', 'contact@snackhouse.ie', 'orders@snackhouse.ie', 'help@snackhouse.ie', '45 Crisp Road', 'Cork', 'Cork', 'Ireland', 'Snack House Supplies'),
('0873333333', '017777333', '017777334', 'sales@drinkmaster.ie', 'info@drinkmaster.ie', 'support@drinkmaster.ie', '8 Orange St', 'Limerick', 'Limerick', 'Ireland', 'DrinkMaster Distributors'),
('0874444444', '018888444', '018888445', 'hello@bakersdelight.ie', 'orders@bakersdelight.ie', 'support@bakersdelight.ie', '23 Bread Ave', 'Galway', 'Galway', 'Ireland', 'Bakers Delight'),
('0875555555', '019999555', '019999556', 'info@frozenfoods.ie', 'sales@frozenfoods.ie', 'support@frozenfoods.ie', '76 Frost Park', 'Waterford', 'Waterford', 'Ireland', 'Frozen Foods Ireland'),
('0876666666', '014444666', '014444667', 'support@cleanhome.ie', 'contact@cleanhome.ie', 'help@cleanhome.ie', '9 Shine St', 'Kilkenny', 'Kilkenny', 'Ireland', 'CleanHome Suppliers'),
('0877777777', '015555777', '015555778', 'service@careproducts.ie', 'info@careproducts.ie', 'support@careproducts.ie', '51 Wellness Rd', 'Sligo', 'Sligo', 'Ireland', 'Care Products Co'),
('0878888888', '016666888', '016666889', 'sales@fruitland.ie', 'contact@fruitland.ie', 'support@fruitland.ie', '88 Orchard Blvd', 'Dublin', 'Dublin', 'Ireland', 'Fruitland Imports'),
('0879999999', '017777999', '017777998', 'contact@vegiefarm.ie', 'orders@vegiefarm.ie', 'support@vegiefarm.ie', '34 Green Lane', 'Wexford', 'Wexford', 'Ireland', 'VegieFarm Supplies'),
('0861111111', '018888111', '018888112', 'info@cannedgoods.ie', 'sales@cannedgoods.ie', 'support@cannedgoods.ie', '120 Metal St', 'Dundalk', 'Louth', 'Ireland', 'Canned Goods Wholesale'),
('0862222222', '019999222', '019999223', 'sales@saucemarket.ie', 'info@saucemarket.ie', 'help@saucemarket.ie', '3 Spice Road', 'Tralee', 'Kerry', 'Ireland', 'Sauce Market Ltd'),
('0863333333', '014444333', '014444334', 'support@meatdirect.ie', 'orders@meatdirect.ie', 'info@meatdirect.ie', '5 Farm View', 'Navan', 'Meath', 'Ireland', 'Meat Direct'),
('0864444444', '015555444', '015555445', 'info@oceansea.ie', 'contact@oceansea.ie', 'support@oceansea.ie', '47 Coast Way', 'Bray', 'Wicklow', 'Ireland', 'OceanSea Foods'),
('0865555555', '016666555', '016666556', 'contact@breakfastco.ie', 'info@breakfastco.ie', 'sales@breakfastco.ie', '16 Morning St', 'Athlone', 'Westmeath', 'Ireland', 'Breakfast Co'),
('0866666666', '017777666', '017777667', 'support@candyworld.ie', 'info@candyworld.ie', 'orders@candyworld.ie', '88 Sugar Park', 'Dublin', 'Dublin', 'Ireland', 'CandyWorld'),
('0867777777', '018888777', '018888778', 'info@techmini.ie', 'support@techmini.ie', 'sales@techmini.ie', '6 Circuit Lane', 'Galway', 'Galway', 'Ireland', 'TechMini Electronics'),
('0868888888', '019999888', '019999889', 'hello@stationeryhub.ie', 'contact@stationeryhub.ie', 'support@stationeryhub.ie', '11 Paper St', 'Cork', 'Cork', 'Ireland', 'Stationery Hub'),
('0869999999', '014444999', '014444998', 'sales@babycare.ie', 'info@babycare.ie', 'support@babycare.ie', '2 Cradle Road', 'Limerick', 'Limerick', 'Ireland', 'BabyCare Wholesale'),
('0851111111', '015555112', '015555113', 'contact@petfoods.ie', 'info@petfoods.ie', 'support@petfoods.ie', '33 Paw Avenue', 'Sligo', 'Sligo', 'Ireland', 'PetFoods & Co'),
('0852222222', '016666223', '016666224', 'info@miscworld.ie', 'sales@miscworld.ie', 'support@miscworld.ie', '77 Market Lane', 'Dublin', 'Dublin', 'Ireland', 'MiscWorld Suppliers');


-- Shift Inserts
INSERT INTO SHIFT (startTime, endTime, notes) VALUES
('2025-01-01 08:00:00', '2025-01-01 14:00:00', 'Morning shift'),
('2025-01-01 14:00:00', '2025-01-01 20:00:00', 'Evening shift'),
('2025-01-02 08:00:00', '2025-01-02 14:00:00', 'Morning shift'),
('2025-01-02 14:00:00', '2025-01-02 20:00:00', 'Evening shift'),
('2025-01-03 09:00:00', '2025-01-03 15:00:00', 'Mid shift'),
('2025-01-03 15:00:00', '2025-01-03 21:00:00', 'Closing shift'),
('2025-01-04 07:30:00', '2025-01-04 13:30:00', 'Stock shift'),
('2025-01-04 13:30:00', '2025-01-04 19:30:00', 'Sales floor shift'),
('2025-01-05 08:00:00', '2025-01-05 14:00:00', 'Weekend shift AM'),
('2025-01-05 14:00:00', '2025-01-05 20:00:00', 'Weekend shift PM'),
('2025-01-06 08:00:00', '2025-01-06 16:00:00', 'Full day shift'),
('2025-01-06 16:00:00', '2025-01-06 22:00:00', 'Closing shift'),
('2025-01-07 09:00:00', '2025-01-07 15:00:00', 'Regular shift'),
('2025-01-07 15:00:00', '2025-01-07 21:00:00', 'Evening staff'),
('2025-01-08 08:00:00', '2025-01-08 14:00:00', 'Morning shift'),
('2025-01-08 14:00:00', '2025-01-08 20:00:00', 'Evening shift'),
('2025-01-09 07:00:00', '2025-01-09 13:00:00', 'Early shift'),
('2025-01-09 13:00:00', '2025-01-09 19:00:00', 'Afternoon shift'),
('2025-01-10 08:30:00', '2025-01-10 14:30:00', 'Morning shift'),
('2025-01-10 14:30:00', '2025-01-10 20:30:00', 'Evening shift');

-- Sale Inserts
INSERT INTO SALE (saleTime, totalAmount, paymentMethod, shiftId) VALUES
('2025-01-01 09:15:00', 12.50, 'Card', 1),
('2025-01-01 10:42:00', 5.80,  'Cash', 1),
('2025-01-02 13:05:00', 18.20, 'Card', 2),
('2025-01-02 16:33:00', 7.40,  'Card', 2),
('2025-01-03 00:15:00', 3.00,  'Cash', 3),   
('2025-01-03 00:45:00', 9.20,  'Card', 3),   
('2025-01-03 11:10:00', 22.00, 'Cash', 3),
('2025-01-04 08:30:00', 14.90, 'Card', 4),
('2025-01-04 12:45:00', 19.99, 'Card', 4),
('2025-01-05 15:12:00', 6.75,  'Cash', 5),
('2025-01-05 17:20:00', 4.50,  'Card', 5),
('2025-01-06 09:05:00', 8.80,  'Card', 6),
('2025-01-06 09:40:00', 11.60, 'Cash', 6),
('2025-01-07 13:55:00', 16.20, 'Card', 7),
('2025-01-08 14:25:00', 21.00, 'Card', 8),
('2025-01-09 18:10:00', 5.10,  'Cash', 9),
('2025-01-10 19:45:00', 10.25, 'Card', 10),
('2025-01-11 20:05:00', 13.70, 'Cash', 11),
('2025-01-12 08:20:00', 7.80,  'Card', 12),
('2025-01-12 11:55:00', 18.60, 'Card', 12);


-- Empliyee Inserts
INSERT INTO EMPLOYEE 
(firstName, lastName, street, town, county, eircode, phoneNumber1, phoneNumber2,
 email, hireDate, roleName, managerId)
VALUES
('John', 'Bennett', 'Oak Street 12', 'Dublin', 'Dublin', 'D12 AB45', '0891111111', '0871111111', 'john.bennett@cs.com', '2020-01-10 09:00:00', 'Store Manager', NULL),
('Sarah', 'Kavanagh', 'Pine Road 44', 'Dublin', 'Dublin', 'D08 XY91', '0892222222', '0872222222', 'sarah.kavanagh@cs.com', '2021-03-15 09:00:00', 'Assistant Manager', 1),
('Michael', 'Daly', 'River Lane 5', 'Dublin', 'Dublin', 'D11 FF09', '0893333333', '0873333333', 'michael.daly@cs.com', '2022-04-01 09:00:00', 'Cashier', 2),
('Emily', 'Walsh', 'Green Park 19', 'Dublin', 'Dublin', 'D10 CD12', '0894444444', '0874444444', 'emily.walsh@cs.com', '2022-04-02 09:00:00', 'Cashier', 2),
('Daniel', 'Reid', 'Elm Street 8', 'Dublin', 'Dublin', 'D07 TT09', '0895555555', '0875555555', 'daniel.reid@cs.com', '2022-04-03 09:00:00', 'Cashier', 2),
('Hannah', 'Flynn', 'Lake Drive 33', 'Dublin', 'Dublin', 'D05 LK22', '0896666666', '0876666666', 'hannah.flynn@cs.com', '2023-02-10 09:00:00', 'Shelf Stocker', 2),
('Patrick', 'Burke', 'Willow Way 10', 'Dublin', 'Dublin', 'D09 HT33', '0897777777', '0877777777', 'patrick.burke@cs.com', '2023-02-15 09:00:00', 'Shelf Stocker', 2),
('Emma', 'Gallagher', 'Ash Grove 17', 'Dublin', 'Dublin', 'D04 WD55', '0898888888', '0878888888', 'emma.gallagher@cs.com', '2023-03-01 09:00:00', 'Cleaner', 1),
('Robert', 'Lynch', 'Hill View 4', 'Dublin', 'Dublin', 'D02 YT66', '0899999999', '0879999999', 'robert.lynch@cs.com', '2023-03-10 09:00:00', 'Cleaner', 1),
('Sophie', 'Dunne', 'Cedar Road 9', 'Dublin', 'Dublin', 'D16 CD77', '0861111111', '0831111111', 'sophie.dunne@cs.com', '2023-05-01 09:00:00', 'Stock Manager', 1),
('Mark', 'Keane', 'Forest Park 6', 'Dublin', 'Dublin', 'D15 TR10', '0862222222', '0832222222', 'mark.keane@cs.com', '2023-05-12 09:00:00', 'Delivery Driver', 10),
('Chloe', 'Murray', 'Ivy Close 88', 'Dublin', 'Dublin', 'D03 RU90', '0863333333', '0833333333', 'chloe.murray@cs.com', '2023-05-14 09:00:00', 'Delivery Driver', 10),
('Adam', 'Nolan', 'Station Road 2', 'Dublin', 'Dublin', 'D14 WV12', '0864444444', '0834444444', 'adam.nolan@cs.com', '2023-06-01 09:00:00', 'Security', 1),
('Lucy', 'Healy', 'Maple Court 21', 'Dublin', 'Dublin', 'D06 YR19', '0865555555', '0835555555', 'lucy.healy@cs.com', '2023-06-10 09:00:00', 'Security', 1),
('Brendan', 'Smyth', 'Hilltop 5', 'Dublin', 'Dublin', 'D13 ER88', '0866666666', '0836666666', 'brendan.smyth@cs.com', '2023-07-01 09:00:00', 'Stock Assistant', 10),
('Laura', 'Byrne', 'Rosewood 14', 'Dublin', 'Dublin', 'D18 YU55', '0867777777', '0837777777', 'laura.byrne@cs.com', '2023-07-02 09:00:00', 'Stock Assistant', 10),
('Ethan', 'Carroll', 'Mill Road 3', 'Dublin', 'Dublin', 'D19 HE21', '0868888888', '0838888888', 'ethan.carroll@cs.com', '2023-07-03 09:00:00', 'Stock Assistant', 10),
('Grace', 'Farrell', 'Beech Lane 27', 'Dublin', 'Dublin', 'D20 LO44', '0869999999', '0839999999', 'grace.farrell@cs.com', '2023-07-20 09:00:00', 'HR Assistant', 1),
('Shane', 'Fitzgerald', 'Valley Road 11', 'Dublin', 'Dublin', 'D21 XP71', '0851111111', '0831111122', 'shane.fitzgerald@cs.com', '2023-08-01 09:00:00', 'IT Support', 1);


-- Product_Sale Inserts
INSERT INTO PRODUCT_SALE (productId, saleId, quantity, price) VALUES
(1, 1, 2, 2.20),
(3, 1, 1, 1.30),
(4, 2, 3, 1.20),
(5, 2, 1, 1.80),
(2, 3, 2, 2.50),
(7, 3, 1, 3.50),
(10, 4, 2, 2.90),
(11, 4, 1, 1.20),
(6, 5, 1, 1.80),
(8, 5, 1, 4.00),
(12, 6, 2, 2.30),
(14, 6, 1, 6.50),
(9, 7, 1, 2.10),
(19, 7, 2, 2.40),
(15, 8, 1, 2.00),
(18, 8, 3, 0.99),
(13, 9, 1, 5.00),
(20, 9, 1, 3.00),
(16, 10, 1, 6.00),
(17, 10, 2, 1.80);


-- Prod_Supplier Inserts
INSERT INTO PROD_SUPPLIER (productId, supplierId) VALUES
(1, 3),
(2, 5),
(3, 2),
(4, 8),
(5, 1),
(6, 10),
(7, 7),
(8, 6),
(9, 4),
(10, 11),
(11, 12),
(12, 9),
(13, 14),
(14, 13),
(15, 16),
(16, 18),
(17, 20),
(18, 15),
(19, 17),
(20, 19);


-- Employee_Shift Inserts
INSERT INTO EMPLOYEE_SHIFT (employeeId, shiftId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(1, 20);



