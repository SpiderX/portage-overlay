# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-bin/}"
BASE_URI="https://bin.equinox.io/c/4VmDzA7iaHb/${MY_PN}-stable-linux-_arch_.zip"

DESCRIPTION="Secure introspected tunnels to localhost"
HOMEPAGE="https://ngrok.com/"

SRC_URI="
	amd64? ( ${BASE_URI/_arch_/amd64} )
	arm? ( ${BASE_URI/_arch_/arm} )"
	### https://github.com/sakaki-/gentoo-on-rpi3-64bit
	## ngrok-stable-linux-arm64.tgz
	# http://cdn.pine64.uk/Gentoo/gentoo-pine64-20160804.img.gz
	arm64? ( ${BASE_URI/_arch_/arm64} )"
	# practicly dead but ok... will do.  ngrok-stable-linux-386.tgz ## x86 is mostly dead save for embeded... 
	x86? ( ${BASE_URI/_arch_/386} )
	

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""
RESTRICT="mirror"

QA_PREBUILT="ngrok"

S="${WORKDIR}"

src_install() {
	dobin ngrok
}
