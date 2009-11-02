
.SUFFIXES :

.SUFFIXES : .tex .dvi .ps .pdf .bib

.PHONEY : default dvi ps pdf clean clobber push pull

REPORTS = all mike_park_publications

default: bib pdf

ps: $(REPORTS:%=%.ps)

pdf: $(REPORTS:%=%.pdf)

bib: $(REPORTS:%=%.bib)

.tex.bib:
	latex $*
	bibtex $*

.tex.dvi:
	latex $*
	grep 'There were undefined references' $*.log > /dev/null && \
	   bibtex $* && latex $* || true
	grep Rerun $*.log > /dev/null && latex $* || true
	grep Rerun $*.log > /dev/null && latex $* || true

.dvi.ps:
	dvips -o $*.ps $*.dvi

.dvi.pdf:
	dvipdf $*.dvi $*.pdf

gv: ps
	( gv -w $(SHOW).ps || gv --watch $(SHOW).ps ) &

clean:
	rm -rf $(REPORTS:%=%.aux) $(REPORTS:%=%.bbl) $(REPORTS:%=%.blg)
	rm -rf $(REPORTS:%=%.log) $(REPORTS:%=%.toc) $(REPORTS:%=%.dvi)
	rm -rf *~ 

clobber: clean
	rm -rf $(REPORTS:%=%.ps) $(REPORTS:%=%.pdf)

push:
	git push
	rsync -av --rsh=ssh Ref acdl:/home/mikepark

pull:
	git pull
	rsync -av --rsh=ssh acdl:/home/mikepark/Ref .

