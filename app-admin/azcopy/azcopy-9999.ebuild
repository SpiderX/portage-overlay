# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/Azure/azure-storage-azcopy.git"

inherit git-r3 go-module

MY_PN="azure-storage-azcopy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A command-line utility to manage Azure Storage accounts"
HOMEPAGE="https://github.com/Azure/azure-storage-azcopy"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=( {ChangeLog,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -buildmode=pie || die "build failed"
}

src_test() {
	go test || die "test failed"
}

src_install() {
	einstalldocs
	newbin azure-storage-azcopy azcopy
}
