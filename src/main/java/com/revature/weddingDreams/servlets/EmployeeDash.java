package com.revature.weddingDreams.servlets;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.exc.StreamReadException;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.revature.weddingDreams.models.Asset;
import com.revature.weddingDreams.services.EmployeeService;

public class EmployeeDash extends HttpServlet {

	private final EmployeeService employeeService;
	private final ObjectMapper mapper;
	
	
	public EmployeeDash(EmployeeService es, ObjectMapper om) {
	  this.employeeService = es;
	  this.mapper = om; 
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher view = req.getRequestDispatcher("employee-dash.jsp");
		view.forward(req, resp);
	}
	@Override // Adds asset to data base
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// DELETE ASSET
		if(req.getParameter("Asset-to-delete") != null) { // need to get asset id from parameter and delete
			String assetToDeleteID = req.getParameter("Asset-to-delete");
			try {
				Asset deletedAsset = employeeService.deleteAssetByID(assetToDeleteID);				
				if(deletedAsset != null) {
					resp.setStatus(201);
				}
				else {
					resp.setStatus(500);
				}
			}
			catch (Exception e) { // IDE freaked out with the other excpetions
				resp.setStatus(500);
				e.printStackTrace();
			}	
		}
		else {
			String assetID = UUID.randomUUID().toString();
			Asset newAsset = new Asset(assetID, req.getParameter("name"), req.getParameter("address"), Double.parseDouble(req.getParameter("price")), Integer.parseInt(req.getParameter("type")));
			
			try {
				boolean res = employeeService.addAsset(newAsset);
				if(res) {
					resp.setStatus(201);
				}
				else {
					resp.setStatus(500);
				}
			}
			catch (Exception e) {
				resp.setStatus(500);
				e.printStackTrace();
			}
			/*catch (StreamReadException | DatabindException e) {
				resp.setStatus(400);
				e.printStackTrace();
			}*/
		}
		resp.sendRedirect("./employee-dash");
	}
}