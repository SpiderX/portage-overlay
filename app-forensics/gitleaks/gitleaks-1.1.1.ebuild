# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/BurntSushi/toml b26d9c308763d68093482582cea63d69be07a0f0"
"github.com/emirpasic/gods f6c17b524822278a87e3b3bd809fec33b51f5b46"
"github.com/franela/goblin cd5d08fb4ede9eaac1812fdb513552e7404eae2e"
"github.com/google/go-github e48060a28fac52d0f1cb758bc8b87c07bac4a87d"
"github.com/google/go-querystring 53e6ce116135b80d037921a7fdd5138cf32d7a8a"
"github.com/jbenet/go-context d14ea06fba99483203c19d92cfcd13ebe73135f4"
"github.com/jessevdk/go-flags c6ca198ec95c841fdb89fc0de7496fed11ab854e"
"github.com/kevinburke/ssh_config 9fc7bb800b555d63157c65a904c86a2cc7b4e795"
"github.com/mitchellh/go-homedir 3864e76763d94a6df2f9960b16a20a33da9f9a66"
"github.com/pelletier/go-buffruneio c37440a7cf42ac63b919c752ca73a85067e05992"
"github.com/sergi/go-diff 1744e2970ca51c86172c8190fadad617561ed6e7"
"github.com/sirupsen/logrus c155da19408a8799da419ed3eeb0cb5db0ad5dbc"
"github.com/src-d/gcfg f187355171c936ac84a82793659ebb4936bc1c23"
"github.com/xanzy/ssh-agent 640f0ab560aeb89d523bb6ac322b1244d5c3796c"
"google.golang.org/appengine b1f26356af11148e710935ed1ac8a7f5702c7612 github.com/golang/appengine"
"gopkg.in/src-d/go-billy.v4 83cf655d40b15b427014d7875d10850f96edba14 github.com/src-d/go-billy"
"gopkg.in/src-d/go-git.v4 3bd5e82b2512d85becae9677fa06b5a973fd4cfb github.com/src-d/go-git"
"gopkg.in/warnings.v0 ec4a0fea49c7b46c2aeb0b51aac55779c607e52b github.com/go-warnings/warnings" )

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

# dev-go/toml doesn't provide sources
DEPEND="dev-go/go-net:=
	dev-go/go-oauth2:=
	dev-go/go-protobuf:=
	dev-go/go-text:="
RDEPEND="${DEPEND}"

DOCS=( src/"${EGO_PN}"/README.md )

src_prepare() {
	default

	# dev-go/crypto and dev-go/sys are too old
	rm -r src/"${EGO_PN}"/vendor/golang.org/x/{net,oauth2,text} \
		|| die "remove failed"
}

src_install() {
	einstalldocs
	dobin "${PN}"
	insinto /etc/"${PN}"
	doins src/"${EGO_PN}"/"${PN}".toml
}
