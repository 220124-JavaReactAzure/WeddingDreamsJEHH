package com.revature.weddingDreams.util;

public class WeddingNotFound {

	private boolean notFound = false;
	
	public  WeddingNotFound(boolean notFound) {
		this.notFound = notFound;
	}
	
	public boolean getNotFound() {
		return notFound;
	}
	public void setNotFound(boolean notFound) {
		this.notFound = notFound;
	}
}
