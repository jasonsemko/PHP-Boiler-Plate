<?php require_once('includes/header.php'); 		?>
<?php require_once('includes/search.html'); 	?>
<?php require_once('includes/breadcrumbs.html');?>	

<!--Page Container-->
<div class="middle index cf content-wrapper" id="antibiotics">

	<img class="page-title" src="img/antibiotics/title.png" width="990" height="90" alt="Title" />

	<nav class="col col1 small">
		<div class="inner">
			<?php require_once('includes/filtering.html'); ?>
			<div class="request-a-product">
				<a class="cart-button" href="request.php"></a>
			</div>
		</div>
		
	</nav><!--.col1-->
	
	<div class="col col2 large">
		<div class="results-dropdown"></div>
		<section class="products">
			<?php require_once('includes/product.html'); 		?>
			<img src="img/antibiotics/products.png" alt="Products" />
		</section>
	</div><!--.col2-->
	
</div><!--#content-wrapper-->
		
<?php require_once('includes/footer.php'); 		?>