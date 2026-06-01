# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="798f9ba"

DESCRIPTION="EKS Node Viewer"
HOMEPAGE="https://github.com/awslabs/eks-node-viewer"
SRC_URI="https://github.com/awslabs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.version=${PV} -X main.builtBy=portage
	-X main.commit=${COMMIT} -X \"main.date=${DATE}\""
	ego build -buildmode=pie -ldflags "${LDFLAGS}" ./cmd/eks-node-viewer
}

src_test() {
	ego test -work ./pkg/... ./cmd/...
}

src_install() {
	einstalldocs
	dobin eks-node-viewer
}
