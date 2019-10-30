# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/danieljoos/wincred v1.0.2"
	"github.com/dvsekhvalnov/jose2go 7f401d37b68a"
	"github.com/godbus/dbus 4481cbc300e2"
	"github.com/gsterjov/go-libsecret a6f4afe4910c"
	"github.com/keybase/go-keychain 48d3d31d256d"
	"github.com/mitchellh/go-homedir v1.1.0"
	"golang.org/x/crypto 4def268fd1a4 github.com/golang/crypto"
	"golang.org/x/sys fae7ac547cb7 github.com/golang/sys" )
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

RDEPEND="${DEPEND}"
BDEPEND="test? ( app-admin/pass
		app-crypt/libsecret
		sys-apps/dbus )"

src_test() {
	GOPATH="${S}:/usr/lib/go-gentoo" go test -v -work -x ./... \
		|| die "tests failed"
}
