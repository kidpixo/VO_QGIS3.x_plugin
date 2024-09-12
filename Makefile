#see Makefiles in python projects https://krzysztofzuraw.com/blog/2016/makefiles-in-python-projects.html
# default target
.DEFAULT_GOAL := helpcol
###############################################################
# remeber to activate the appropiate virtualenviroment first! #
###############################################################

###############################################################
# cleaning

clean-pyc: ## remove all pyc, pyo and __pycache__
	find . -name '*.pyc' -exec rm -rf {} +
	find . -name '*.pyo' -exec rm -rf {} +
	find . -name '__pycache__'  -exec rm -rf {} +

clean-build: ## clean all build products
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info

###############################################################
# testing

test: clean-pyc ## run clean-pyc and test
	py.test --verbose --color=yes

#################################################################################
# Self Documenting Commands                                                     #

help: ## Show help. Only lines with ": ##" will show up! This is a plain help, requires only grep+sed.
	@grep -h "^[A-z].*:.* ## " $(MAKEFILE_LIST)  | sed 's/#/>/;s/:/>/' | column -t -s '>' 

helpcol: ## Show help. Only lines with ": ##" will show up! This require columns. Shows: rules(green), targets(red), description.
	@(echo "$$(tput bold;tput setaf 6)Available rules>$$(tput sgr0;tput setaf 1) target$$(tput sgr0)>description"; \
	grep -E -h "^[A-z].*:.* ## " $(MAKEFILE_LIST) |\
	sed 's/#/>/;s/:/>/' |\
		sed -E -e 's/([^>]+)\s?>([^>]+)\s?>(.*)/'$$(tput setaf 6)'\1>'$$(tput setaf 1)'\2'$$(tput sgr0)'>\3/' ) |\
	   	column -t -s '>' | sort
