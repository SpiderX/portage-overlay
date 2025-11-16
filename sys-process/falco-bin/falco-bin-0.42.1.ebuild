# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MODULES_OPTIONAL_IUSE="modules"

inherit linux-mod-r1 pax-utils systemd unpacker

MODULE="9.0.0+driver"

DESCRIPTION="Cloud-Native runtime security"
HOMEPAGE="https://falco.org"
SRC_URI="https://download.falco.org/packages/deb/stable/${P//-bin/}-x86_64.deb"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="modules"

BDEPEND="virtual/linux-sources"

QA_PREBUILT="usr/bin/falco
	usr/bin/falcoctl
	usr/share/falco/plugins/libcontainer.so"

CONFIG_CHECK="~IPV6"

src_compile() {
	local modlist=( falco=misc:usr/src/falco-${MODULE} )
	local modargs=( KERNELDIR="${KV_OUT_DIR}" )
	use modules && linux-mod-r1_src_compile
}

src_install() {
	einstalldocs

	if use modules ; then
		linux-mod-r1_src_install
		insinto /usr/lib/modules-load.d
		newins - falco.conf < <(echo falco || die "echo failed")
	fi

	dobin usr/bin/falco{,ctl}
	pax-mark m "${ED}"/usr/bin/falco{,ctl}

	keepdir /etc/falco

	insinto /etc/falco
	doins -r etc/falco/.

	exeinto usr/share/falco/plugins
	doexe usr/share/falco/plugins/libcontainer.so

	newinitd "${FILESDIR}"/falco.initd falco
	newconfd "${FILESDIR}"/falco.confd falco
	systemd_dounit usr/lib/systemd/system/falcoctl-artifact-follow.service \
		usr/lib/systemd/system/falco-{bpf,custom,kmod-inject,kmod,modern-bpf}.service
}
