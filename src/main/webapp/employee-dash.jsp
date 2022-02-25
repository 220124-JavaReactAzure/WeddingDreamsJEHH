<!DOCTYPE html>
<html>
   <head>
    <style>
        input.asset-display {
            position: absolute;
        }

    </style>

   </head>   
   <body>

        <form action="employee-dash" method="post">  

            <label for="name">Company Name</label>
            <input type="text" name="name" required>
            
            <label for="price">Price</label>
            <input type="text" name="price" required>
            
            <label for="address">Address</label>
            <input type="text" name="address" required>
            <br />
            
            <input type="radio" name="type" id="venue" value="1">
            <label for="venue">Venue</label>
            <input type="radio" name="type" id="caterer" value="2">
            <label for="caterer">Caterer</label>
            <input type="radio" name="type" id="florist" value="3">
            <label for="florist">Florist</label>
            <input type="radio" name="type" id="photographer" value="4">
            <label for="photographer">Photographer</label>
            <input type="radio" name="type" id="musician" value="5">
            <label for="musician">Musician</label>
            <br />
            <input type="submit" value="Create"><br />
        </form>
        <%@ page import="com.revature.weddingDreams.services.EmployeeService,com.revature.weddingDreams.daos.EmployeeDAO" %>
    
        <%  EmployeeDAO employeeDAO = new EmployeeDAO(); %>
        <%  EmployeeService employeeService = new EmployeeService(employeeDAO); %>
        <%  java.util.List<com.revature.weddingDreams.models.Asset> list = employeeService.getAllAssets(); %>
 
        <table>
        <%  for(int i=0; i < list.size(); i++) { %>
            <form action="employee-dash" method="post">  
                <input type="hidden" name="Asset-to-delete" value="<% out.print(list.get(i).getAssetID()); %>">
                <tr><td><p class="asset-display"><% out.print(list.get(i).getCompanyName()+" "+list.get(i).getPrice()+" "+list.get(i).getAssetTypeID()); %> </p></td>
                <td><input class="asset-display" type="submit" value="Delete"> </p></td></tr>
            </form>
        <% } %>
        </table>


   </body>
</html>

