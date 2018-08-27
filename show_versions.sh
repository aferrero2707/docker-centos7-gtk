#! /bin/bash

for pkg in pango pangomm-1.4 cairo cairomm-1.0 pangocairo atk atkmm-1.6 gdk-pixbuf-2.0 gobject-2.0 gobject-introspection-1.0 glib-2.0 glibmm-2.4 gdk-3.0 gdkmm-3.0 gtk+-3.0 gtkmm-3.0 librsvg-2.0 fontconfig; do
	echo -n "$pkg: "
	pkg-config --modversion $pkg 2> /dev/null
done