SUFFIXES = .json .pot

.json.pot:
	$(AM_V_GEN) rm -f $@ $@.tmp; \
	srcdir=''; \
	  test -f ./$< || srcdir=$(srcdir)/; \
	  $(top_builddir)/tools/gen-metadata-pot $${srcdir}$< \
            '$$.name' '$$.description' >$@.tmp && mv $@.tmp $@

# 'make check' in po/ requires metadata.pot
check-local: metadata.pot
	$(JSON_VALIDATE) \
		--schema $(top_srcdir)/data/rules/keymap-schema.json \
		keymap/*.json
	$(JSON_VALIDATE) \
		--schema $(top_srcdir)/data/rules/rom-kana-schema.json \
		rom-kana/*.json

metadata.pot: metadata.json $(top_srcdir)/tools/gen-metadata-pot.c

EXTRA_DIST += metadata.pot
