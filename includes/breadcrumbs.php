<?php
  if(!isset($type)) {$type = "";}
?>

<!--BreadCrumbs-->
<div class="breadcrumbs-container">
	<div class="breadcrumbs <?php echo $type;?>">
		<a class="store" href="index.php"></a>
		<a class="section" href="life-science.php"></a>
		<?php if($type == "product"): ?>
		  <a class="product-breadcrumb" href="antibiotics.php"></a>
		<?php endif;?>
	</div>
</div>