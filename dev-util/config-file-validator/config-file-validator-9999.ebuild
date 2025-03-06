# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Boeing/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Cross Platform tool to validate configuration files"
HOMEPAGE="https://github.com/Boeing/config-file-validator"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-w -X github.com/Boeing/config-file-validator.version=${PV}"

	ego build -buildmode=pie -ldflags "${LDFLAGS}" -o validator \
		./cmd/validator
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin validator
}
