# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Exporting data out of the badger database of step-ca"
HOMEPAGE="https://github.com/lukasz-lobocki/step-badger"
EGIT_REPO_URI="https://github.com/lukasz-lobocki/${PN}.git"

LICENSE="CC0-1.0"
SLOT="0"

src_compile() {
	ego build -o step-badger
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin step-badger
}
