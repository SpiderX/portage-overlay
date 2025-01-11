# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PN="azure-storage-azcopy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A command-line utility to manage Azure Storage accounts"
HOMEPAGE="https://github.com/Azure/azure-storage-azcopy"
SRC_URI="https://github.com/Azure/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz
	https://github.com/SpiderX/portage-overlay/raw/deps/${P}-deps.tar.xz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {ChangeLog,README}.md )

src_compile() {
	ego build
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	newbin azure-storage-azcopy azcopy
}
