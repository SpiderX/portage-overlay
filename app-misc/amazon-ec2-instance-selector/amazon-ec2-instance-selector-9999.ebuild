# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Amazon EC2 Instance Selector"
HOMEPAGE="https://github.com/aws/amazon-ec2-instance-selector"
EGIT_REPO_URI="https://github.com/aws/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-w -X main.versionID=${PV}"

	ego build -ldflags "${LDFLAGS}" -tags aeislinux \
		-o ec2-instance-selector ./cmd/main.go
}

src_test() {
	emake unit-test
}

src_install() {
	einstalldocs
	dobin ec2-instance-selector
}
