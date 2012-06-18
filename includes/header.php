<!DOCTYPE HTML>

<html class="no-js" lang="en">
	<head>
		<meta charset="utf-8">
			
		<title>Your Project Title</title>
		
		<!-- CSS -->		
		<link href="css/base.css" rel="stylesheet">	
		<link href="css/global.css" rel="stylesheet">
		<link href="css/plugins/colorbox.css" rel="stylesheet">	
		
		<?php $CSS_Files = split(" ", $CSS_Files);	?>
		<?php foreach($CSS_Files as $css): 			?>
			<link href="css/plugins/<?php echo $css; ?>" rel="stylesheet">	
		<?php endforeach; 							?>
		
		<script src="js/plugins/jquery-1.7.js"></script>
		<script src="js/plugins/jquery.modernizr-2.5.3.js"></script>
		<script src="js/plugins/jquery.colorbox.js"></script>
	</head> 

	<body id="<?php echo $body_ID; ?>">
		
		<!--[if lt IE 7 ]> <div class="ie ie6"> <![endif]-->
		<!--[if IE 7 ]> <div class="ie ie7"> <![endif]-->
		<!--[if IE 8 ]> <div class="ie ie8"> <![endif]-->
		<!--[if IE 9 ]> <div class="ie ie9"> <![endif]-->
		
		<div id="pageWrapper">
		  
		  <!--Header-->
		  <header></header>
