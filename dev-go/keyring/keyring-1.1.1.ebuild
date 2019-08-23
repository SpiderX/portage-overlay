# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/danieljoos/wincred b892d337201d1400370ebf4fa919941c9ea222ee"
	"github.com/dvsekhvalnov/jose2go 7f401d37b68add7a984afa734c3751a4e91c3502"
	"github.com/godbus/dbus 4481cbc300e2df0c0b3cecc18b6c16c6c0bb885d"
	"github.com/gsterjov/go-libsecret a6f4afe4910cad8688db3e0e9b9ac92ad22d54e1"
	"github.com/keybase/go-keychain 48d3d31d256d9922a90b14c518c4b685f321fab2"
	"github.com/kr/pretty 73f6ac0b30a98e433b289500d779f50c1a6f0712"
	"github.com/mitchellh/go-homedir af06845cf3004701891bf4fdb884bfe4920b3727"
	"github.com/stretchr/objx ea4fe68685ee0d3cee7032121851b57e7494e8ea"
	"gopkg.in/check.v1 788fd78401277ebd861206a03c884797c6ec5541 github.com/go-check/check")
EGO_PN="github.com/99designs/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Library with uniform interface across a range of secure credential stores"
HOMEPAGE="https://github.com/99designs/keyring"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-go/go-crypto:=
	dev-go/go-sys:="
RDEPEND="${DEPEND}"
BDEPEND="test? ( app-admin/pass
		app-crypt/libsecret
		sys-apps/dbus )"

src_test() {
	GOPATH="${S}:/usr/lib/go-gentoo" go test -v -work -x ./... \
		|| die "tests failed"
}
