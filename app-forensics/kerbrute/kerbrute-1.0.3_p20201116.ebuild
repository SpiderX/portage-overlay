# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="9cfb81e4fab8037acb44c678773ca3f93bc2b39c"

DESCRIPTION="A tool to perform Kerberos pre-auth bruteforcing"
HOMEPAGE="https://github.com/ropnop/kerbrute"
SRC_URI="https://github.com/ropnop/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	DATE="$(date +%F)"
	GOVERSION="$(go version | cut -d " " -f 3)"
	LDFLAGS="-w -X github.com/ropnop/kerbrute/util.GitCommit=${COMMIT} \
		-X \"github.com/ropnop/kerbrute/util.BuildDate=${DATE}\" \
		-X \"github.com/ropnop/kerbrute/util.GoVersion=${GOVERSION}\" \
		-X github.com/ropnop/kerbrute/util.Version=${PV}"

	ego build -ldflags="${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin kerbrute
}
