create table if not exists user_types(
	user_type int,
	description varchar(40),
	primary key(user_type)
);

create table if not exists weddings (
	wedding_id varchar,
	wedding_date varchar,
	wedding_budget float,
	venue_id varchar,
	musician_id varchar,
	caterer_id varchar,
	florist_id varchar,
	photographer_id varchar,
	primary key(wedding_id)
);

create table if not exists users(
 	email varchar(255),
 	pass_word varchar(80),
 	user_type int,
	meal_options_attendee varchar,
	plus_one boolean,
	meal_options_plus_one varchar,
	wedding_id varchar,
 	primary key(email),
 	foreign key(user_type) references user_types(user_type),
	foreign key(wedding_id) references weddings(wedding_id)
 );

create table if not exists asset_types (
	asset_type_id int,
	asset_type varchar(40),
	primary key(asset_type_id)
);
create table if not exists assets(
	asset_id varchar,
	company_name varchar(40),
	address varchar,
	price float,
	asset_type_id int,
	primary key(asset_id),
	foreign key(asset_type_id) references asset_types(asset_type_id)
);

create table if not exists meal_options(
	meal_id int,
	meal_description varchar(40),
	primary key(meal_id)
);

insert into user_types values 
(1, 'employee'),
(2, 'attendee'),
(3, 'betrothed');

insert into meal_options values 
(1, 'steak'),
(2, 'fish'),
(3, 'veggie');

insert into asset_types values 
(1, 'venue'),
(2, 'caterer'),
(3, 'florist'),
(4, 'photographer'),
(5, 'musician');

