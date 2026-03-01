# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="EKS Node Viewer"
HOMEPAGE="https://github.com/awslabs/eks-node-viewer"
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-w -X main.version=${PV} -X main.builtBy=Makefile=portage"
	ego build -buildmode=pie -ldflags "${LDFLAGS}" ./cmd/eks-node-viewer
}

src_test() {
	ego test -work ./pkg/... ./cmd/...
}

src_install() {
	einstalldocs
	dobin eks-node-viewer
}
