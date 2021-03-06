# file: Makefile.tpl		G. Moody	  22 August 2010
#				Last revised:	   24 April 2020
#
# This section of the Makefile should not need to be changed.

CFILES = annxml.c heaxml.c xmlann.c xmlhea.c
HFILES = xmlproc.h
MFILES = Makefile
XFILES = annxml$(EXEEXT) heaxml$(EXEEXT) xmlann$(EXEEXT) xmlhea$(EXEEXT)

# General rule for compiling C sources into executable files.  This is
# redundant for most versions of `make', but at least one System V version
# needs it.
.c:
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

# `make all': build applications
all:	$(XFILES)
	$(STRIP) $(XFILES)

# `make' or `make install':  build and install applications
install:	all $(DESTDIR)$(BINDIR)
	$(SETXPERMISSIONS) $(XFILES)
	../install.sh $(DESTDIR)$(BINDIR) $(XFILES)

# 'make collect': retrieve the installed applications
collect:
	../conf/collect.sh $(BINDIR) $(XFILES)

uninstall:
	../uninstall.sh $(DESTDIR)$(BINDIR) $(XFILES)

# Create directories for installation if necessary.
$(DESTDIR)$(BINDIR):
	mkdir -p $(DESTDIR)$(BINDIR)
	$(SETDPERMISSIONS) $(DESTDIR)$(BINDIR)

# `make clean':  remove intermediate and backup files
clean:
	rm -f $(XFILES) *.o *~

# `make listing':  print a listing of WFDB-XML applications sources
listing:
	$(PRINT) README $(MFILES) $(CFILES) $(HFILES)

# Rules for compiling WFDB-XML applications that require non-standard options

xmlann$(EXEEXT):		xmlann.c xmlproc.h
	$(CC) $(CFLAGS) xmlann.c -o $@ $(LDFLAGS) -lexpat

xmlhea$(EXEEXT):		xmlhea.c xmlproc.h
	$(CC) $(CFLAGS) xmlhea.c -o $@ $(LDFLAGS) -lexpat
