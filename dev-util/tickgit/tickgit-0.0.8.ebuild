# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/agext/levenshtein v1.2.2"
	"github.com/apparentlymart/go-textseg v1.0.0"
	"github.com/augmentable-dev/lege 79cb985065a1"
	"github.com/briandowns/spinner v1.8.0"
	"github.com/dustin/go-humanize v1.0.0"
	"github.com/emirpasic/gods v1.12.0"
	"github.com/fatih/color v1.7.0"
	"github.com/google/go-cmp v0.3.1"
	"github.com/hashicorp/hcl/v2 v2.2.0 github.com/hashicorp/hcl"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jbenet/go-context d14ea06fba99"
	"github.com/karrick/godirwalk v1.13.4"
	"github.com/kevinburke/ssh_config 01f96b0aa0cd"
	"github.com/mattn/go-colorable v0.1.4"
	"github.com/mattn/go-isatty v0.0.11"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-wordwrap v1.0.0"
	"github.com/sergi/go-diff v1.1.0"
	"github.com/spf13/cobra v0.0.5"
	"github.com/spf13/pflag v1.0.5"
	"github.com/src-d/enry/v2 v2.1.0 github.com/src-d/enry"
	"github.com/src-d/gcfg v1.4.0"
	"github.com/src-d/go-oniguruma v1.1.0"
	"github.com/toqueteos/trie v1.0.0"
	"github.com/xanzy/ssh-agent v0.2.1"
	"github.com/zclconf/go-cty v1.2.0"
	"golang.org/x/crypto 53104e6ec876 github.com/golang/crypto"
	"golang.org/x/net c0dbc17a3553 github.com/golang/net"
	"golang.org/x/sys 04cbcbbfeed8 github.com/golang/sys"
	"golang.org/x/text v0.3.2 github.com/golang/text"
	"gopkg.in/src-d/go-billy.v4 v4.3.2 github.com/src-d/go-billy"
	"gopkg.in/src-d/go-git.v4 v4.13.1 github.com/src-d/go-git"
	"gopkg.in/toqueteos/substring.v1 v1.0.2 github.com/toqueteos/substring"
	"gopkg.in/warnings.v0 v0.1.2 github.com/go-warnings/warnings" )

EGO_PN="github.com/augmentable-dev/${PN}"

inherit go-module

DESCRIPTION="Manage your repository's TODOs as config in your codebase"
HOMEPAGE="https://github.com/augmentable-dev/tickgit"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build -o tickgit ./cmd/main.go || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin tickgit
}
