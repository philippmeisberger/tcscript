BINDIR = $(DESTDIR)/usr/bin

install:
	install -D --mode 644 files/etc/tcscript.conf $(DESTDIR)/etc/tcscript.conf
	install -D --mode 644 files/etc/bash_completion.d/tcscript $(DESTDIR)/etc/bash_completion.d/tcscript
	install -D --mode 755 files/etc/init.d/tcscript $(DESTDIR)/etc/init.d/tcscript
	install -D --mode 755 files/usr/bin/tcscript $(BINDIR)/tcscript

uninstall:
	rm -f $(BINDIR)/tcscript
	rm -f $(DESTDIR)/etc/tcscript.conf
	rm -f $(DESTDIR)/etc/init.d/tcscript
	rm -f $(DESTDIR)/etc/bash_completion.d/tcscript
