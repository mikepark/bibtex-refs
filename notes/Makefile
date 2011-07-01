
.SUFFIXES :

.SUFFIXES : .tex .dvi .ps .pdf .bib

.PHONEY : default dvi ps pdf clean clobber push pull

REPORTS = parallel-adapt-load-balance

default: bib pdf

ps: $(REPORTS:%=%.ps)

pdf: $(REPORTS:%=%.pdf)

bib: $(REPORTS:%=%.bib)

.tex.bib:
	latex $*
	bibtex $*

.tex.dvi:
	latex $*
	latex $*

.dvi.ps:
	dvips -o $*.ps $*.dvi

.tex.pdf:
	pdflatex $*
	pdflatex $*

clean:
	rm -rf $(REPORTS:%=%.aux) $(REPORTS:%=%.bbl) $(REPORTS:%=%.blg)
	rm -rf $(REPORTS:%=%.log) $(REPORTS:%=%.toc) $(REPORTS:%=%.dvi)
	rm -rf *~ 

clobber: clean
	rm -rf $(REPORTS:%=%.ps) $(REPORTS:%=%.pdf)

