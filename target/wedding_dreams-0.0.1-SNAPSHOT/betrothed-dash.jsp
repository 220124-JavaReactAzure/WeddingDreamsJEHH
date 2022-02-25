<!DOCTYPE html>
<html>
<head>    
    <style>
    p {
        font-size: 10px;
    }
    table {
        table-layout: fixed;
        font-family: arial, sans-serif;
        border-collapse: collapse;
        width: 100%;}
    td, th {
        border: 1px solid #dddddd;
        text-align: left;
        
        height:20px;
        padding: 8px;}
    </style>
</head>   
<body>
    <%@ page import="java.util.*,java.time.LocalDate,com.revature.weddingDreams.services.*,com.revature.weddingDreams.daos.*,com.revature.weddingDreams.models.*" %>
  

  <%!  public String getNumberAssetTypesAvailable(List<Asset> list) {
        int[] counts = new int[5];
        for(int i =0; i < list.size(); i++) {
            counts[list.get(i).getAssetTypeID()-1] += 1;
        }
        
        String returnStr = "<p>"+String.valueOf(counts[0])+" venues available</p>" +
                        "<p>"+String.valueOf(counts[1])+" caterers available</p>" +
                        "<p>"+String.valueOf(counts[2])+" florists available</p>" +
                        "<p>"+String.valueOf(counts[3])+" photographers available</p>" +
                        "<p>"+String.valueOf(counts[4])+" musicians available</p>";			
        //return returnStr;

        return "";
    } %>

    
