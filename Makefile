SHELL := /bin/bash
PYTHON := python

# Directories
DATA_DIR ?= data
RESULTS_DIR ?= results
LOGS_DIR ?= logs

.PHONY: help setup fetch_mangrove fetch_non_mangrove download_mangrove download_non_mangrove fastqc assemble qc all

help:
	@echo "Targets:"
	@echo "  setup                Create folders"
	@echo "  fetch_mangrove       Fetch mangrove metadata"
	@echo "  fetch_non_mangrove   Fetch non-mangrove metadata"
	@echo "  download_mangrove    Download/convert mangrove data"
	@echo "  download_non_mangroveDownload/convert non-mangrove data"
	@echo "  fastqc               Run FastQC in parallel"
	@echo "  assemble             Assemble (MEGAHIT or MetaSPAdes)"
	@echo "  qc                   (placeholder) MultiQC if available"
	@echo "  all                  Full workflow"

setup:
	mkdir -p $(DATA_DIR) $(RESULTS_DIR) $(LOGS_DIR)

fetch_mangrove: setup
	$(PYTHON) scripts/01_magenta_fetch_mangrove.py

fetch_non_mangrove: setup
	$(PYTHON) scripts/magenta_fetch_non_mangrove.py

download_mangrove: setup
	$(PYTHON) scripts/02_descargar_y_convertir_mangrove.py

download_non_mangrove: setup
	$(PYTHON) scripts/descargar_y_convertir_no_mangrove.py

fastqc: setup
	$(PYTHON) scripts/04_fastqc_parallel.py

assemble: setup
	$(PYTHON) scripts/06_assembly_serial.py

qc:
	@echo "Agrega tu comando de MultiQC aquí si lo deseas."

all: fetch_mangrove download_mangrove fastqc assemble qc
