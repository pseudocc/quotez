PREFIX=/usr/local

CC=gcc
INSTALL=install

DESTDIR=${PREFIX}/bin
LDFLAGS+=-ljson-c

all: quotex

%.o: %.c
	$(CC) $(CFLAGS) -c $^ -o $@

quotex: quotex.o
	$(CC) $^ $(LDFLAGS) -o $@

.PHONY:
install: quotex quotes.json
	$(INSTALL) -d $(DESTDIR)
	$(INSTALL) quotex $(DESTDIR)/quotex; \
	$(INSTALL) quotes.json $(DESTDIR)/quotes.json

.PHONY:
clean:
	rm -f quotex.o quotex
