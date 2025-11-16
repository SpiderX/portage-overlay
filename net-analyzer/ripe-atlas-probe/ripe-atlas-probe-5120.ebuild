# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools systemd tmpfiles

DESCRIPTION="RIPE Atlas Software Probe"
HOMEPAGE="https://github.com/RIPE-NCC/ripe-atlas-software-probe"
SRC_URI="https://github.com/RIPE-NCC/ripe-atlas-software-probe/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ripe-atlas-software-probe-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-group/ripe-atlas
	acct-user/ripe-atlas
	dev-libs/openssl:0="

src_prepare() {
	default

	# do not strip
	sed -i '/SKIP_STRIP/s|n|y|' probe-busybox/Makefile.flags \
		|| die "sed failed for Makefile.flags"

	eautoreconf
}

src_configure() {
	econf --runstatedir=/run
}

src_install() {
	default

	keepdir /var/lib/spool/ripe-atlas/crons/{main,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20} \
		/var/lib/spool/ripe-atlas/data/{new,oneoff,out,out/ooq,out/ooq10}

	newtmpfiles "${FILESDIR}"/ripe-atlas-probe.tmpfile ripe-atlas-probe.conf
	newinitd "${FILESDIR}"/ripe-atlas-probe.initd ripe-atlas-probe
	systemd_dounit "${FILESDIR}"/ripe-atlas-probe.service
}

pkg_postinst() {
	tmpfiles_process ripe-atlas-probe.conf
}
