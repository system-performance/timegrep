#
# http://www.gnu.org/software/make/manual/make.html
#

NAME     := timegrep
CC       := cc
SOURCES  := $(NAME).c
OBJECTS  := $(NAME).o
CFLAGS   := -std=c99 --pedantic -Wall -Werror -O2 -fno-strict-aliasing
CPPFLAGS :=
LDFLAGS  := -lpcre

PREFIX   ?= /usr
BINDIR   := $(PREFIX)/bin
MANDIR   := $(PREFIX)/share/man

CFLAGS   += $(USER_CFLAGS)
CPPFLAGS += $(USER_CPPFLAGS)
LDFLAGS  += $(USER_LDFLAGS)

all: $(NAME)

$(NAME): $(SOURCES) $(OBJECTS)
	$(CC) -o $(NAME) $(OBJECTS) $(LDFLAGS)

clean:
	rm -f $(NAME)
	rm -f $(OBJECTS)

%.o: %.c
	$(CC) $(CFLAGS) $< -c -o $@

install: $(NAME)
	mkdir -p $(abspath $(DESTDIR)/$(BINDIR))
	mkdir -p $(abspath $(DESTDIR)/$(MANDIR)/man1)
	install -m 0755 $(NAME) $(abspath $(DESTDIR)/$(BINDIR)/$(NAME))
	install -m 0644 $(NAME).1 $(abspath $(DESTDIR)/$(MANDIR)/man1/$(NAME).1)
