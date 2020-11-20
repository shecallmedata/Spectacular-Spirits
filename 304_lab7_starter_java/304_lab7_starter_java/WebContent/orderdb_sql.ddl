DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Vodka');
INSERT INTO category(categoryName) VALUES ('Gin');
INSERT INTO category(categoryName) VALUES ('Tequila');
INSERT INTO category(categoryName) VALUES ('Whiskey');
INSERT INTO category(categoryName) VALUES ('Clothing');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Victory Vodka', 1, '375ml Bottle',17.49);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Victory Vodka',1,'750ml Bottle',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lights-out Reposado',3,'750ml Bottle',36.01);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Meterorite Mezcal',3,'375ml Bottle',20.98);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grey Duck',1,'750ml Bottle',68.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Wicked Whiskey',4,'750ml Bottle',34.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Okanagan Pine',2,'375ml Bottle',17.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Okanagan Pine',2,'750ml Bottle',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SS Pullover',5,'Pullover Hoodie',64.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SS Tee',5,'Standard Unisex Tshirt',27.30);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sciarpelletti Añejo',3,'750ml Bottle',50.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Big Dog Whiskey',4,'375ml Bottle',22.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ogopogo Burn',4,'750ml Bottle',35.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sasquatch Stomp',2,'750ml Bottle',40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SS Toque',5,'Unisex Toque',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Rough N Tumble Rye',4,'375ml Bottle',14.49);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Black Bear Bourbon',4,'750ml Bottle',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SS Snpackback',5,'Unisex Hat',22.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sir Dano Special',1,'750ml Bottle',99.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SS Zip-up',5,'Unisex Zip-up Hoodie',48.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Evergreens Touch',2,'750ml Bottle',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ponderosa Punch',4,'1.14L',88.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Minecart Mezcal',3,'750ml Bottle',55.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hard-Times',4,'1.67L Bottle',129.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('SS Sweatpant',5,'Unisex Sweatpant',38.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Diroc',1,'750ml Bottle',50.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Leviathan',4,'1.14L',66.49);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Laughing Cat',2,'750ml Bottle',42.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Just-in-Time Juice',3,'375ml Bottle',32.00);
    
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');


DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);