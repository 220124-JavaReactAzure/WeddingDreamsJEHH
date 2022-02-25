package com.revature.weddingDreams.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.mock;

import org.junit.Before;
import org.junit.Test;

import com.revature.weddingDreams.daos.AttendeeDAO;
import com.revature.weddingDreams.models.User;
import com.revature.weddingDreams.services.AttendeeService;

public class AttendeeServiceTestSuite {
		
		AttendeeService sut;
		AttendeeDAO mockAttendeeDAO;	
		
		@Before
		public void testPrep() {
			mockAttendeeDAO = mock(AttendeeDAO.class);
			sut = new AttendeeService(mockAttendeeDAO);
		}

		@Test
		public void test_updateAttendeeMealChoice() {
			User user = new User();
			user.setUserType(2);
			user.setMealOptionsAttendee("fish");
			when(mockAttendeeDAO.updateAttendeeMealChoice(user)).thenReturn(true);
			boolean result  = sut.updateAttendeeMealChoice(user);
			assertTrue("Update the Attendee Meal choice succcessfully", true);
			assertFalse("Did not update the Attendee Meal choice succcessfully", false);
						
		}

		
}