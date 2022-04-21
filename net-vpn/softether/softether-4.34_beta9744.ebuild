# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs

DATE="2020.03.20"
MY_P="v${PV/_beta/-}"

DESCRIPTION="Multi-protocol VPN software"
HOMEPAGE="https://www.softether.org"
SRC_URI="https://www.softether-download.com/files/${PN}/${MY_P}-beta-${DATE}-tree/Source_Code/${PN}-src-${MY_P}-beta.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bridge +client cmd debug server"
REQUIRED_USE="|| ( bridge client cmd server )"

RDEPEND="dev-libs/openssl:0=
	sys-libs/ncurses:0=
	sys-libs/readline:0=
	sys-libs/zlib:0="
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS.TXT ChangeLog README )
# Prohibit to modify number of threads, respect FLAGS
PATCHES=( "${FILESDIR}"/softether-4.04-sandbox.patch
	"${FILESDIR}"/softether-4.25-compile-flags.patch )

src_prepare() {
	default

	sed -i '/opt\/vpn/s|/opt|/opt/softether|' systemd/*.service \
		|| die "sed failed for systemd files"

	rm -f configure || die
	if use amd64; then
		cp src/makefiles/linux_64bit.mak Makefile \
			|| die "copy Makefile for amd64 failed"
	elif use x86; then
		cp src/makefiles/linux_32bit.mak Makefile \
			|| die "copy Makefile for x86 failed"
	fi
}

src_compile() {
	tc-export CC AR RANLIB
	emake DEBUG="$(usex debug YES NO '' '')"
}

src_install() {
	einstalldocs

	# Define local variable, strip '+', 'debug' USE flags
	local MODULES
	MODULES="${IUSE//+}"
	MODULES="${MODULES//debug}"

	# Define installation location
	insinto /opt/softether
	doins src/bin/BuiltHamcoreFiles/unix/hamcore.se2

	# Install binary in accordance to used USE flags
	for module in ${MODULES}; do
		if use "$module" ; then
			dosym ../../hamcore.se2 /opt/softether/bin/vpn"$module"/hamcore.se2
			insinto /opt/softether/bin/vpn"$module"
			doins bin/vpn"$module"/vpn"$module"
			fperms 0755 /opt/softether/bin/vpn"$module"/vpn"$module"
			if [ "$module" != "cmd" ] ; then
				newinitd "${FILESDIR}"/"${PN}"-"$module".initd "${PN}"-"$module"
				systemd_newunit "systemd/${PN}-vpn$module.service" "${PN}"-"$module".service
			fi
		fi
	done
}
