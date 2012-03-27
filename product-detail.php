<?php require_once('includes/header.php'); 		?>
<?php require_once('includes/search.html'); 	?>
<?php $type = "product";?>
<?php require_once('includes/breadcrumbs.php');?>	

<section class="product-hero">
	<img src="img/product-detail/hero.png" alt="Hero" />
</section>

<!--Page Container-->
<div class="middle index cf content-wrapper" id="product-detail">
	<div class="col col1 large">
		
		<div class="pricing">
			<div class="inputs">
				<input type="text" name="quantity" value="0" />
				<input type="text" name="quantity" value="0" />
				<input type="text" name="quantity" value="0" />
				<input type="text" name="quantity" value="0" />	
			</div>
			<a class="cart-button" href="cart.php"></a>
		</div><!--.pricing-->
		
		<img src="img/product-detail/properties.png" alt="Properties" />
	</div><!--.col1-->
	<div class="col col2 small">
		<img src="img/product-detail/bulk-and-contact.png" alt="Bulk And Contact" />
	</div><!--.col2-->
</div><!--#content-wrapper-->
		
<?php require_once('includes/footer.php'); 		?>