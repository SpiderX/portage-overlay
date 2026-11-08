# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module shell-completion

DESCRIPTION="Simple and flexible tool for managing secrets"
HOMEPAGE="https://github.com/mozilla/sops"
SRC_URI="https://github.com/mozilla/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.25.8"

DOCS=( {CHANGELOG,README}.rst )

src_compile() {
	ego build ./cmd/sops

	local completion
	for completion in bash zsh ; do
		edo ./sops completion "${completion}" > sops."${completion}"
	done
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin sops

	insinto /usr/share/sops
	doins audit/schema.sql

	newbashcomp sops.bash sops
	newzshcomp sops.zsh _sops
}
