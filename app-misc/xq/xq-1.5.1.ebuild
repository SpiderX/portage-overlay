# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

COMMIT="9803fc9"

DESCRIPTION="Command-line JSON processor for binary data"
HOMEPAGE="https://github.com/sibprogrammer/xq"
SRC_URI="https://github.com/sibprogrammer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26.1"

src_prepare() {
	default

	# rename reference (app-misc/yq)
	sed -i '/Use:/s|xq|xxq|' cmd/root.go || die "sed failed for root.go"
	# rename man
	sed -i 's/xq/xxq/;s/XQ/XXQ/' docs/xq.man || die "sed failed for xq.man"
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
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
