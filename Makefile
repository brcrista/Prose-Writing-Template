FILENAME := my-essay

OBJECTS := $(FILENAME).spellcheck $(FILENAME).proselint $(FILENAME).docx $(FILENAME).pdf

.PHONY:
all: $(OBJECTS)

%.spellcheck: %.md
	cat $< | aspell list | sort | uniq -c | tee $@

%.proselint: %.md
	proselint $< | tee $@

# Note that pattern rules with the same recipe must still be kept as separate rules.
# Make will treat multiple pattern targets as grouped targets: https://www.gnu.org/software/make/manual/html_node/Pattern-Intro.html.
%.docx: %.md
	pandoc -o $@ $<

%.pdf: %.md
	pandoc -o $@ $<

.PHONY:
clean:
	rm -f $(OBJECTS)
