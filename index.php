<?php

/**
 * Function to query information based on 
 * a parameter: in this case, student.
 *
 */

try  
{	
	require "config.php";
	require "common.php";

	$connection = new PDO($dsn, $username, $password, $options);

	$gradesResult = "SELECT Grade1, Grade2, Grade3, Grade4 FROM students where StudentsID = :studentID";
	$sql = "SELECT StudentsID, Name,Grade1, Grade2, Grade3, Grade4, AverageResult, FinalResult  FROM students where StudentsID = :studentID";
	$studentID = $_GET['student'];
		
	$statementGrades = $connection->prepare($gradesResult);
	$statementGrades->bindParam(':studentID', $studentID, PDO::PARAM_STR);
	$statementGrades->execute();
	
	$resultGrades = $statementGrades->fetchAll();
	
	$final = "";
	$average = 0;
	foreach ($resultGrades as $element) {
		if($element) {		
			$average = (int)$element["Grade1"] + (int)$element["Grade2"] + (int)$element["Grade3"] + (int)$element["Grade4"]  / 4;
		}
	}
	
	if($average >= 7) {
		$final = "Pass";
	} else {
		$final = "Fail";
	}
	
	//Update values for AverageResult and FinalResult
	$sqlResult = "UPDATE students SET AverageResult= :average, FinalResult= :final WHERE StudentsID= :studentID";
	$statementResult= $connection->prepare($sqlResult);
	$statementResult->bindParam(':average', $average, PDO::PARAM_STR);
	$statementResult->bindParam(':final', $final, PDO::PARAM_STR);
	$statementResult->bindParam(':studentID', $studentID, PDO::PARAM_STR);
	$statementResult->execute();
	
	$statement = $connection->prepare($sql);
	$statement->bindParam(':studentID', $studentID, PDO::PARAM_STR);
	$statement->execute();
	$result = $statement->fetchAll(PDO::FETCH_ASSOC);
	
	//Get name of school board
	$schoolBoardName = "";
	$sqlSBN = "SELECT sb.Name FROM students as s, schoolboards as sb where s.SchoolBoardsID = sb.SchoolBoardsID AND StudentsID = :studentID";
	$statementSBN = $connection->prepare($sqlSBN);
	$statementSBN->bindParam(':studentID', $studentID, PDO::PARAM_STR);
	$statementSBN->execute();
	$schoolBoardName = $statementSBN->fetchAll(PDO::FETCH_ASSOC);
	$schoolBoardNameRes = $schoolBoardName[0]["Name"];
	
	//If school board name is CSM than display result in JSON format otherwise in XML format
	 if($schoolBoardNameRes == "CSM") {
		header('Content-type: application/json');
		$json = json_encode($result, JSON_PRETTY_PRINT);		
		echo $json;		
	 } else {		 
		   header ("content-type: text/xml");
		   $xml='<?xml version="1.0" encoding="UTF-8"?>';		  
		   $xml.='<students>';
		   foreach($result as $res){
		   $xml.='<student>
					<StudentsID>'.$res['StudentsID'].'</StudentsID>
					<studentName>'.$res['Name'].'</studentName>
					<studentGrade1>'.$res['Grade1'].'</studentGrade1>
					<studentGrade2>'.$res['Grade2'].'</studentGrade2>
					<studentGrade3>'.$res['Grade3'].'</studentGrade3>
					<studentGrade4>'.$res['Grade4'].'</studentGrade4>
					<AverageResult>'.$res['AverageResult'].'</AverageResult>
					<FinalResult>'.$res['FinalResult'].'</FinalResult>
				  </student>';
			} 
		   $xml.='</students>';
		   echo $xml;
	 }
	
} catch(PDOException $error) {
	echo "<br>" . $error->getMessage();
}
?>



