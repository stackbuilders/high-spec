ATSHOMEQ="$(PATSHOME)"

ATSCC=$(ATSHOMEQ)/bin/patscc
ATSOPT=$(ATSHOMEQ)/bin/patsopt

ATSCCFLAGS=
CCFLAGS=-fPIC -c

all:: libbookstore.so

libbookstore.so: bookstore.o ; \
  $(CC) $< -shared -o $@

bookstore.o: bookstore.c ; \
  $(CC) $(CCFLAGS) -o $@ $<  -I$(ATSHOMEQ)/ccomp/runtime \
  -I$(ATSHOMEQ)

bookstore.c: bookstore.dats ; \
    $(ATSOPT) $(ATSCCFLAGS) -o $@ -d $<

RMF=rm -f

cleanall::

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *.c
clean:: ; $(RMF) *.js
clean:: ; $(RMF) *.o
clean:: ; $(RMF) *.so
cleanall:: clean
