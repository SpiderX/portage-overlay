# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/jckuester/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="A list command for AWS resources"
HOMEPAGE="https://github.com/jckuester/awsls"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # needs network and credentials

BDEPEND="test? ( app-admin/terraform )"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X github.com/jckuester/awsls/internal.version=${PV}
	-X github.com/jckuester/awsls/internal.commit=${COMMIT}
	-X \"github.com/jckuester/awsls/internal.date=${DATE}\""

	ego build -buildmode=pie -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin awsls
}
