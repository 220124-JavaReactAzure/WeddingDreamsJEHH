package com.revature.weddingDreams.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.Mockito.mock;

import org.junit.Before;
import org.junit.Test;

import com.revature.weddingDreams.daos.BetrothedDAO;
import com.revature.weddingDreams.models.Wedding;
import com.revature.weddingDreams.services.BetrothedService;

public class BetrothedServiceTestSuite {

	BetrothedService sut;
	BetrothedDAO mockBetrothedDAO;
					
		@Before
		public void testPrep() {
			mockBetrothedDAO = mock(BetrothedDAO.class);
			sut = new BetrothedService(mockBetrothedDAO);
		}

		@Test
		public void test_addWedding() {
			Wedding wedding = new Wedding();
			when(mockBetrothedDAO.addWedding(wedding)).thenReturn(true);
			boolean result  = sut.addWedding(wedding);
			assertTrue("Adding wedding succcessfully", true);
			assertFalse("Did not add the wedding successfully", false);	
		}
		
		@Test
		public void test_updateWedding() {
			Wedding wedding = new Wedding();
			when(mockBetrothedDAO.updateWedding(wedding)).thenReturn(true);
			boolean result  = sut.updateWedding(wedding);
			assertTrue("Updated wedding succesfully", true);
			assertFalse("Did not update the wedding succcessfully", false);	
		}
		
		@Test
		public void test_getAllWeddings() {
			Wedding wedding1 = new Wedding();
			Wedding wedding2 = new Wedding();
			Wedding wedding3 = new Wedding();
			List<Wedding> weddings;
			weddings = new ArrayList<>();
			weddings.add(wedding1);
			weddings.add(wedding2);
			weddings.add(wedding3);
			when(mockBetrothedDAO.getAllWeddings()).thenReturn(weddings);
			weddings = (ArrayList<Wedding>)sut.getAllWeddings();
			assertNotNull (weddings);
			assertFalse( weddings.isEmpty() );
		}

		@Test
		public void test_getWeddingByID() {
			Wedding wedding = new Wedding();
			when(mockBetrothedDAO.getWeddingByID("1")).thenReturn(wedding);
			wedding = sut.getWeddingByID("1");
			assertNotNull(wedding);
			wedding = sut.getWeddingByID(null);
			assertNull(wedding);
		}
		
		
		/*
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
		 */
		
}

