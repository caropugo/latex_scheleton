TEX_FILE = mi_archivo.tex
PDF_FILE = mi_archivo.pdf

all: $(PDF_FILE)

$(PDF_FILE): $(TEX_FILE)
    pdflatex $(TEX_FILE)

clean:
    del *.aux *.log *.out *.pdf *.dvi


