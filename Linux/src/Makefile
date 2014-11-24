BINDIR = $(DESTDIR)/usr/bin/

install:
	cp -r files/etc/ $(DESTDIR)/
	cp -r files/usr/ $(DESTDIR)/

uninstall:
	rm -f $(BINDIR)/tcscript
	rm -f $(DESTDIR)/etc/tcscript.conf
	rm -f $(DESTDIR)/etc/init.d/tcscript
	rm -f $(DESTDIR)/etc/bash_completion.d/tcscript
