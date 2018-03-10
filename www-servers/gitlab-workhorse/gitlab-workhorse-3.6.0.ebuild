# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# golang-vcs-snapshot doesn't support gitlab uri scheme, keep sources from gitlab as is
EGO_VENDOR=( "github.com/BurntSushi/toml a368813c5e648fee92e5f6c30e3944ff9d5e8895"
	"github.com/FZambia/go-sentinel 76bd05e8e22f9f8f5e1dd6d3a85b7951da7cce57"
	"github.com/garyburd/redigo a7327d8ced8067e916e7e35490522fd0182fa839"
	"github.com/beorn7/perks 4c0e84591b9aa9e6dcfdf3e020114cd81f89d5f9"
	"github.com/certifi/gocertifi ec89d50f00d39494f5b3ec5cf2fe75c53467a937"
	"github.com/client9/reopen 4b86f9c0ead51cc410d05655596e30f281ed9071"
	"github.com/dgrijalva/jwt-go d2709f9f1f31ebcda9651b03077758c1f3a0018c"
	"github.com/getsentry/raven-go 379f8d0a68ca237cf8893a1cdfd4f574125e2c51"
	"github.com/gorilla/websocket e8f0f8aaa98dfb6586cbdf2978d511e3199a960a"
	"github.com/grpc-ecosystem/go-grpc-prometheus 0dafe0d496ea71181bf2dd039e7e3f44b6bd11a7"
	"github.com/jfbus/httprs 32cf48c14a79f94eb3d8100efc00e773c5c8b160"
	"github.com/jpillora/backoff 06c7a16c845dc8e0bf575fafeeca0f5462f5eb4d"
	"github.com/matttproud/golang_protobuf_extensions c12348ce28de40eed0136aa2b644d0ee0650e56c"
	"github.com/mitchellh/copystructure f81071c9d77b7931f78c90b416a074ecdc50e959"
	"github.com/mitchellh/reflectwalk 8d802ff4ae93611b807597f639c19f76074df5c6"
	"github.com/pmezard/go-difflib 792786c7400a136282c1664665ae0a8db921c6c2"
	"github.com/prometheus/client_golang e83345f73f5e7434173fbc1ffd26e2d7f70aff3f"
	"github.com/prometheus/common 0d5de9d6d8629cb8bee6d4674da4127cd8b615a3"
	"github.com/prometheus/procfs abf152e5f3e97f2fafac028d2cc06c1feb87ffa5"
	"github.com/rafaeljusto/redigomock 46f70867da7b79c74c21ef022c4a47f138af3d27"
	"github.com/stretchr/testify 18a02ba4a312f95da08ff4cfc0055750ce50ae9e"
#	"gitlab.com/gitlab-org/gitaly-proto e3cc4aa1f29786b725db87b5f55f15aeb8670555"
#	"gitlab.com/gitlab-org/gitaly 95a198aef54c42fd8e84c62acc63f0cd620864b3"
	"google.golang.org/genproto f676e0f3ac6395ff1a529ae59a6670878a8371a6 github.com/google/go-genproto"
	"google.golang.org/grpc 7cea4cc846bcf00cbb27595b07da5de875ef7de9 github.com/grpc/grpc-go" )

EGO_PN="gitlab.com/gitlab-org/${PN}"

inherit eutils golang-vcs-snapshot systemd tmpfiles user

DESCRIPTION="GitLab reverse proxy"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-workhorse"
SRC_URI="https://${EGO_PN}/repository/archive.tar.bz2?ref=v${PV} -> ${P}.tar.bz2
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# dev-go/toml doesn't provide sources
# dev-go/go-protobuf is too old, use bundled version
# dev-go/go-net is too old, use bundled version
DEPEND="dev-lang/go:=
	dev-go/go-spew:="
RDEPEND="${DEPEND}
	app-admin/logrotate"

S="${WORKDIR}/${P}/src/${EGO_PN}"

RESTRICT="mirror"

pkg_setup() {
	enewgroup gitlab
	enewuser workhorse -1 -1 -1 gitlab
}

src_prepare() {
	default

	# Change PREFIX, use a ${PV} instead of 'git describe',
	# append path to go libs and reexport GOROOT after PATH
	sed -i \
		-e '/PREFIX=/s|/local||' \
		-e '/VERSION=/s|$(shell git describe)|@VERSION@|' \
		-e "/VERSION=/s|@VERSION@|v${PV}|" \
		-e '/export PATH:=${GOPATH}\/bin:${PATH}/a export GOPATH=${BUILD_DIR}/_build:/usr/lib/go-gentoo' \
		Makefile || die "sed failed"
	# Remove bundled libs to use provided by portage
	rm -rf vendor/github.com/davecgh || die "failed to remove dirs"
	# Remove it when recent version of dev-go/go-protobuf will be in portage
	#rm -rf vendor/github.com/golang || die "failed to remove dirs"
	# Remove it when recent version of dev-go/go-net will be in portage
	#rm -rf vendor/golang.org || die "failed to remove golang.org"
}

src_install() {
	default

	keepdir /var/log/"${PN}"
	fowners workhorse:gitlab /var/log/"${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/"${PN}".logrotate "${PN}"

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
	newtmpfiles "${FILESDIR}"/"${PN}".tmpfile "${PN}".conf
}

pkg_postinst() {
	tmpfiles_process "${PN}".conf
}
