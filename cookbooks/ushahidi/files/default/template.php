
<?php

//Get connection information from environment
$dbcon = mysql_connect('localhost',get_cfg_var('db.user'),get_cfg_var('db.password')) or halt("Could not connect to database");
if(!mysql_select_db("ushahidi")) halt("Database not found!");


// Approved vs Pending Report
$approval_query = 'SELECT Municipality_Approved AS Municipality, Approved, Pending FROM 
(SELECT COUNT(*) AS Approved, "Municipality" AS Municipality_Approved FROM ushahidi.incident WHERE incident_active = 1 ) AS approved JOIN 
       (SELECT COUNT(*) AS Pending, "Municipality" AS Municipality_Pending FROM ushahidi.incident WHERE incident_active = 0 ) AS pending ON Municipality_Approved = Municipality_Pending ORDER BY Municipality_Approved';

$approval_result = mysql_query($approval_query);


// Operator Report
$operator_query = 'SELECT operator AS Operator, COUNT(operator) AS Reports, municipality AS Municipality FROM 
       (SELECT CONCAT(person_first, " ", person_last) AS operator, "Municipality" AS municipality FROM ushahidi.incident_person ) AS operators GROUP BY operator, municipality ORDER BY municipality, operator
';

$operator_result = mysql_query($operator_query);


?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		
		<style>
				body{
					font-family:Helvetica,​arial,​freesans,​clean,​sans-serif
				}

				.seguridad {
						margin:0px;padding:0px;
						width:50%;

					}.seguridad table{
					    border-collapse: collapse;
					    border-spacing: 0;
						width:100%;
						border:1px solid #000000;
						margin:0px;padding:0px;
					}
					
					.seguridad tr th{
						background-color:#ff7f00;
						border:1px solid #000000;
						color: #FFFFFF;
					}

					.seguridad tr td{
						border:1px solid #000000;
					}			
		</style>
	</head>

	<body>
	
		<h1>Monthly Report</h1>

		<div class="seguridad" >
                <table>
                    <tr>
                        <th>Operator</th>
                        <th>Reports</th>
                    </tr>
                    <?php while($result = mysql_fetch_array($operator_result) ){ ?>
                    <tr>
                        <td><?php print $result['Operator']; ?></td>
                        <td><?php print $result['Reports']; ?></td>
                    </tr>
                    <?php } ?>
                </table>
          </div>

          <br/><br/>

          <div class="seguridad" >
                 <table>
                    <tr>
                        <th>Approved</th>
                        <th>Pending</th>
                    </tr>
                    <tr>
                    	<?php 

                    	while($result = mysql_fetch_array($approval_result) ){ ?>
                        <td><?php print $result['Approved']; ?></td>
                        <td><?php print $result['Pending']; ?></td>
                        <?php } ?>
                    </tr>
                </table>
           </div>

           <br/><br/>

           <div>
           		<img src="https://s3.amazonaws.com/si2demo.idg-rti.org/logo.png" align="right">
           </div>


	</body>
	
</html>