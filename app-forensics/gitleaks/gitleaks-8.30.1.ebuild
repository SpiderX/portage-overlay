# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Auditing git repository for secrets and keys"
HOMEPAGE="https://github.com/zricethezav/gitleaks"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -ldflags "-X=github.com/zricethezav/gitleaks/v8/version.Version=${PV}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin gitleaks
}
