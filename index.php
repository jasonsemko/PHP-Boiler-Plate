<?php require_once('includes/header.php'); 		?>
<?php require_once('includes/search-home.html');?>

<!--Page Container-->
<div class="middle index cf content-wrapper" id="index">

	<nav class="col col1 small">
		<img src="img/browse-filter/home-top.png" width="219" height="77" alt="Home Top" />
		<a class="life-science" href="life-science.php"></a>
		<img src="img/browse-filter/home-bottom.png" width="219" height="433" alt="Home Bottom" />
	</nav><!--#browse-filter-->
	
	<div class="col col2 large">
		<img src="img/home/vancomycin-carousel.jpg" width="738" height="300" alt="Vancomycin Carousel" />
		
		<section class="products">
			<?php require_once('includes/product.html'); 		?>
			<img src="img/home/home-products.jpg" alt="Home Products" />
		</section>
	</div>
	
</div><!--#content-wrapper-->
<?php require_once('includes/footer.php'); 		?>
