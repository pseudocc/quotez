PREFIX=/usr/local

CC=gcc
INSTALL=install

DESTDIR=${PREFIX}/bin
SHAREDIR=${PREFIX}/share/quotez

LDFLAGS+=-ljson-c

QUOTEZS=quotez quotez_debug

all: quotez

%.o: %.c
	$(CC) $(CFLAGS) -c $^ -DDATADIR="\"$(SHAREDIR)\"" -o $@

%_debug.o: %.c
	$(CC) -g $(CFLAGS) -c $^ -o $@ -DDEBUG

$(QUOTEZS): %: %.o
	$(CC) $^ $(LDFLAGS) -o $@

install: quotez quotes.json
	$(INSTALL) -d $(DESTDIR)
	$(INSTALL) -d $(SHAREDIR)
	$(INSTALL) quotez $(DESTDIR)/quotez
	$(INSTALL) -m 644 quotes.json $(SHAREDIR)/quotes.json

clean:
	rm -f *.o $(QUOTEZS)

.PHONY: clean install
