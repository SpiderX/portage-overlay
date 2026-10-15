# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3 go-module shell-completion

DESCRIPTION="Tool for interacting with remote container images and registries"
HOMEPAGE="https://github.com/google/go-containerregistry"
EGIT_REPO_URI="https://github.com/google/go-containerregistry.git"

LICENSE="Apache-2.0"
SLOT="0"

BDEPEND=">=dev-lang/go-1.26.0"

DOCS=( cmd/crane/README.md )

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	LDFLAGS="-w -X github.com/google/go-containerregistry/cmd/crane/cmd.Version=${PV}"

	GOFLAGS="-v -x -mod=vendor" ego build -ldflags="${LDFLAGS}" -o crane ./cmd/crane
	GOFLAGS="-v -x -mod=vendor" ego build -ldflags="${LDFLAGS}" -o gcrane ./cmd/gcrane

	local completion
	for completion in bash fish zsh ; do
		edo ./crane completion "${completion}" > crane."${completion}"
		edo ./gcrane completion "${completion}" > gcrane."${completion}"
	done
}

src_test() {
	GOFLAGS="-mod=vendor" ego test ./...
}

src_install() {
	einstalldocs
	dobin crane gcrane

	local bin
	for bin in crane gcrane ; do
		newbashcomp "${bin}".bash "${bin}"
		newfishcomp "${bin}".fish "${bin}"
		newzshcomp "${bin}".zsh _"${bin}"
	done
}
