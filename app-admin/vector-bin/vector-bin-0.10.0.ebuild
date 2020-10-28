# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils systemd unpacker

QA_PREBUILT="usr/bin/vector"
MY_PN="${PN/-bin/}"

DESCRIPTION="High performance logs, metrics, and events router"
HOMEPAGE="https://github.com/timberio/vector"
SRC_URI="https://github.com/timberio/${MY_PN}/releases/download/v${PV}/${MY_PN}-amd64.deb"

LICENSE="MPL-2.0"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""
RESTRICT="bindist mirror"

RDEPEND="acct-user/vector"

S="${WORKDIR}"

src_prepare() {
	default

	# Change input to work in background
	sed -i 's/type = "stdin"/type = "file"/' etc/vector/vector.toml \
		|| die "sed failed for vector.toml"
}

src_install() {
	dobin usr/bin/vector
	pax-mark m "${ED}"/usr/bin/vector

	insopts -o vector -g vector -m 0644
	insinto /etc/vector
	doins -r etc/vector/.

	newinitd "${FILESDIR}"/vector.initd vector
	newconfd "${FILESDIR}"/vector.confd vector
	systemd_dounit etc/systemd/system/vector.service
}
