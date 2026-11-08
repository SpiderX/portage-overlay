# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module shell-completion

DESCRIPTION="Smallstep CA cloud KMS plugin"
HOMEPAGE="https://github.com/smallstep/step-kms-plugin"
SRC_URI="https://github.com/smallstep/step-kms-plugin/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-apps/pcsc-lite"
BDEPEND=">=dev-lang/go-1.25.0"

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X github.com/smallstep/step-kms-plugin/cmd.Version=${PV}
		-X \"github.com/smallstep/step-kms-plugin/cmd.ReleaseDate=${DATE}\""

	ego build -ldflags "${LDFLAGS}" -o step-kms-plugin

	local completion
	for completion in bash fish zsh ; do
		edo ./step-kms-plugin completion "${completion}" > step-kms-plugin."${completion}"
	done
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	dobin step-kms-plugin
	newbashcomp step-kms-plugin.bash step-kms-plugin
	newfishcomp step-kms-plugin.fish step-kms-plugin
	newzshcomp step-kms-plugin.zsh _step-kms-plugin
}
