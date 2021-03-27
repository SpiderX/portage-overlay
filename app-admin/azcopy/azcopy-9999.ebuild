# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/Azure/azure-storage-azcopy.git"

inherit git-r3 go-module

MY_PN="azure-storage-azcopy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A command-line utility to manage Azure Storage accounts"
HOMEPAGE="https://github.com/Azure/azure-storage-azcopy"
SRC_URI=""

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS=""

DOCS=( {ChangeLog,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test || die "test failed"
}

src_install() {
	einstalldocs
	newbin azure-storage-azcopy azcopy
}
