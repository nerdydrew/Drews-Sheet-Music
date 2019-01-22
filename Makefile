PY?=python
PELICAN?=pelican
PELICAN_OPTS= --ignore-cache

BASE_DIR=$(CURDIR)
INPUT_DIR="$(BASE_DIR)/content"
SERVE_DIR= "$(BASE_DIR)/_output"
OUTPUT_DIR="$(BASE_DIR)/_output/sheetmusic"
CONF_FILE="$(BASE_DIR)/pelicanconf.py"

help:
	@echo 'Makefile for a pelican Web site                                           '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make html                           (re)generate the web site          '
	@echo '   make clean                          remove the generated files         '
	@echo '   make regenerate                     regenerate files upon modification '
	@echo '   make serve [PORT=8000]              serve site at http://localhost:8000'
	@echo '   make serve-global [SERVER=0.0.0.0]  serve (as root) to $(SERVER):80    '
	@echo '                                                                          '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html   '
	@echo 'Set the RELATIVE variable to 1 to enable relative urls                    '
	@echo '                                                                          '

html:
	$(PELICAN) $(INPUT_DIR) -o $(OUTPUT_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)

clean:
	[ ! -d $(SERVE_DIR) ] || rm -rf $(SERVE_DIR)

regenerate:
	$(PELICAN) -r $(INPUT_DIR) -o $(OUTPUT_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)

serve:
ifdef PORT
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -p $(PORT)
else
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)
endif

serve-global:
ifdef SERVER
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -p $(PORT) -b $(SERVER)
else
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -p $(PORT) -b 0.0.0.0
endif


.PHONY: html help clean regenerate serve serve-global