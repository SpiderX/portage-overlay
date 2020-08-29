# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="A tool to create identical machine images for multiple platforms"
HOMEPAGE="https://www.packer.io"
SRC_URI="https://github.com/hashicorp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 BSD-2 BSD-4 ECL-2.0 icu imagemagick ISC JSON MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS=( {README,CHANGELOG}.md )

src_compile() {
	GOFLAGS="-v -x -mod=vendor" \
		go build -o bin/packer ./ || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./ || die "test failed"
}

src_install() {
	einstalldocs
	dobin bin/packer
	insinto /usr/share/zsh/site-functions
	doins contrib/zsh-completion/_packer
}

pkg_postinst() {
	go-module_pkg_postinst

	elog "If you would like to install shell completions please run:"
	elog "    packer -install-autocomplete"
}
