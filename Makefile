
.SUFFIXES :

.SUFFIXES : .tex .pdf .bib

.PHONEY : default pdf clean clobber push pull

REPORTS = all mike_park_publications

default: pdf

pdf: $(REPORTS:%=%.pdf)

bib: $(REPORTS:%=%.bib)

.tex.bib:
	pdflatex $*
	bibtex $*

.tex.pdf:
	pdflatex $*
	grep 'There were undefined references' $*.log > /dev/null && \
	   bibtex $* && latex $* || true
	grep Rerun $*.log > /dev/null && pdflatex $* || true
	grep Rerun $*.log > /dev/null && pdflatex $* || true

clean:
	rm -rf $(REPORTS:%=%.aux) $(REPORTS:%=%.bbl) $(REPORTS:%=%.blg)
	rm -rf $(REPORTS:%=%.log) $(REPORTS:%=%.toc)
	rm -rf $(REPORTS:%=%.out)
	rm -rf $(REPORTS:%=%.dvi)
	rm -rf *~ 

clobber: clean
	rm -rf $(REPORTS:%=%.pdf)

REFHOST=cmb20

push:
	git push
	rm -f Ref/.DS_Store
	rsync -av --rsh=ssh Ref $(REFHOST):bibtex-refs

pull:
	git pull
	rsync -av --rsh=ssh $(REFHOST):bibtex-refs/Ref .

SUBJECTHOST=cmb20

push-subjects:
	rsync -av --rsh=ssh subjects $(SUBJECTHOST):bibtex-refs

pull-subjects:
	rsync -av --rsh=ssh $(SUBJECTHOST):bibtex-refs/subjects .

