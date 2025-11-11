# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast web image optimizer"
HOMEPAGE="https://css-ig.net/pingo"
SRC_URI="https://files.spiderx.dp.ua/software/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="usr/bin/pingo"

src_install() {
	dobin pingo
}
