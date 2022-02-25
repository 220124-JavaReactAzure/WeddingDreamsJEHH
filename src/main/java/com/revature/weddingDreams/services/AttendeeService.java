package com.revature.weddingDreams.services;

import java.util.logging.Logger;

import com.revature.weddingDreams.daos.AttendeeDAO;
import com.revature.weddingDreams.models.User;


public class AttendeeService {

	private final AttendeeDAO attendeeDAO;
	//private Logger WDlogger;
	
	public AttendeeService(AttendeeDAO attendeeDAO) {
		this.attendeeDAO = attendeeDAO;
		//this.WDlogger = Logger.getLogger("weddingLogger");
		//WDlogger.info("Successfully instantiated attendeeServie");
	}
	
	public boolean updateAttendeeMealChoice(User user) {
		//WDlogger.info("Called the method for updateAttendeeMealChoice for choice of: "+user.getMealOptionsAttendee());
		return attendeeDAO.updateAttendeeMealChoice(user);
	}
	
	
}