<!-- If user hasn't created a wedding, or chosen a date, create calendar -->
    <%  User authUser =  (User) session.getAttribute("authUser"); %>
    <%  if( authUser.getWedding() == null && request.getParameter("day") == null) {    // user needs to create wedding, load create wedding form		
            
            // figure out why we have to keep calling now() and .parse(dateStr)()

            LocalDate localDate = LocalDate.now();
            String monthYearStr = "";
            int year = -1, month = -1 , lengthOfMonth = -1, firstOfMonthDay = -1, currentDay = -1;

            if( request.getParameter("start") == null) { // use current date info
                monthYearStr = LocalDate.now().getYear()+"-"+LocalDate.now().getMonth().getValue();

                year = localDate.now().getYear();
                month = localDate.now().getMonthValue();
                lengthOfMonth = localDate.now().lengthOfMonth();

                firstOfMonthDay = LocalDate.now().withDayOfMonth(1).getDayOfWeek().getValue();
                currentDay = localDate.now().getDayOfMonth(); 
            }            
            else { // user has selected a different month and/or year
                String[] splitYearMonth = request.getParameter("start").split("-");
                String yearStr = splitYearMonth[0];
                String monthStr = splitYearMonth[1];
                if(Integer.parseInt(monthStr) < 10) { // add a zero in front of month string
                    monthStr = "0"+monthStr;
                }
                String dateStr = yearStr+"-"+monthStr+"-01";  
                
                localDate = LocalDate.parse(dateStr);

                monthYearStr = LocalDate.parse(dateStr).getYear()+"-"+LocalDate.parse(dateStr).getMonth().getValue();

                year = localDate.parse(dateStr).getYear();
                month = localDate.parse(dateStr).getMonthValue();
                lengthOfMonth = localDate.parse(dateStr).lengthOfMonth();

                firstOfMonthDay = LocalDate.parse(dateStr).withDayOfMonth(1).getDayOfWeek().getValue();
                currentDay = -1; // can't get current day for month in the future
            }
            
            %>
           
            <h1><% out.print(localDate.getMonth()); %></h1>                 

            <!-- Change calender month/year picker -->
            <form>
                <label for="start">Start month:</label>
                <input type="month" id="start" name="start"
                min="<% out.print(monthYearStr); %>" value="<% out.print(monthYearStr); %>">
                <input type="submit" value="Change Month/Year">
            </form>

            <table>
                <tr><th>Sun  </th><th>Mon  </th><th>Tues </th><th>Wed  </th><th>Thurs</th><th>Fri  </th><th>Sat  </th></tr>
                <tr>
            <!-- Get weding assets to populate calendar -->
        <%      EmployeeDAO employeeDAO = new EmployeeDAO(); %>
        <%      EmployeeService employeeService = new EmployeeService(employeeDAO); %>
        <%      java.util.List<com.revature.weddingDreams.models.Asset> list = employeeService.getAllAssets(); %>

            <!-- Get wedding objects to check for taken days -->
        <%      BetrothedDAO betrothedDAO = new BetrothedDAO(); %>
        <%      BetrothedService betrothedService = new BetrothedService(betrothedDAO); %>
        <%      java.util.List<Wedding> weddingList = betrothedService.getAllWeddings(); %>

            <!-- create list of dates aleady taken FROM THIS MONTH AND YEAR ONLY-->
           <%   List<Integer> takenDays = new ArrayList<>(); 
                for(Wedding wedding:weddingList) {
                    String date = wedding.getWeddingDate();
                    // year-month-day
                    String[] yearMonthDayDate = date.split("-"); 
                    yearMonthDayDate[0] = yearMonthDayDate[0].trim();
                    yearMonthDayDate[1] = yearMonthDayDate[1].trim();
                    yearMonthDayDate[2] = yearMonthDayDate[2].trim(); 
                    if(yearMonthDayDate[0].equals(String.valueOf(year)) && yearMonthDayDate[1].equals(String.valueOf(month))) {
                        
                        // cast day as Int and add to list takenDays
                        takenDays.add(Integer.parseInt(yearMonthDayDate[2]));
                    }
                }  %>


            <!-- Create the days of the month for the calendar -->
            <!-- create to first day -->
           <% if(firstOfMonthDay == 7) { // sunday = 6, change to 1
                firstOfMonthDay = 1;
            }
            else {
                firstOfMonthDay += 1;
            } %>


    <%      int dayOfWeekCount = 1;  
            while(dayOfWeekCount <= firstOfMonthDay) {
                boolean dateTaken = false;
                for(int day:takenDays) {
                    if(1 == day)
                        dateTaken = true;
                }
                
                if(dayOfWeekCount < firstOfMonthDay) { %>
                    <td>  </td>
        <%      }
                else if(dateTaken && dayOfWeekCount == firstOfMonthDay) { %> 
                    <td><p>1</p> <p>This date for the wedding is already reserved.</p></td>                    
        <%                  
               }  
                else { %>
                    <td><p>1</p> <% out.println(getNumberAssetTypesAvailable(list)); %><a href="betrothed-dash?day=1&month=<%out.print(month);%>&year=<%out.print(year);%>">Select this day</a></td>
        <%           
                }

                ++dayOfWeekCount; 
            } %>
                
            <!-- create rest of month -->
            <%   
            for(int i = 2; i <= lengthOfMonth; i++) { 
                boolean dateTaken = false;
                for(int day:takenDays) {
                    if(i == day)
                        dateTaken = true;
                }
                
                if(dateTaken) { %>
                    <td><p><% out.print(i); %></p><p> This date for the wedding is already reserved.</p></td>
            <%      }
                else { %>
                <td><p><% out.print(i); out.println(getNumberAssetTypesAvailable(list)); %></p><a href="betrothed-dash?day=<%out.print(i);%>&month=<%out.print(month);%>&year=<%out.print(year);%>">Select this day</a></td>
            <%      }

                if(dayOfWeekCount == 7) { %>
                    </tr><tr>
            <%            dayOfWeekCount = 0;
                }  
                dayOfWeekCount++;
            } %>

       
            </tr>
        </table>
    <%  } 
    
      else  { %>
<!--  Wedding has been created, show wedding-edit form -->
    <%      EmployeeDAO employeeDAO = new EmployeeDAO();
            EmployeeService employeeService = new EmployeeService(employeeDAO);
            BetrothedDAO betrothedDAO = new BetrothedDAO();
            BetrothedService betrothedService = new BetrothedService(betrothedDAO);

	        List<Asset> assetList = employeeService.getAllAssets(); 
			List<AssetType> assetTypesList = employeeService.getAssetTypes();
        
            Wedding wedding = new Wedding();
            boolean weddingExists = false;
            double venuePrice = 0, catererPrice = 0, floristPrice = 0, photographerPrice = 0, musicianPrice = 0;
            if(authUser.getWedding() != null) { 
                weddingExists = true;
                wedding = betrothedService.getWeddingByID(authUser.getWedding());
            } %>
            
            <form action="betrothed-dash" method="post">
                <table>
                    <tr>
                        <th>Your Wedding Selections</th>                        
                        <th><p>month:<% out.print(request.getParameter("month")); %></p><p>day:<% out.print(request.getParameter("day")); %></p><p>year:<% out.print(request.getParameter("year")); %> </p></th> 
                        <th>Change selections</th><th></th>
                    </tr>
                        <%  Asset chosenAsset = new Asset(); %>


<!-- VENUE -->
                <%  String assetTypeName = assetTypesList.get(0).getAssetType(); 
                    int assetTypeID = assetTypesList.get(0).getAssetTypeID();    %>    
                    <tr> 
                        <!-- wedding data-->
                <%      if(weddingExists) {
                            chosenAsset = employeeService.getAssetByID(wedding.getVenueID());%>
                            <td><p><%out.print(chosenAsset.getCompanyName());%></p></td>
                            <% venuePrice = chosenAsset.getPrice(); %>
                            <td><p><%out.print("$"+(venuePrice));%></p></td>
                <%          }   
                            else { %>
                                <td><p> No Venue Selected</p></td>
                                <td></td>
                <%          } %>                            
                        <td> <!-- wedding selector -->
                            <label for="<% out.print(assetTypeName); %>">Select a <% out.print(assetTypeName); %></label>
                        </td>
                        <td>
                            <select name="<% out.print(assetTypeName); %>">
                <%          for(int j =0; j < assetList.size(); j++) {
                                Asset asset = assetList.get(j);
                                if(asset.getAssetTypeID() == assetTypeID) {
                                    double price = asset.getPrice(); %>
                                    <option value="<% out.print(asset.getAssetID()); %>"><% out.print(asset.getCompanyName());%>  $<%out.print(price);%></option>
                <%              } 
                            }    %>
                                
                                <option value="null">None</option>
                            </select>
                        </td>
                    </tr>

<!-- CATERER -->
                <%  assetTypeName = assetTypesList.get(1).getAssetType(); 
                    assetTypeID = assetTypesList.get(1).getAssetTypeID();    %>    
                    <tr> 
                        <!-- wedding data-->
                <%      if(weddingExists) {
                            chosenAsset = employeeService.getAssetByID(wedding.getCatererID());%>
                            <td><p><%out.print(chosenAsset.getCompanyName());%></p></td>
                            <% catererPrice = chosenAsset.getPrice(); %>
                            <td><p><%out.print("$"+(catererPrice));%></p></td>
                <%          }   
                            else { %>
                                <td><p> No Caterer Selected</p></td>
                                <td></td>
                <%          } %>                            
                        <td> <!-- wedding selector -->
                            <label for="<% out.print(assetTypeName); %>">Select a <% out.print(assetTypeName); %></label>
                        </td>
                        <td>
                            <select name="<% out.print(assetTypeName); %>">
                <%          for(int j =0; j < assetList.size(); j++) {
                                Asset asset = assetList.get(j);
                                if(asset.getAssetTypeID() == assetTypeID) {
                                    double price = asset.getPrice(); %>
                                    <option value="<% out.print(asset.getAssetID()); %>"><% out.print(asset.getCompanyName());%>  $<%out.print(price);%></option>
                <%              } 
                            }    %>
                                
                                <option value="null">None</option>
                            </select>
                        </td>
                    </tr>                    

<!-- FLORIST -->
                <%  assetTypeName = assetTypesList.get(2).getAssetType(); 
                    assetTypeID = assetTypesList.get(2).getAssetTypeID();    %>    
                    <tr> 
                        <!-- wedding data-->
                <%      if(weddingExists) {
                            chosenAsset = employeeService.getAssetByID(wedding.getFloristID());%>
                            <td><p><%out.print(chosenAsset.getCompanyName());%></p></td>
                            <% floristPrice = chosenAsset.getPrice(); %>
                            <td><p><%out.print("$"+(floristPrice));%></p></td>
                <%          }   
                            else { %>
                                <td><p> No Florist Selected</p></td>
                                <td></td>
                <%          } %>                            
                        <td> <!-- wedding selector -->
                            <label for="<% out.print(assetTypeName); %>">Select a <% out.print(assetTypeName); %></label>
                        </td>
                        <td>
                            <select name="<% out.print(assetTypeName); %>">
                <%          for(int j =0; j < assetList.size(); j++) {
                                Asset asset = assetList.get(j);
                                if(asset.getAssetTypeID() == assetTypeID) {
                                    double price = asset.getPrice(); %>
                                    <option value="<% out.print(asset.getAssetID()); %>"><% out.print(asset.getCompanyName());%>  $<%out.print(price);%></option>
                <%              } 
                            }    %>
                                
                                <option value="null">None</option>
                            </select>
                        </td>
                    </tr>  

<!-- PHOTOGRAPHER -->
                <%  assetTypeName = assetTypesList.get(3).getAssetType(); 
                    assetTypeID = assetTypesList.get(3).getAssetTypeID();    %>    
                    <tr> 
                        <!-- wedding data-->
                <%      if(weddingExists) {
                            chosenAsset = employeeService.getAssetByID(wedding.getPhotographerID());%>
                            <td><p><%out.print(chosenAsset.getCompanyName());%></p></td>
                            <% photographerPrice = chosenAsset.getPrice(); %>
                            <td><p><%out.print("$"+(photographerPrice));%></p></td>
                <%          }   
                            else { %>
                                <td><p> No Photographer Selected</p></td>
                                <td></td>
                <%          } %>                            
                        <td> <!-- wedding selector -->
                            <label for="<% out.print(assetTypeName); %>">Select a <% out.print(assetTypeName); %></label>
                        </td>
                        <td>
                            <select name="<% out.print(assetTypeName); %>">
                <%          for(int j =0; j < assetList.size(); j++) {
                                Asset asset = assetList.get(j);
                                if(asset.getAssetTypeID() == assetTypeID) {
                                    double price = asset.getPrice(); %>
                                    <option value="<% out.print(asset.getAssetID()); %>"><% out.print(asset.getCompanyName());%>  $<%out.print(price);%></option>
                <%              } 
                            }    %>
                                
                                <option value="null">None</option>
                            </select>
                        </td>
                    </tr>
                    
<!-- MUSICIAN -->
                <%  assetTypeName = assetTypesList.get(4).getAssetType(); 
                    assetTypeID = assetTypesList.get(4).getAssetTypeID();    %>    
                    <tr> 
                        <!-- wedding data-->
                <%      if(weddingExists) {
                            chosenAsset = employeeService.getAssetByID(wedding.getMusicianID());%>
                            <td><p><%out.print(chosenAsset.getCompanyName());%></p></td>
                            <% musicianPrice = chosenAsset.getPrice(); %>
                            <td><p><%out.print("$"+(musicianPrice));%></p></td>
                <%          }   
                            else { %>
                                <td><p> No Musician Selected</p></td>
                                <td></td>
                <%          } %>                            
                        <td> <!-- wedding selector -->
                            <label for="<% out.print(assetTypeName); %>">Select a <% out.print(assetTypeName); %></label>
                        </td>
                        <td>
                            <select name="<% out.print(assetTypeName); %>">
                <%          for(int j =0; j < assetList.size(); j++) {
                                Asset asset = assetList.get(j);
                                if(asset.getAssetTypeID() == assetTypeID) {
                                    double price = asset.getPrice(); %>
                                    <option value="<% out.print(asset.getAssetID()); %>"><% out.print(asset.getCompanyName());%>  $<%out.print(price);%></option>
                <%              } 
                            }    %>
                                
                                <option value="null">None</option>
                            </select>
                        </td>
                    </tr>

<!-- BUDGET and COST -->
                    <tr>
                        <% if(weddingExists) { %>
                        <td>
                            <p> Your Budget</p>
                            <p><%out.print(wedding.getWeddingBudget());%></p>
                        </td>
                        <td>
                            <!-- summed Cost-->
                            <p>Wedding Cost</p>
                            <p>$<%out.print( venuePrice + catererPrice + floristPrice + photographerPrice + musicianPrice );%> </p>
                        </td>
                        <% } 
                           else { %>
                                <td></td>       
                                <td></td>
                        <%    } %>

                        <td></td>
                        <td>
                            <label for="wedding-budget">Budget</label>
                            <input type="text" name="wedding-budget" required>                
                            <br />                
                        </td>
                    </tr>
                </table>

                <%if(wedding.getWeddingBudget() < venuePrice + catererPrice + floristPrice + photographerPrice + musicianPrice) { %>
                    <h3> Your wedding is under budget! </h3>
                <% } %>

<!-- Hidden WEDDING DATE and SUBMIT -->

            <% if(request.getParameter("day") != null) { %>
                <input type="hidden" name="wedding-add-or-update" value="add" >	  
            <% }
            else { %>
                <input type="hidden" name="wedding-add-or-update" value="update">	  
            <% } %>
            
            <input type="hidden" name="wedding-date" value=" <% out.print(request.getParameter("year")+"-"+request.getParameter("month")+"-"+request.getParameter("day")); %> ">	  
            <% if(weddingExists) { %>
                <input type="submit" value="Update Wedding">
            <% }
            else { %>
                <input type="submit" value="Create Wedding">
            <% } %>
            </form>

    <%  } %>
     
</body>
</html>

