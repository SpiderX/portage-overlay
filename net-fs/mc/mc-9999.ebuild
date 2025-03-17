# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/minio/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Minio client provides alternatives for ls, cat on cloud storage and filesystems"
HOMEPAGE="https://github.com/minio/mc"

LICENSE="Apache-2.0 BSD MIT MPL-2.0"
SLOT="0"

DOCS=( {CONFLICT,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y')"
	LDFLAGS="-X github.com/minio/mc/cmd.Version=${PV}
		-X github.com/minio/mc/cmd.CopyrightYear=${DATE}
		-X github.com/minio/mc/cmd.ReleaseTag=DEVELOPMENT
		-X github.com/minio/mc/cmd.CommitID=$(git rev-parse HEAD)
		-X github.com/minio/mc/cmd.ShortCommitID=$(git rev-parse --short HEAD)"
	ego build -ldflags "$LDFLAGS" -o mcli
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin mcli
}
