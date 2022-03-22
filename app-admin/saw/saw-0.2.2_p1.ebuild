# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/TylerBrock/colorjson v0.0.0-20180527164720-95ec53f28296"
	"github.com/TylerBrock/colorjson v0.0.0-20180527164720-95ec53f28296/go.mod"
	"github.com/aws/aws-sdk-go v1.13.56"
	"github.com/aws/aws-sdk-go v1.13.56/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/fatih/color v1.7.0"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/go-ini/ini v1.37.0"
	"github.com/go-ini/ini v1.37.0/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/hokaccha/go-prettyjson v0.0.0-20180920040306-f579f869bbfe/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20160202185014-0b12d6b521d8"
	"github.com/jmespath/go-jmespath v0.0.0-20160202185014-0b12d6b521d8/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-isatty v0.0.3"
	"github.com/mattn/go-isatty v0.0.3/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v0.0.0-20190330032615-68dc04aab96a/go.mod"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/cobra v0.0.3/go.mod"
	"github.com/spf13/pflag v1.0.1"
	"github.com/spf13/pflag v1.0.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190613194153-d28f0bde5980/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"gopkg.in/ini.v1 v1.42.0/go.mod"
	)
go-module_set_globals

DESCRIPTION="Fast, multi-purpose tool for AWS CloudWatch Logs"
HOMEPAGE="https://github.com/TylerBrock/saw"
SRC_URI="https://api.github.com/repos/TylerBrock/${PN}/tarball/1bb0b1b -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/TylerBrock-${PN}-1bb0b1b"

DOCS=( {CHANGELOG,README}.md )

PATCHES=( "${FILESDIR}/${P}"-go.sum.patch )

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin saw
}
