# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/luhring/${PN}"

inherit golang-build golang-vcs

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-lang/go-1.13:="

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath):${EGO_STORE_DIR}" \
		go build -v -work -x "${EGO_BUILD_FLAGS}" "${EGO_PN}"
}

src_install() {
	einstalldocs
	dobin reach
}
