# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module systemd

EGO_SUM=(
	"github.com/alecthomas/kong v0.2.9"
	"github.com/alecthomas/kong v0.2.9/go.mod"
	"github.com/aws/aws-sdk-go v1.30.27"
	"github.com/aws/aws-sdk-go v1.30.27/go.mod"
	"github.com/coreos/go-systemd v0.0.0-20190321100706-95778dfbb74e/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-sql-driver/mysql v1.5.0/go.mod"
	"github.com/hako/durafmt v0.0.0-20190612201238-650ed9f29a84"
	"github.com/hako/durafmt v0.0.0-20190612201238-650ed9f29a84/go.mod"
	"github.com/jmespath/go-jmespath v0.3.0"
	"github.com/jmespath/go-jmespath v0.3.0/go.mod"
	"github.com/jpillora/backoff v1.0.0"
	"github.com/jpillora/backoff v1.0.0/go.mod"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/robfig/cron/v3 v3.0.1"
	"github.com/robfig/cron/v3 v3.0.1/go.mod"
	"github.com/rs/xid v1.2.1/go.mod"
	"github.com/rs/zerolog v1.18.0"
	"github.com/rs/zerolog v1.18.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.5.1"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"github.com/zenazn/goji v0.9.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/tools v0.0.0-20190828213141-aed303cbaa74/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20190924164351-c8b7dadae555"
	"gopkg.in/yaml.v3 v3.0.0-20190924164351-c8b7dadae555/go.mod"
	)
go-module_set_globals

DESCRIPTION="Dynamic DNS for Amazon Route 53 on a time-based schedule"
HOMEPAGE="https://github.com/crazy-max/ddns-route53"
SRC_URI="https://github.com/crazy-max/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="acct-user/ddnsr53"

src_prepare() {
	default

	sed -i '/ExecStart/s|/local||' .res/systemd/ddns-route53.service \
		|| die "sed failed for ddns-route53.service"
}

src_compile() {
	go build -o ddns-route53 ./cmd/... || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	dobin ddns-route53
	newinitd "${FILESDIR}"/ddns-route53.initd ddns-route53
	newconfd "${FILESDIR}"/ddns-route53.confd ddns-route53
	systemd_dounit .res/systemd/ddns-route53.service

	# Generate sample config
	insopts -o ddnsr53 -g ddnsr53 -m 0644
	insinto /etc/ddns-route53
	newins - ddns-route53.yml < <(grep -m1 -A13 yml doc/configuration.md | tail -n +2 \
		|| die "grep failed for ddns-route53.yml" )
}
