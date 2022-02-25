package com.revature.weddingDreams.daos;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.revature.weddingDreams.models.User;
import com.revature.weddingDreams.models.Wedding;
import com.revature.weddingDreams.util.HibernateUtil;


public class AttendeeDAO {
	
	// session method
	public boolean updateAttendeeMealChoice(User user) {
		try {
			Session session = HibernateUtil.getSession();
			session.beginTransaction();
			session.merge(user);
			session.getTransaction().commit();
			session.close();
			return true;
		} catch (HibernateException e) {
			e.printStackTrace();
			System.out.println("Unable to updateAttendeeMealChoice, HibernateException: "+e);
			return false;
		}
	}
	
	// doesn't appear to be used, but don't delete before presentations
	public Wedding getWeddingByID(String id) {
		try {
			Session session = HibernateUtil.getSession();
			session.beginTransaction();
			Wedding wedding = session.get(Wedding.class, id);
			session.getTransaction().commit();
			session.close();
			return wedding;
		}
		catch (HibernateException e) {
			e.printStackTrace();
			System.out.println("Could not retrieve wedding, HibernateException: "+e);
			return null;
		}
	 }
}
