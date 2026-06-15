# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module

COMMIT="aee8c753aefee529a714c26061d2a1efd6dc9a56"

DESCRIPTION="A command-line tool to merge multiple MaxMind MMDB databases"
HOMEPAGE="https://github.com/maxmind/mmdbconvert"
SRC_URI="https://github.com/maxmind/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz
	test? ( https://github.com/maxmind/MaxMind-DB/archive/${COMMIT}.tar.gz -> ${P}-db.tar.gz )"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND=">=dev-lang/go-1.25.3"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	if use test ; then
		edo rmdir testdata/MaxMind-DB
		edo ln -s ../../MaxMind-DB-"${COMMIT}" testdata/MaxMind-DB
	fi
}

src_compile() {
	LDFLAGS="-w -X main.version=${PV}"

	ego build -ldflags "${LDFLAGS}" ./cmd/mmdbconvert/...
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin mmdbconvert
}
