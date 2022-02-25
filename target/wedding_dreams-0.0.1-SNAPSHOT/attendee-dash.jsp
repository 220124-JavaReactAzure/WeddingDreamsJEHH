<!DOCTYPE html>
<html>
    <head>
        <style>
        </style>

</head>   
<body>
    <%@ page import="com.revature.weddingDreams.util.WeddingNotFound,com.revature.weddingDreams.models.*,com.revature.weddingDreams.daos.*, com.revature.weddingDreams.services.*,java.time.LocalDate" %>
    <%  User authUser =  (User) session.getAttribute("authUser"); %> 
    <div>
		<form action="attendee-dash" method="post">
              
            <!-- Attendee Wedding Calendar-->
            <label id="wedding-date-label" for="wedding-date">Wedding Date:</label>
            <input type="date" id="calendar-month-year" name="wedding-date"
                <% String currentDateStr = LocalDate.now().getYear()+"-"+LocalDate.now().getMonth().getValue()+"-"+LocalDate.now().getDayOfMonth(); %>    
                value="<% out.print(currentDateStr); %>"
                min="<% out.print(currentDateStr); %>" max="2027-12-31" required>
        
        <%  if(request.getParameter("weddingNotFound") != null) { %>
                <h3> The date you selected has no wedding </h3>
        <%} %>
             
            <br />
			<label>Your Meal Choice</label>
            <input type="radio" name="attendee-meal" value="steak" required>
            <label for="attendee-meat">Steak</label>
            <input type="radio" name="attendee-meal" value="fish" required>
            <label for="attendee-fish">Fish</label>
            <input type="radio" name="attendee-meal" value="vegetarian" required>
            <label for="attendee-veggie">Vegetarian</label>

            

            <br /><br />			
                <label>Plus One?</label>
                <label for="plus-one-choice">Yes</label>
                <input type="radio" name="plus-one-choice"  value="Yes" >
                <label for="plus-one-choice">No</label>
                <input type="radio" name="plus-one-choice"  value="No" checked>   
            <br />
			
			<label>Plus One Meal Choice</label>       
			<input type="radio" name="plus-one-meal"  value="steak">
			<label for="plus-one-meat">Steak</label>
			<input type="radio" name="plus-one-meal"  value="fish">
			<label for="plus-one-fish">Fish</label>
			<input type="radio" name="plus-one-meal"  value="vegetarian">
			<label for="plus-one-veggie">Vegetarian</label>
			<br /><br />

        <%  if(authUser.getMealOptionsAttendee() == null) { %>
                <input type="submit" value="Submit Meal Choice"><br />
        <%  }    
            else { %>
                <input type="submit" value="Update Meal Choice"><br />
        <%  } %>
        </form>
        </div>
        <%  if(authUser.getWedding() != null) { %>
            <div>
                <!-- get wedding and venue info -->
            <%  String attendeeMealChoice = authUser.getMealOptionsAttendee();
                boolean attendeePlusOne = authUser.getPlusOne();
                String plusOneMealChoice = authUser.getMealOptionsPlusOne();
                
                BetrothedDAO betrothedDAO = new BetrothedDAO();
                EmployeeDAO employeeDAO = new EmployeeDAO();
                BetrothedService betrothedService = new BetrothedService(betrothedDAO);
                EmployeeService employeeService = new EmployeeService(employeeDAO);
                Wedding wedding = betrothedService.getWeddingByID(authUser.getWedding()); 
                Asset venue = employeeService.getAssetByID(wedding.getVenueID()) ; %>

                <p>You are attending a wedding on: <% out.print(wedding.getWeddingDate()); %></p>
                <p>The wedding venue is: <% out.print(venue.getCompanyName()); %></p>
                <o>Located at: <% out.print(venue.getAddress()); %></o>
                <p>Your Meal Choice is <% out.print(attendeeMealChoice); %></p>
                <%  if(attendeePlusOne == true) { %>
                        <p>Plus One Meal Choice is <% out.print(plusOneMealChoice); %></p>
                <%  } 
                    else { %>
                        <p>You did not invite a plus one</p>
                <% }    %>
                </div>
            
        <%  } %>

	</body>
</html>