# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 go-module

DESCRIPTION="Command-line JSON processor for binary data"
HOMEPAGE="https://github.com/sibprogrammer/xq"
EGIT_REPO_URI="https://github.com/sibprogrammer/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26.1"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	# rename reference (app-misc/yq)
	sed -i '/Use:/s|xq|xxq|' cmd/root.go || die "sed failed for root.go"
	# rename man
	sed -i 's/xq/xxq/;s/XQ/XXQ/' docs/xq.man || die "sed failed for xq.man"
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	COMMIT="$(git log -n 1 --format='%h')"
	LDFLAGS="-X main.version=${PV} -X \"main.date=${DATE}\" -X main.commit=${COMMIT}"
	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -v ./...
}

src_install() {
	einstalldocs
	newbin xq xxq
	newman docs/xq.man xxq.1
}
