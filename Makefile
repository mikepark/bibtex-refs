
.SUFFIXES :

.SUFFIXES : .tex .dvi .ps .pdf

.PHONEY : default dvi ps pdf clean clobber push pull

REPORTS = all

default: ps pdf

ps: $(REPORTS:%=%.ps)

pdf: $(REPORTS:%=%.pdf)

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
	rsync -av --rsh=ssh Ref acdl:/home/mikepark

pull:
	rsync -av --rsh=ssh acdl:/home/mikepark/Ref .

