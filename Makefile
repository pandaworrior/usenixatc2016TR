TARGET   = main
TEXFILES = $(wildcard *.tex) $(wildcard sections/*.tex)
DIAGRAMS_EPS = $(wildcard diagrams/*.eps)
FIGURES  = 

LATEX_OPT = -interaction=nonstopmode -halt-on-error
#LATEX_OPT =
THEFIGURES = $(addprefix figures/, $(FIGURES))

all: $(TARGET).pdf

$(TARGET).aux: $(TEXFILES)
	pdflatex $(LATEX_OPT) $(TARGET).tex

$(TARGET).bbl: $(TARGET).aux 
	bibtex $(TARGET)


$(TARGET).pdf: $(TEXFILES)  $(THEFIGURES) $(TARGET).bbl
	pdflatex  $(TARGET).tex
	bibtex $(TARGET)
	pdflatex $(LATEX_OPT) $(TARGET).tex
	pdflatex $(TARGET).tex



#$(TARGET).dvi: $(TEXFILES)  $(THEFIGURES) $(TARGET).bbl
#	latex  $(TARGET).tex
#	bibtex $(TARGET)
#	latex $(LATEX_OPT) $(TARGET).tex
#	latex $(TARGET).tex

#%.ps: %.dvi
##	dvips $< -Ppdf -Pcmz -Pamz -t letter -D 600 -G0 -Pdownload35 -o $@
#	dvips $< -Ppdf -Pcmz -Pamz -t a4 -D 600 -G0 -Pdownload35 -Z -o $@

#%.pdf: %.ps
##	ps2pdf -dPDFX=true $<
#	ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true $<
#	rm -rfv *.dvi *.aux sections/*.aux *.log *~ *.bbl *.blg *.toc *.ps *.ent *.lof *.lot *.out

diagrams/%.pdf: $(DIAGRAMS_EPS)
	epstopdf $< >$@

figures/%.eps: plots/%.plot
	gnuplot $< >$@

#figures/%.eps: plots/%.plot
#	gnuplot $< >$@

#figures/%.eps: figures/%.fig
#	fig2dev -L eps -p dummy $< $@

clean:
	rm -rfv *.dvi *.aux *.log *~ *.bbl *.blg *.toc *.ps *.ent *.lof *.lot *.out $(THEFIGURES) $(TARGET).pdf

