# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic git-r3 readme.gentoo-r1 systemd

DESCRIPTION="Internet Key Exchange version 2 (IKEv2) daemon"
HOMEPAGE="https://github.com/openiked/openiked-portable"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="ISC"
SLOT="0"
IUSE="apparmor debug test"
RESTRICT="!test? ( test )"

RDEPEND="acct-group/_iked
	acct-user/_iked
	dev-libs/libevent:0=
	dev-libs/openssl:0=
	apparmor? ( sys-apps/apparmor )"

DOC_CONTENTS="Create a key pair if not already present:\\n
openssl ecparam -genkey -name prime256v1 -noout -out /etc/iked/private/local.key\\n
openssl ec -in /etc/iked/private/local.key -pubout -out /etc/iked/local.pub\\n\\n"

src_prepare() {
	sed -i '/        -O2/d' {compat,ikectl,iked}/CMakeLists.txt \
		|| die "sed failed for compat/CMakeLists.txt"

	if ! use test ; then
		sed -i '/regress\/dh/,+5d' CMakeLists.txt \
			|| die "sed failed for CMakeLists.txt"
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
		-DWITH_APPARMOR="$(usex apparmor)"
	)

	use test && append-cflags -mcmodel=large

	cmake_src_configure
}

src_test() {
	cmake_src_test

	pushd "${S}"_build/regress/dh || die "dh pushd failed"
	./dhtest || die "dhtest failed"
	popd || die "dh popd failed"
	pushd "${S}"_build/regress/parser || die "parser pushd failed"
	./test_parser || die "test_parser failed"
	popd || die "parser popd failed"
}

src_install() {
	cmake_src_install

	newinitd "${FILESDIR}"/openiked.initd openiked
	newconfd "${FILESDIR}"/openiked.confd openiked
	systemd_dounit "${FILESDIR}"/openiked.service

	keepdir /etc/iked/{ca,certs,crls,private,pubkeys} \
		/etc/iked/pubkeys/{ipv4,ipv6,fqdn,ufqdn}

	fperms 0700 /etc/iked/private
	fowners -R _iked:_iked /etc/iked

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
