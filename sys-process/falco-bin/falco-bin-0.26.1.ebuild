# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULES_OPTIONAL_USE="modules"
MODULES_OPTIONAL_USE_IUSE_DEFAULT="true"

inherit linux-mod pax-utils systemd unpacker

MY_PN="${PN/-bin/}"
MODULE="2aa88dcf6243982697811df4c1b484bcbe9488a2"

DESCRIPTION="Cloud-Native runtime security"
HOMEPAGE="https://falco.org"
SRC_URI="https://dl.bintray.com/falcosecurity/deb/stable/${MY_PN}-${PV}-x86_64.deb"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="modules"

BDEPEND="virtual/linux-sources"

S="${WORKDIR}"

QA_PREBUILT="/usr/bin/falco"

MODULE_NAMES="falco(falco:usr/src/falco-${MODULE})"
MODULESD_FALCO_ENABLED="yes"
BUILD_TARGETS="all"
BUILD_PARAMS="KERNELDIR=${KV_OUT_DIR}"

src_compile() {
	use modules && linux-mod_src_compile
}

src_install() {
	einstalldocs

	if use modules ; then
		linux-mod_src_install
		insinto /usr/lib/modules-load.d
		newins - falco.conf < <(echo falco || die "echo failed")
	fi

	dobin usr/bin/falco{,-driver-loader}
	pax-mark m "${ED}"/usr/bin/falco

	keepdir /etc/falco

	insinto /etc/falco
	doins -r etc/falco/.

	insinto usr/share/falco/lua
	doins -r usr/share/falco/lua/.

	newinitd "${FILESDIR}"/falco.initd falco
	newconfd "${FILESDIR}"/falco.confd falco
	systemd_dounit "${FILESDIR}"/falco.service
}
