<?php
	#Get args and generate plots
	$user = htmlspecialchars($_GET["user"]);
	$month = htmlspecialchars($_GET["month"]);
	$command = ('Rscript make.R ' . $user . ' ' . $month); 
	exec($command); //Runs command "Rscript username month"
	header("Location: plots.php?user=$user&month=$month"); //Redirect browser
	exit();
?>