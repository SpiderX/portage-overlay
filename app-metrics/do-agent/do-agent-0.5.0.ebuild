# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/agl/ed25519 278e1ec8e8a6e017cd07577924d6766039146ced"
	"github.com/boltdb/bolt 5cc10bbbc5c141029940133bb33c9e969512a698"
	"github.com/digitalocean/go-metadata a6cf11fb1bf59df1976e32f3c5facf33f74fbfe9"
	"github.com/flynn/go-tuf 82ed8591c2f9fa5170479d252ac4d81be49c6496"
	"github.com/gogo/protobuf f20a1444730c7d9949b880a0309e737d007def25"
	"github.com/ianschenck/envflag 9111d830d133f952887a936367fb0211c3134f0d"
	"github.com/jpillora/backoff 0496a6c14df020789376f4d4a261273d5ddb36ec"
	"github.com/prometheus/procfs 406e5b7bfd8201a36e2bb5f7bdae0b03380c2ce8"
	"github.com/tent/canonical-json-go 96e4ba3a7613a1216cbd1badca4efe382adea337" )

EGO_PN="github.com/digitalocean/${PN}"

inherit golang-build golang-vcs-snapshot systemd

DESCRIPTION="DigitalOcean Agent for Enhanced Droplet Graphs"
HOMEPAGE="https://github.com/digitalocean/do-agent"
SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# dev-go/gogo-protobuf no source
DEPEND="dev-go/go-sys:="
RDEPEND="${DEPEND}"

src_compile() {
	LDFLAGS="-X github.com/digitalocean/do-agent/config.build=${PV}
		-X github.com/digitalocean/do-agent/config.version=${PV}
		-extldflags -static"

	pushd src/"${EGO_PN}" || die "pushd failed"
	GOPATH="${S}:$(get_golibdir_gopath)" go build -v -ldflags "${LDFLAGS}" \
		-o do-agent cmd/do-agent/main.go || die "go build failed"
	popd || die "popd failed"
}

src_test() {
	GOPATH="${S}:$(get_golibdir_gopath)" go test -v ./... \
		|| die "tests failed"
}

src_install() {
	dobin src/"${EGO_PN}"/do-agent

	newinitd "${FILESDIR}"/do-agent.initd do-agent
	newconfd "${FILESDIR}"/do-agent.confd do-agent
	systemd_dounit "${FILESDIR}"/do-agent.service
}
