<?php require_once('includes/header.php'); 		?>
<?php require_once('includes/search-home.html');?>

<!--Page Container-->
<div class="middle index cf" id="content-wrapper">

	<nav class="col1">
		<img src="img/browse-filter/home-top.png" width="219" height="77" alt="Home Top" />
		<a class="life-science" href="life-science.php"></a>
		<img src="img/browse-filter/home-bottom.png" width="219" height="433" alt="Home Bottom" />
	</nav><!--#browse-filter-->
	
	<div class="col2">
		<img src="img/main-content-col2/vancomycin-carousel.jpg" width="738" height="300" alt="Vancomycin Carousel" />
		
		<section class="products">
			<?php require_once('includes/product.html'); 		?>
			<img src="img/main-content-col2/home-products.jpg" width="738" height="555" alt="Home Products" />
		</section>
	</div>
	
</div><!--#content-wrapper-->
<?php require_once('includes/footer.php'); 		?>