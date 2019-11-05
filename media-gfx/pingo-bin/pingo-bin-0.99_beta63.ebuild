# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast web image optimizer"
HOMEPAGE="https://css-ig.net/pingo"
SRC_URI="https://files.spiderx.dp.ua/software/${MY_PN}/${MY_P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}"

QA_PREBUILT="usr/bin/pingo"

src_install() {
	dobin pingo
}
