# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/BurntSushi/toml 3012a1dbe2e4bd1391d42b32f0577cb7bbc7f005"
	"github.com/apex/log 0296d6eb16bb28f8a0c55668affcf4876dc269be"
	"github.com/blang/semver 2ee87856327ba09384cabd113bc6b5d174e9ec0f"
	"github.com/bmatcuk/doublestar 85a78806aa1b4707d1dbace9be592cf1ece91ab3"
	"github.com/briandowns/spinner 9f016caa1359c8ecdc1d95243e92c0d28b524368"
	"github.com/cheekybits/genny d2cf3cdd35ce0d789056c4bc02a4d6349c947caf"
	"github.com/emirpasic/gods 1615341f118ae12f353cc8a983f35b584342c9b3"
	"github.com/fatih/color 5b77d2a35fb0ede96d138fc9a99f5c9b6aef11b4"
	"github.com/gnewton/jargo 41f5f186a80591040a864150c28f5b1105a34e12"
	"github.com/google/go-github f55b50f38167644bb7e4be03d9a2bde71d435239"
	"github.com/google/go-querystring 44c6ddd0a2342c386950e880b658017258da92fc"
	"github.com/inconshreveable/go-update 8152e7eb6ccf8679a64582a66b78519688d156ad"
	"github.com/jbenet/go-context d14ea06fba99483203c19d92cfcd13ebe73135f4"
	"github.com/kevinburke/ssh_config 81db2a75821ed34e682567d48be488a1c3121088"
	"github.com/mattn/go-colorable 167de6bfdfba052fa6b2d3664c8f5272e23c9072"
	"github.com/mattn/go-isatty 6ca4dbf54d38eea1a992b3c722a76a5d1c4cb25c"
	"github.com/mitchellh/go-homedir ae18d6b8b3205b561c79e8e5f69bff09736185f4"
	"github.com/mitchellh/mapstructure fa473d140ef3c6adf42d6b391fe76707f1f243c8"
	"github.com/pelletier/go-buffruneio c37440a7cf42ac63b919c752ca73a85067e05992"
	"github.com/pkg/errors 645ef00459ed84a119197bfb8d8205042c6df63d"
	"github.com/pmezard/go-difflib 792786c7400a136282c1664665ae0a8db921c6c2"
	"github.com/rhysd/go-github-selfupdate 4bfc1aa0302c89605b9bf20a8bb4e1af625bc714"
	"github.com/rveen/ogdl 9c9b3105ea3ec8a13b76adc11b81e419995fe2e0"
	"github.com/sergi/go-diff 1744e2970ca51c86172c8190fadad617561ed6e7"
	"github.com/src-d/gcfg f187355171c936ac84a82793659ebb4936bc1c23"
	"github.com/stretchr/testify f35b8ab0b5a2cef36673838d662e249dd9c94686"
	"github.com/tcnksm/go-gitconfig d154598bacbf4501c095a309753c5d4af66caa81"
	"github.com/ulikunitz/xz 0c6b41e72360850ca4f98dc341fd999726ea007f"
	"github.com/urfave/cli cfb38830724cc34fedffe9a2a29fb54fa9169cd1"
	"github.com/xanzy/ssh-agent 640f0ab560aeb89d523bb6ac322b1244d5c3796c"
	"google.golang.org/appengine ae0ab99deb4dc413a2b4bd6c8bdd0eb67f1e4d06 github.com/golang/appengine"
	"gopkg.in/src-d/go-billy.v4 982626487c60a5252e7d0b695ca23fb0fa2fd670 github.com/src-d/go-billy"
	"gopkg.in/src-d/go-git.v4 d3cec13ac0b195bfb897ed038a08b5130ab9969e github.com/src-d/go-git"
	"gopkg.in/warnings.v0 ec4a0fea49c7b46c2aeb0b51aac55779c607e52b github.com/go-warnings/warnings"
	"gopkg.in/yaml.v2 5420a8b6744d3b0345ab293f6fcba19c978f1183 github.com/go-yaml/yaml" )

EGO_PN="github.com/fossas/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="License and vulnerability analysis"
HOMEPAGE="https://github.com/fossas/fossa-cli"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# dev-go/toml doesn't provide sources
DEPEND="dev-go/go-crypto:=
	dev-go/go-net:=
	dev-go/go-oauth2:=
	dev-go/go-protobuf:=
	dev-go/go-sys:=
	dev-go/go-text:="
RDEPEND="${DEPEND}"

src_compile() {
	LDFLAGS="-extldflags -static -X github.com/fossas/fossa-cli/cmd/fossa/version.version=${PV}"
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" go build -v -ldflags="${LDFLAGS}" \
		-o fossa "${EGO_PN}"/cmd/fossa || die
}

src_install() {
	dobin fossa
}
