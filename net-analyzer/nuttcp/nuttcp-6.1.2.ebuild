# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils readme.gentoo

DESCRIPTION="Network performance measurement tool"
HOMEPAGE="http://www.nuttcp.net/"
SRC_URI="http://nuttcp.net/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="examples ipv6 xinetd"

RDEPEND="xinetd? ( sys-apps/xinetd )"

DOC_CONTENTS="You may need to add these lines to /etc/services:\n
nuttcp\t\t5000/tcp\n
nuttcp-data\t\t5001/tcp\n
nuttcp6\t\t5000/tcp\n
nuttcp6-data\t\t5001/tcp\n\n
To run ${PN} in server mode, run:\n/etc/init.d/${PN} start"

src_prepare() {
	# Remove hardcoded flags and make use of system ones
	epatch "${FILESDIR}"/nuttcp-6.1.2-makefile.patch

	epatch_user
}

src_compile() {
	emake $(usex ipv6 '' NOIPV6=-DNO_IPV6)
}

src_install() {
	# Install nuttcp binary
	if use ipv6 ; then
		newbin ${P} ${PN}
	else
		newbin ${P}-noipv6 ${PN}
	fi

	# Install Gentoo init script and its config
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	# Install manual page and documentation
	doman ${PN}.8
	dodoc README

	if use examples ; then
		insinto /usr/share/${P}
		doins examples.txt
	fi

	if use xinetd ; then
		insinto /etc/xinetd.d
		doins "${S}"/xinetd.d/${PN}
	fi

	readme.gentoo_create_doc
}
