CC=gcc
SRC=src
OBJ=obj
BIN=bin

ifdef DEBUG
	STD_CFLAGS=-c -Wall -g3 -ggdb
else
	STD_CFLAGS=-c -Wall
endif

PROG=bin/devilspie2

ifndef DESTDIR
DESTDIR=/usr/local
endif

ifdef CHECK_DEPRECATED
DEPRECATED=-DGDK_PIXBUF_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED
endif

LIB_CFLAGS=`pkg-config --cflags gtk+-2.0 lua5.1 libwnck-1.0`
STD_LDFLAGS= `pkg-config --libs gtk+-2.0 lua5.1 libwnck-1.0`

LOCAL_CFLAGS=$(STD_CFLAGS) $(LIB_CFLAGS) $(DEPRECATED)
LOCAL_LDFLAGS=$(STD_LDFLAGS)

all: devilspie2

$(OBJ)/devilspie2.o: $(SRC)/devilspie2.c $(SRC)/version.h  $(SRC)/script.h $(SRC)/script_functions.h
	$(CC) $(LOCAL_CFLAGS) $(SRC)/devilspie2.c -o $(OBJ)/devilspie2.o

$(OBJ)/xutils.o: $(SRC)/xutils.c $(SRC)/xutils.h
	$(CC) $(LOCAL_CFLAGS) $(SRC)/xutils.c -o $(OBJ)/xutils.o

$(OBJ)/script.o: $(SRC)/script.c $(SRC)/script.h $(SRC)/script_functions.h
	$(CC) $(LOCAL_CFLAGS) $(SRC)/script.c -o $(OBJ)/script.o

$(OBJ)/script_functions.o: $(SRC)/script_functions.c $(SRC)/script.h $(SRC)/xutils.h
	$(CC) $(LOCAL_CFLAGS) $(SRC)/script_functions.c -o $(OBJ)/script_functions.o

devilspie2: $(OBJ)/devilspie2.o $(OBJ)/xutils.o $(OBJ)/script.o $(OBJ)/script_functions.o
	$(CC) $(LOCAL_LDFLAGS) $(OBJ)/devilspie2.o $(OBJ)/script.o $(OBJ)/script_functions.o $(OBJ)/xutils.o -o $(PROG)

clean:
	rm -rf $(OBJ)/*.o $(PROG)

install:
	install -d $(DESTDIR)/bin
	install -m 755 $(PROG) $(DESTDIR)/bin

uninstall:
	rm -f $(DESTDIR)/$(PROG)