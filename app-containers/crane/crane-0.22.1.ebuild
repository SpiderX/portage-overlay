# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module shell-completion

DESCRIPTION="Tool for interacting with remote container images and registries"
HOMEPAGE="https://github.com/google/go-containerregistry"
SRC_URI="https://github.com/google/go-containerregistry/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"
S="${WORKDIR}/go-containerregistry-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26.0"

PATCHES=( "${FILESDIR}/${PN}"-0.22.1-go1.27-tests.patch
	"${FILESDIR}/${PN}"-0.22.1-go1.27-tests-tarball.patch )

DOCS=( cmd/crane/README.md )

src_compile() {
	LDFLAGS="-w -X github.com/google/go-containerregistry/cmd/crane/cmd.Version=${PV}"

	GOFLAGS="-v -x -mod=vendor" ego build -ldflags="${LDFLAGS}" -o crane ./cmd/crane
	GOFLAGS="-v -x -mod=vendor" ego build -ldflags="${LDFLAGS}" -o gcrane ./cmd/gcrane

	(
		cd cmd/krane || die
		ego build -ldflags="${LDFLAGS}" -o "${S}"/krane .
	)

	local completion
	for completion in bash fish zsh ; do
		edo ./crane completion "${completion}" > crane."${completion}"
		edo ./gcrane completion "${completion}" > gcrane."${completion}"
		edo ./krane completion "${completion}" > krane."${completion}"
	done
}

src_test() {
	GOFLAGS="-mod=vendor" ego test ./...
}

src_install() {
	einstalldocs
	dobin crane gcrane krane

	local bin
	for bin in crane gcrane krane ; do
		newbashcomp "${bin}".bash "${bin}"
		newfishcomp "${bin}".fish "${bin}"
		newzshcomp "${bin}".zsh _"${bin}"
	done
}
