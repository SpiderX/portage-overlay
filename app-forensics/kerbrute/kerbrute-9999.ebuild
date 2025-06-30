# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="A tool to perform Kerberos pre-auth bruteforcing"
HOMEPAGE="https://github.com/ropnop/kerbrute"
EGIT_REPO_URI="https://github.com/ropnop/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	COMMIT="$(git rev-parse HEAD)"
	DATE="$(date +%F)"
	GOVERSION="$(go version | cut -d " " -f 3)"
	LDFLAGS="-w -X github.com/ropnop/kerbrute/util.GitCommit=${COMMIT} \
		-X \"github.com/ropnop/kerbrute/util.BuildDate=${DATE}\" \
		-X \"github.com/ropnop/kerbrute/util.GoVersion=${GOVERSION}\" \
		-X github.com/ropnop/kerbrute/util.Version=${PV}"

	ego build -ldflags="${LDFLAGS}"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin kerbrute
}
