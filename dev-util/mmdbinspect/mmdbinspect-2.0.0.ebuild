# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module

COMMIT="507c17e7cf266bb47bca4922aa62071cb21f6d06"

DESCRIPTION="Look up records for one or more IPs/networks in one or more .mmdb databases"
HOMEPAGE="https://github.com/maxmind/mmdbinspect"
SRC_URI="https://github.com/maxmind/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz
	test? ( https://github.com/maxmind/MaxMind-DB/archive/${COMMIT}.tar.gz -> ${P}-db.tar.gz )"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	if use test ; then
		edo rmdir test/data
		edo ln -s ../../MaxMind-DB-"${COMMIT}" test/data
	fi
}

src_compile() {
	ego build ./cmd/mmdbinspect/...
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin mmdbinspect
}
