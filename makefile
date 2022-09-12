PREFIX=/usr/local

CC=gcc
INSTALL=install

DESTDIR=${PREFIX}/bin
LDFLAGS+=-ljson-c

all: quotez

%.o: %.c
	$(CC) $(CFLAGS) -c $^ -o $@

quotez: quotez.o
	$(CC) $^ $(LDFLAGS) -o $@

.PHONY:
install: quotez quotes.json
	$(INSTALL) -d $(DESTDIR)
	$(INSTALL) quotez $(DESTDIR)/quotez; \
	$(INSTALL) quotes.json $(DESTDIR)/quotes.json

.PHONY:
clean:
	rm -f quotez.o quotez
