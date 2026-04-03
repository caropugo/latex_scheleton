# Makefile para LaTeX multiplataforma con gestión de referencias

# Detectar sistema operativo
ifeq ($(OS),Windows_NT)
    TEX = pdflatex.exe
    BIBER = biber.exe
    BIBTEX = bibtex.exe
    RM = del /Q
    SEP = \\
    PLATFORM = windows
else
    TEX = pdflatex
    BIBER = biber
    BIBTEX = bibtex
    RM = rm -rf
    SEP = /
    PLATFORM = unix
endif

# Variables configurables
# Usamos 'main' como valor por defecto si no se especifica TARGET en la línea de comando
TARGET ?= main
BIB_NAME ?= references
BIB_FILE = $(wildcard $(BIB_NAME).bib)
COMPILER_OPTS = -synctex=1 -interaction=nonstopmode # Opciones del compilador

# Reglas de compilación
all: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).tex $(BIB_FILE)
	@echo "------------------------------- 1 ---------------------------------------"
	$(TEX) $(COMPILER_OPTS) $(TARGET).tex
	@if [ -f "$(BIB_FILE)" ]; then \
		echo "------------------------------- 2 ---------------------------------------"; \
		$(BIBER) $(TARGET) || $(BIBTEX) $(TARGET); \
	fi
	@echo "------------------------------- 3 ---------------------------------------"
	$(TEX) $(COMPILER_OPTS) $(TARGET).tex
	$(TEX) $(COMPILER_OPTS) $(TARGET).tex # Tercera pasada para referencias y tabla de contenidos


%.pdf: %.tex
	$(TEX) $(COMPILER_OPTS) $<

# Regla para limpiar archivos temporales
clean:
	$(RM) *.aux *.log *.out *.nav *.snm *.vrb *.toc *.synctex.gz *.pdf *.dvi *.lof *.lol *.lot
	$(RM) *.blg *.bbl *.bcf *.run.xml # Archivos de biber/bibtex

# Regla para generar HTML (opcional)
html: $(TARGET).tex
	latex2html -dir html -split 1 $(TARGET).tex

# Regla para generar Epub (opcional)
epub: $(TARGET).tex
	pandoc -s -o $(TARGET).epub $(TARGET).tex

# Regla para generar texto plano (opcional)
txt: $(TARGET).tex
	pandoc -s -t plain -o $(TARGET).txt $(TARGET).tex

# Regla para abrir el PDF (opcional, solo en algunos sistemas)
view: $(TARGET).pdf
ifeq ($(PLATFORM),windows)
	start $(TARGET).pdf
else
	xdg-open $(TARGET).pdf
endif

# Dependencias
$(TARGET).pdf: $(TARGET).tex

.PHONY: all clean html epub txt view
