<?php require_once('includes/header.php'); 		?>
<?php require_once('includes/search.html'); 	?>

<!--Page Container-->
<div class="middle index cf content-wrapper" id="search-results">
	<div class="col col1 small">
		<div class="inner">
			<img src="img/search-results/filtering.png" alt="Filtering" />
			<div class="request-a-product">
				<a class="cart-button" href="request.php"></a>
			</div>
		</div>
	</div>
	<div class="col col2 large">
		
		<img src="img/search-results/exact-returned-results.png" alt="Exact Returned Results" />
		
		<div class="results-dropdown">
			<select>				
					<option selected="true" value="1">Sort By Relevance</option>					
					<option value="2">Name ↑</option>
					<option value="3">Name ↓</option>
					<option value="4">Base Name ↑</option>
					<option value="5">Base Name ↓</option>
					<option value="6">Formula Weight ↑</option>
					<option value="7">Formula Weight ↓</option>				
			</select>
		</div>
		
		<div class="exact-results-container">
			<div id="slide-down-pricing" class="pricing">
				<div class="inputs top">
					<input type="text" name="quantity" value="0" />
					<input type="text" name="quantity" value="0" />
					<input type="text" name="quantity" value="0" />
					<input type="text" name="quantity" value="0" />	
				</div>
				<div class="inputs bottom">
					<input type="text" name="quantity" value="0" />
					<input type="text" name="quantity" value="0" />
				</div>
				<a class="cart-button exact" href="cart.php"></a>
			</div><!--.pricing-->
		</div>
		
	</div>
</div><!--#content-wrapper-->
<?php require_once('includes/footer.php'); 		?>
