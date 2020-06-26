# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/aws/aws-sdk-go v1.27.0"
	"github.com/aws/aws-sdk-go v1.27.0/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af/go.mod"
	)
go-module_set_globals

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/mhausenblas/awsometag"
SRC_URI="https://github.com/mhausenblas/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin awsometag
}
