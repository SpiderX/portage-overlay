# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils multilib

DESCRIPTION="C++ library of common design patterns and idioms"
HOMEPAGE="http://loki-lib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}-lib/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug static-libs"

DEPEND="doc? ( app-doc/doxygen[dot] )"

src_prepare() {
	# Remove hardcoded flags and make use of system ones, consider $DESTDIR
	epatch "${FILESDIR}"/loki-0.1.7-makefiles.patch

	# Remove static-libs if not needed
	use static-libs || epatch "${FILESDIR}"/loki-0.1.7-static-libs.patch

	# Add debug flag
	use debug && epatch "${FILESDIR}"/loki-0.1.7-debug.patch
}

src_compile() {
	default

	if use doc ; then
		# Compile documentation
		cd doc  || die "cd failed"
		doxygen || die "doxygen failed to compile docs"
	fi
}

src_install() {
	# Install and copy documentation
	default

	# Put the files in the right folder to support multilib
	for file in "${ED}"/usr/lib/* ; do
		mv -uT "$file" "${ED}"/usr/$(get_libdir)/ || die "Failed to move library directory for multilib support"
	done

	if use doc ; then
		# Install files into doc directory
		docinto flex
		dohtml "${S}"/doc/flex/flex_string.html
		docinto yasli
		dohtml "${S}"/doc/yasli/yasli.html
		dodoc "${S}"/doc/yasli/Notes.txt

		# Install html documentation
		docinto html
		dohtml -r "${S}"/doc/html/
	fi
}
