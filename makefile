.PHONY: all deploy staging

all:
	@perl ./config/prompt.pl

deploy-dev:
	@echo "  __                   "
	@echo " /\ \                  "
	@echo " \_\ \     __  __  __  "
	@echo " / _  \  / __ \\ \/\ \ "
	@echo "/\ \L\ \/\  __/ \ \_/ |"
	@echo "\ \___,_\ \____\ \___/ "
	@echo " \/__,_ /\/____/\/__/  "
	@perl ./config/deploy.pl dev


deploy-staging:
	@echo " ___     ___ ____  _      ___  __ __       ___________  ____  ____ ____ ____   ____  "
	@echo "|   \   /  _]    \| |    /   \|  |  |     / ___/      |/    |/    |    |    \ /    | "
	@echo "|    \ /  [_|  o  ) |   |     |  |  |    (   \_|      |  o  |   __||  ||  _  |   __| "
	@echo "|  D  |    _]   _/| |___|  O  |  ~  |     \__  |_|  |_|     |  |  ||  ||  |  |  |  | "
	@echo "|     |   [_|  |  |     |     |___, |     /  \ | |  | |  _  |  |_ ||  ||  |  |  |_ | "
	@echo "|     |     |  |  |     |     |     |     \    | |  | |  |  |     ||  ||  |  |     | "
	@echo "|_____|_____|__|  |_____|\___/|____/       \___| |__| |__|__|___,_|____|__|__|___,_| "
	@perl ./config/deploy.pl staging

zip:
	@perl ./config/deploy.pl zip

test:
	@perl ./config/deploy.pl test

