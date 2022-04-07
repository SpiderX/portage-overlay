# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools readme.gentoo-r1 systemd linux-info

MY_PN="${PN//-aws/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Patched OpenVPN with SAML support for AWS Client VPN"
HOMEPAGE="https://openvpn.net https://github.com/AnilRedshift/awsvpn-saml
	https://github.com/samm-git/aws-vpn-client"
SRC_URI="https://build.openvpn.net/downloads/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="down-root inotify iproute2 +lz4 +lzo mbedtls +openssl
	pam pkcs11 +plugins selinux systemd test"

RESTRICT="!test? ( test )"
REQUIRED_USE="^^ ( openssl mbedtls )
	pkcs11? ( !mbedtls )
	!plugins? ( !pam !down-root )
	inotify? ( plugins )"

CDEPEND="kernel_linux? ( iproute2? ( sys-apps/iproute2[-minimal] ) )
	lz4? ( app-arch/lz4:0= )
	lzo? ( dev-libs/lzo:2 )
	mbedtls? ( net-libs/mbedtls:= )
	openssl? ( dev-libs/openssl:0= )
	pam? ( sys-libs/pam )
	pkcs11? ( dev-libs/pkcs11-helper )
	systemd? ( sys-apps/systemd )"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	acct-group/openvpn
	acct-user/openvpn
	net-dns/bind-tools
	selinux? ( sec-policy/selinux-openvpn )"
BDEPEND="virtual/pkgconfig
	dev-lang/go:0=
	test? ( dev-util/cmocka )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/openvpn-2.5.0-auth-pam-missing-header.patch
	"${FILESDIR}"/openvpn-2.5.2-detect-python-rst2man.patch
	"${FILESDIR}"/openvpn-2.5.2-aws.patch
	"${FILESDIR}"/openvpn-2.5.2-skip-broken-tests.patch
)

QA_FLAGS_IGNORED="usr/bin/awsvpnserver"

CONFIG_CHECK="~TUN"

DOC_CONTENTS="1. Remove 'auth-federate' from OVPN configuration.\\n
2. Run 'awsvpn configure' from user shell.\\n
3. Run 'awsvpn' from user shell.\\n"

src_prepare() {
	default

	# https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19302.html
	sed -i '/^CONFIGURE_DEFINES=/s/set/env/g' configure.ac || die "sed failed"

	eautoreconf
}

src_compile() {
	default

	go build -o awsvpnserver "${FILESDIR}"/main.go || die "go build failed"
}

src_configure() {
	local -a myeconfargs

	if ! use mbedtls; then
		myeconfargs+=(
			"$(use_enable pkcs11)"
		)
	fi

	myeconfargs+=(
		"$(use_enable inotify async-push)"
		--with-crypto-library="$(usex mbedtls mbedtls openssl)"
		"$(use_enable lz4)"
		"$(use_enable lzo)"
		"$(use_enable plugins)"
		"$(use_enable iproute2)"
		"$(use_enable pam plugin-auth-pam)"
		"$(use_enable down-root plugin-down-root)"
		"$(use_enable systemd)"
	)

	SYSTEMD_UNIT_DIR="$(systemd_get_systemunitdir)" \
		TMPFILES_DIR="/usr/lib/tmpfiles.d" \
		IPROUTE="$(usex iproute2 '/bin/ip' '')" \
		econf "${myeconfargs[@]}"
}

src_test() {
	local -x RUN_SUDO=false

	emake check
	pushd tests/unit_tests &>/dev/null || die
	emake check
	popd &>/dev/null || die
}

src_install() {
	newsbin src/openvpn/openvpn openvpn-aws
	dobin awsvpnserver "${FILESDIR}"/awsvpn
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
