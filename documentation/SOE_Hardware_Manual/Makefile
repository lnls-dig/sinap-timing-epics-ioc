INPUT = SOE_Hardware_Manual.tex

PDF  = $(INPUT:.tex=.pdf)
ALL  = $(PDF)

all: $(ALL)

%.pdf: %.tex
	pdflatex -dSubsetFonts=true -dEmbedAllFonts=true $^
	pdflatex -dSubsetFonts=true -dEmbedAllFonts=true $^

.PHONY: clean

clean :
	rm -f *.eps *.pdf *.dat *.log *.out *.aux *.dvi *.ps *.toc version.tex
