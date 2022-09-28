PREFIX=/usr/local

CC=gcc
INSTALL=install

DESTDIR=${PREFIX}/bin
SHAREDIR=${PREFIX}/share/quotez

LDFLAGS+=-ljson-c

all: quotez

%.o: %.c
	$(CC) $(CFLAGS) -c $^ -DDATADIR="\"$(SHAREDIR)\"" -o $@

quotez: quotez.o
	$(CC) $^ $(LDFLAGS) -o $@

install: quotez quotes.json
	$(INSTALL) -d $(DESTDIR)
	$(INSTALL) -d $(SHAREDIR)
	$(INSTALL) quotez $(DESTDIR)/quotez
	$(INSTALL) -m 644 quotes.json $(SHAREDIR)/quotes.json

clean:
	rm -f quotez.o quotez

.PHONY: clean install
