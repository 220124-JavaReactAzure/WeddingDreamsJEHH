package com.revature.weddingDreams.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import com.revature.weddingDreams.daos.UserDAO;
import com.revature.weddingDreams.exceptions.AuthenticationException;
import com.revature.weddingDreams.exceptions.InvalidRequestException;
import com.revature.weddingDreams.models.User;
import com.revature.weddingDreams.models.Wedding;
import com.revature.weddingDreams.services.UserService;



public class UserServiceTestSuite {

	UserService sut;
	UserDAO mockUserDAO;
				
	@Before
	public void testPrep() {
		mockUserDAO = mock(UserDAO.class);
		sut = new UserService(mockUserDAO);
	}

	@Test
	public void test_addUser() {
		User user = new User();
		when(mockUserDAO.addUser(user)).thenReturn(true);
		boolean result = sut.addUser(user);
		assertTrue("Added the User succcessfully", true);
		assertFalse("Did not add the User succcessfully", false);

	}
	
	@Test
	public void test_updateUser() {
		User user = new User();
		when(mockUserDAO.updateUser(user)).thenReturn(true);
		boolean result = sut.updateUser(user);
		assertTrue("Updated the User succcessfully", true);
		assertFalse("Did not update the User succcessfully", false);
		
		
	}
	
	@Test
	public void test_deleteUser() {
		User user = new User();
		when(mockUserDAO.deleteUser(user)).thenReturn(true);
		boolean result = sut.deleteUser(user);
		assertTrue("Deleted the User succcessfully", true);
		assertFalse("Did not delete the User succcessfully", false);
	}
		

	
	@Test
	public void test_getAllUsers() {
		User user1 = new User();
		User user2 = new User();
		User user3 = new User();
		List<User> users;
		users = new ArrayList<>();
		users.add(user1);
		users.add(user2);
		users.add(user3);
		when(mockUserDAO.getAllUsers()).thenReturn(users);
		users = (ArrayList<User>)sut.getAllUsers();
		assertNotNull (users);
		assertFalse( users.isEmpty() );
	}
	
	@Test
	public void test_authenticateUser() {
		User user = new User();
		when(mockUserDAO.getUserByEmailandPassword("email","password")).thenReturn(user);
		sut.authenticateUser("email", "password");
		assertNotNull(user);
		
	}
		
}