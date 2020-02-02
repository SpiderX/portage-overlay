# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/aws/aws-sdk-go v1.12.78"
	"github.com/cenkalti/backoff v1.1.0"
	"github.com/go-ini/ini v1.32.0"
	"github.com/google/gops v0.3.2"
	"github.com/hashicorp/errwrap 7554cd9344ce"
	"github.com/hashicorp/go-multierror b7773ae21874"
	"github.com/jmespath/go-jmespath 0b12d6b521d8"
	"github.com/kardianos/osext ae77be60afb1"
	"github.com/posener/complete dc2bc5a81acc"
	"github.com/termie/go-shutil bcacb06fecae"
	"golang.org/x/net d8887717615a github.com/golang/net" )

EGO_PN="github.com/peak/${PN}"

inherit go-module

DESCRIPTION="Parallel S3 and local filesystem execution tool"
HOMEPAGE="https://github.com/peak/s5cmd"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin s5cmd
}
