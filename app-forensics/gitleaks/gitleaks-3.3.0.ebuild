# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/BurntSushi/toml v0.3.1"
	"github.com/emirpasic/gods v1.12.0"
	"github.com/golang/protobuf v1.2.0"
	"github.com/google/go-github v17.0.0"
	"github.com/google/go-querystring v1.0.0"
	"github.com/hako/durafmt 3f39dc1ed9f4"
	"github.com/jbenet/go-context d14ea06fba99"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/kevinburke/ssh_config 01f96b0aa0cd"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-isatty v0.0.8"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/sergi/go-diff v1.0.0"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/src-d/gcfg v1.4.0"
	"github.com/xanzy/go-gitlab v0.21.0"
	"github.com/xanzy/ssh-agent v0.2.1"
	"golang.org/x/crypto 4def268fd1a4 github.com/golang/crypto"
	"golang.org/x/net ca1201d0de80 github.com/golang/net"
	"golang.org/x/oauth2 0f29369cfe45 github.com/golang/oauth2"
	"golang.org/x/sys fc99dfbffb4e github.com/golang/sys"
	"google.golang.org/appengine v1.4.0 github.com/golang/appengine"
	"gopkg.in/src-d/go-billy.v4 v4.3.2 github.com/src-d/go-billy"
	"gopkg.in/src-d/go-git.v4 v4.13.1 github.com/src-d/go-git"
	"gopkg.in/warnings.v0 v0.1.2 github.com/go-warnings/warnings" )

EGO_PN="github.com/zricethezav/${PN}"

inherit go-module

DESCRIPTION="Auditing git repository for secrets and keys"
HOMEPAGE="https://github.com/zricethezav/gitleaks"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin gitleaks
}
