#!/bin/sh
wget http://3pp.local/home.php || tidy -config HTML_TIDY ../home.php >> home.php
