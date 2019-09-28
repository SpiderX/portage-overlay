# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/BurntSushi/toml v0.3.1"
	"github.com/emirpasic/gods v1.12.0"
	"github.com/franela/goblin ead4ad1d27278780bab074b8dee47fba0e67afda"
	"github.com/google/go-github e48060a28fac52d0f1cb758bc8b87c07bac4a87d"
	"github.com/google/go-querystring v1.0.0"
	"github.com/hako/durafmt 7b7ae1e72eade09dbc9c2cfba3e6c4bae7b8bcac"
	"github.com/ipfs/go-ipfs v0.4.19"
	"github.com/kevinburke/ssh_config 81db2a75821ed34e682567d48be488a1c3121088"
	"github.com/jbenet/go-context d14ea06fba99483203c19d92cfcd13ebe73135f4"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-isatty v0.0.8"
	"github.com/mitchellh/go-homedir v1.0.0"
	"github.com/onsi/ginkgo v1.8.0"
	"github.com/onsi/gomega v1.5.0"
	"github.com/pelletier/go-buffruneio v0.2.0"
	"github.com/sergi/go-diff v1.0.0"
	"github.com/sirupsen/logrus v1.0.6"
	"github.com/src-d/gcfg v1.4.0"
	"github.com/xanzy/go-gitlab v0.11.3"
	"github.com/xanzy/ssh-agent v0.2.0"
	"golang.org/x/oauth2 f720f1faee02c1fb456408c22886169405f239aa github.com/golang/oauth2"
	"gopkg.in/src-d/go-billy.v4 v4.3.0 github.com/src-d/go-billy"
	"gopkg.in/src-d/go-git.v4 v4.9.1 github.com/src-d/go-git"
	"gopkg.in/warnings.v0 v0.1.2 github.com/go-warnings/warnings" )

EGO_PN="github.com/zricethezav/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Auditing git repository for secrets and keys"
HOMEPAGE="https://github.com/zricethezav/gitleaks"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-go/go-crypto:=
	dev-go/go-net:=
	dev-go/go-sys:=
	dev-go/go-text:="
RDEPEND="${DEPEND}"

DOCS=( src/"${EGO_PN}"/README.md )

src_install() {
	einstalldocs
	dobin gitleaks
	insinto /etc/gitleaks
	doins src/"${EGO_PN}"/gitleaks.toml
}
