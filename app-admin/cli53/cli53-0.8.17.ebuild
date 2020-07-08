# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/aws/aws-sdk-go v1.13.34"
	"github.com/aws/aws-sdk-go v1.13.34/go.mod"
	"github.com/aws/aws-sdk-go v1.29.19"
	"github.com/aws/aws-sdk-go v1.29.19/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/go-ini/ini v1.28.2"
	"github.com/go-ini/ini v1.28.2/go.mod"
	"github.com/go-sql-driver/mysql v1.5.0/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gucumber/gucumber v0.0.0-20160715015914-71608e2f6e76"
	"github.com/gucumber/gucumber v0.0.0-20160715015914-71608e2f6e76/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20160202185014-0b12d6b521d8"
	"github.com/jmespath/go-jmespath v0.0.0-20160202185014-0b12d6b521d8/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/miekg/dns v0.0.0-20170818131442-e4205768578d"
	"github.com/miekg/dns v0.0.0-20170818131442-e4205768578d/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/shiena/ansicolor v0.0.0-20151119151921-a422bbe96644"
	"github.com/shiena/ansicolor v0.0.0-20151119151921-a422bbe96644/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v0.0.0-20190731233626-505e41936337"
	"github.com/smartystreets/goconvey v0.0.0-20190731233626-505e41936337/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.1"
	"github.com/stretchr/testify v1.2.1/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/urfave/cli v1.20.0"
	"github.com/urfave/cli v1.20.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190827160401-ba9fcec4b297"
	"golang.org/x/net v0.0.0-20190827160401-ba9fcec4b297/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	)
go-module_set_globals

DESCRIPTION="Command line tool for Amazon Route 53"
HOMEPAGE="https://github.com/barnybug/cli53"
SRC_URI="https://github.com/barnybug/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS=( {CHANGELOG,README}.md )

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin "${HOME}"/go/bin/cli53
}
