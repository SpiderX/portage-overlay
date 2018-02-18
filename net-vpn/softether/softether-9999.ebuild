# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="git://github.com/SoftEtherVPN/SoftEtherVPN.git"
EGIT_BRANCH="master"

inherit eutils git-r3

DESCRIPTION="Multi-protocol VPN software"
HOMEPAGE="http://www.softether.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="bridge client cmd debug server"
REQUIRED_USE="|| ( bridge client cmd server )"

RDEPEND="dev-libs/openssl
	sys-libs/ncurses
	sys-libs/readline
	sys-libs/zlib"

S=${WORKDIR}/src

DOCS=( AUTHORS.TXT ChangeLog README )
# Prohibit to modify number of threads
PATCHES=( "${FILESDIR}"/softether-4.04-sandbox.patch )

src_configure() {
	use amd64 && echo -e "1\\n2\\n" | ./configure
	use x86   && echo -e "1\\n1\\n" | ./configure
}

src_compile() {
	emake DEBUG="$(usex debug YES NO '' '')"
}

src_install() {
	# Define local variable, strip 'debug' USE flags
	local MODULES
	MODULES="${IUSE//debug}"

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
				newconfd "${FILESDIR}"/"${PN}"-"$module".confd "${PN}"-"$module"
			fi
		fi
	done
}
