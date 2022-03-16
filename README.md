# WEDDING DREAMS

## Project Description

Here goes your awesome project description!

## Technologies Used

* Tomcat - version 9.0.58
* Hibernate - version 2.0
* Java - version 1.8
* Mockito - 4.3.1
* JUnit - 4.13.2
* Git - 2.34.1
* Maven - version 3.8.4
* Azure SQL Databases
* Log4J - 2.17.1
* JSP - 2.0

## Features

List of features ready and TODOs for future development
* Users can create an Employee, Betrothed or Attendee account
* Employees can create, delete, and update wedding assets
* Bethrothed users can view/edit their wedding details, check availability of assets
* Attendees can add contact infomration, view venue information for the wedding they are attending, Confirm/Cancel a plus one, Select meal option for self and plus one 

To-do list:
* Add a CSS framework
* Add ability to hold more than one wedding on a single day

## Getting Started

Notes: 
* This project requires an IDE capable of Maven builds
* Apache-Tomcat Server
* Dbeaver or other database software

1. `git clone https://github.com/220124-JavaReactAzure/WeddingDreamsJEHH.git`

2. Run create_tables.sql to create database

3. In src/main/resources/hibernate.cfg.xml:

   Change CONNECTION_DRIVER, CONNECTION_USERNAME, CONNECTION_PASSWORD, CONNECTION_JDBD_URL, and NAME_DEFAULT_SCHEMA to reflect your database

	`<property name="hibernate.connection.driver_class">CONNECTION_DRIVER</property>
	 <property name="hibernate.connection.username">CONNECTION_USERNAME</property>
	 <property name="hibernate.connection.password">CONNECTION_PASSWORD</property> 
	 <property name="hibernate.connection.url">CONNECTION_JDBD_URL</property>
	 <property name="hibernate.default_schema">NAME_DEFAULT_SCHEMA</property>`

4. Start Apache-Tomcat server
	`apache-tomcat-[version]/bin/startup.bat`

5. Run project as Maven Build... in your IDE. 
   Enter `tomcat7:deploy` in the goals field
   Click "Run"

## Usage
1. Click Register User
2. Choose user type (Employee, Betrothed, Attendee)
3. You will be redirected to the appropriate user type dashboard

## Contributors
Joshua Evans
Hannah Hospital

## License
This project uses the following license: [<license_name>](<link>).
