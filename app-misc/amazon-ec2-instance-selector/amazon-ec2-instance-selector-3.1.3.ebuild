# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Amazon EC2 Instance Selector"
HOMEPAGE="https://github.com/aws/amazon-ec2-instance-selector"
SRC_URI="https://github.com/aws/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
