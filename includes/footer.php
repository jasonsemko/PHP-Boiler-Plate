		<!--Footer-->
		<footer>		
			<div class="top middle"></div>
			<div class="btm middle"></div>
		</footer>
		
		
		<!-- HUGE Scripts -->
		<script defer src="js/global.js"></script>
		
		<?php $JS_Files = split(" ", $JS_Files);	?>
		<?php foreach($JS_Files as $js): 			?>
			<script defer src="js/<?php echo $js; ?>"></script>
		<?php endforeach; 							?>
		
		</div><!--[if IE]> #pageWrapper <![endif]-->
	</body>
</html>