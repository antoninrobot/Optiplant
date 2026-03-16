CREATE TABLE POWER_SUPPLY(
	id_supply INT AUTO_INCREMENT PRIMARY KEY,
	energy_produced INT
);

CREATE TABLE WEATHER_STATION(
	id_station INT AUTO_INCREMENT PRIMARY KEY,
	type_station VARCHAR(100),
	localisation VARCHAR(100),
	temperature INT,
	humidity INT,
	sunlight INT,
	atmospheric_pressure INT
);

CREATE TABLE USER_TABLE(
	id_user INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(30),
	email_address VARCHAR(100),
	password VARCHAR(255),
	role VARCHAR(30)
);

CREATE TABLE NUTRIENT(
	id_nutrient INT AUTO_INCREMENT PRIMARY KEY,
	nutrient_name VARCHAR(50),
	creation_date DATE
);

CREATE TABLE RECIPE(
	id_recipe INT AUTO_INCREMENT PRIMARY KEY,
	recipe_name VARCHAR(100),
	water_quantity INT,
	duration INT,
	creation_date DATE
);

CREATE TABLE PERCENTAGE(
	id_percentage INT AUTO_INCREMENT PRIMARY KEY,
	percentage INT,
	id_nutrient INT,
	id_recipe INT,
	creation_date DATE,
	FOREIGN KEY (id_nutrient) REFERENCES NUTRIENT(id_nutrient),
	FOREIGN KEY (id_recipe) REFERENCES RECIPE(id_recipe)
);

CREATE TABLE GROUP_TABLE(
	id_group INT AUTO_INCREMENT PRIMARY KEY,
	group_name VARCHAR(50),
	creation_date DATE
);

CREATE TABLE PLANT(
	id_plant INT AUTO_INCREMENT PRIMARY KEY,
	variety VARCHAR(50),
	germination_recipe INT,
	pousse_recipe INT,
	floraison_recipe INT,
	id_group INT,
	id_percentage INT,
	creation_date DATE,
	FOREIGN KEY (germination_recipe) REFERENCES RECIPE(id_recipe),
	FOREIGN KEY (pousse_recipe) REFERENCES RECIPE(id_recipe),
	FOREIGN KEY (floraison_recipe) REFERENCES RECIPE(id_recipe),
	FOREIGN KEY (id_group) REFERENCES GROUP_TABLE(id_group),
	FOREIGN KEY (id_percentage) REFERENCES PERCENTAGE(id_percentage)
);

CREATE TABLE PLANTER(
	id_planter INT AUTO_INCREMENT PRIMARY KEY,
	planter_name VARCHAR(50),
	id_plant INT,
	creation_date DATE,
	FOREIGN KEY (id_plant) REFERENCES PLANT(id_plant)
);

CREATE TABLE SENSOR(
	id_sensor INT AUTO_INCREMENT PRIMARY KEY,
	type_sensor VARCHAR(50),
	installation_date DATE,
	id_planter INT,
	FOREIGN KEY (id_planter) REFERENCES PLANTER(id_planter)
);

CREATE TABLE DATA(
	id_date INT AUTO_INCREMENT PRIMARY KEY,
	type_data VARCHAR(50),
	timestamp TIMESTAMP,
	value INT,
	id_sensor INT,
	FOREIGN KEY (id_sensor) REFERENCES SENSOR(id_sensor)
);

CREATE TABLE ALERT(
	id_alert INT AUTO_INCREMENT PRIMARY KEY,
	date DATE,
	type_alert VARCHAR(50),
	gravity INT,
	id_planter INT,
	FOREIGN KEY (id_planter) REFERENCES PLANTER(id_planter)
);

CREATE TABLE LOG(
	id_log INT AUTO_INCREMENT PRIMARY KEY,
	id_user INT,
	table_name VARCHAR(30),
	datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	modified_line INT,
	FOREIGN KEY (id_user) REFERENCES USER_TABLE(id_user)
);

