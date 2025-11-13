# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="CloudFlare DNS backup tool"
HOMEPAGE="https://github.com/lfaoro/flares"
EGIT_REPO_URI="https://github.com/lfaoro/${PN}.git"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # requires auth

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d %I:%M:%S %Z')"
	COMMIT="$(git log -n 1 --format='%h')"
	LDFLAGS="-X main.commit=${COMMIT} -X main.version=${PV} -X \"main.date=${DATE}\""

	ego build -ldflags "${LDFLAGS}" -o flaredns ./cmd/...
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin flaredns
}
