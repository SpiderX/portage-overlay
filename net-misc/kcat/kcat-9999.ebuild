# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/edenhill/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Generic command line non-JVM Apache Kafka producer and consumer"
HOMEPAGE="https://github.com/edenhill/kcat"

LICENSE="BSD-2"
SLOT="0"
IUSE="+avro +json"
RESTRICT="test" # needs kafka brokers

DEPEND="dev-libs/librdkafka:0=
	avro? (
		dev-libs/avro-c
		dev-libs/libserdes
	)
	json? ( dev-libs/yajl:0= )"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# Compatibility with portage econf arg
	echo 'mkl_toggle_option "kcat" WITH_STATIC --disable-static "Static" y' \
		>> configure.self || die "echo failed"
	# Install man page
	sed -i '/INSTALL/s/echo //' Makefile || die "sed failed"
}

src_configure() {
	econf "$(use_enable avro)" "$(use_enable json)" --cc="$(tc-getCC)"
}
