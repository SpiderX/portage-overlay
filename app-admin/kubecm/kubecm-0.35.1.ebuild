# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

COMMIT="0129cff"

DESCRIPTION="Manage your kubeconfig more easily"
HOMEPAGE="https://github.com/sunny0826/kubecm"
SRC_URI="https://github.com/sunny0826/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	DATE="$(date -u '+%Y-%m-%d')"
	LDFLAGS="-w -X github.com/sunny0826/kubecm/version.Version=${PV}
		-X github.com/sunny0826/kubecm/version.GitRevision=${COMMIT}
		-X \"github.com/sunny0826/kubecm/version.BuildDate=${DATE}\""
	ego build -ldflags "${LDFLAGS}"

	local completion
	for completion in bash zsh fish ; do
		edo ./kubecm completion ${completion} > kubecm.${completion}
	done
}

src_test() {
	ego test -work ./cmd/...
}

src_install() {
	einstalldocs
	dobin kubecm

	newbashcomp kubecm.bash kubecm
	newfishcomp kubecm.fish kubecm
	newzshcomp kubecm.zsh _kubecm
}
