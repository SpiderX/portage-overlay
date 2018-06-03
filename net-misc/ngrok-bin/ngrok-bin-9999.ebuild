# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-bin/}"
BASE_URI="https://bin.equinox.io/c/4VmDzA7iaHb/${MY_PN}-stable-linux-_arch_.zip"

DESCRIPTION="Secure introspected tunnels to localhost"
HOMEPAGE="https://ngrok.com/"
SRC_URI="amd64? ( ${BASE_URI/_arch_/amd64} )
	arm? ( ${BASE_URI/_arch_/arm} )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

RESTRICT="mirror"

S="${WORKDIR}"

QA_PREBUILT="ngrok"

src_install() {
	dobin ngrok
}
