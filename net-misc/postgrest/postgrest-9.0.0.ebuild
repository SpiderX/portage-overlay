# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal readme.gentoo-r1 systemd

DESCRIPTION="REST API for any Postgres database"
HOMEPAGE="https://github.com/PostgREST/postgrest"
SRC_URI="https://github.com/PostgREST/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="acct-user/postgrest
	dev-haskell/aeson:=[profile?]
	dev-haskell/ansi-wl-pprint:=[profile?]
	dev-haskell/auto-update:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/case-insensitive:=[profile?]
	dev-haskell/cassava:=[profile?]
	dev-haskell/configurator-pg:=[profile?]
	dev-haskell/contravariant:=[profile?]
	dev-haskell/contravariant-extras:=[profile?]
	dev-haskell/cookie:=[profile?]
	dev-haskell/either:=[profile?]
	dev-haskell/fast-logger:=[profile?]
	dev-haskell/gitrev:=[profile?]
	dev-haskell/hasql:=[profile?]
	dev-haskell/hasql-dynamic-statements:=[profile?]
	dev-haskell/hasql-notifications:=[profile?]
	dev-haskell/hasql-pool:=[profile?]
	dev-haskell/hasql-transaction:=[profile?]
	dev-haskell/heredoc:=[profile?]
	dev-haskell/http:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/insert-ordered-containers:=[profile?]
	dev-haskell/interpolatedstring-perl6:=[profile?]
	dev-haskell/jose:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/lens-aeson:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-haskell/network-2.6:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/protolude:=[profile?]
	dev-haskell/Ranged-sets:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/retry:=[profile?]
	dev-haskell/scientific:=[profile?]
	dev-haskell/swagger2:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-haskell/vector:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-haskell/wai-cors:=[profile?]
	dev-haskell/wai-extra:=[profile?]
	dev-haskell/wai-logger:=[profile?]
	dev-haskell/wai-middleware-static:=[profile?]
	dev-haskell/warp:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]
	test? ( dev-haskell/aeson-qq:=[profile?]
		dev-haskell/async:=[profile?]
		dev-haskell/doctest:=[profile?]
		dev-haskell/hspec:=[profile?]
		dev-haskell/hspec-wai:=[profile?]
		dev-haskell/hspec-wai-json:=[profile?]
		dev-haskell/monad-control:=[profile?]
		dev-haskell/pretty-simple:=[profile?]
		dev-haskell/transformers-base:=[profile?] )"

DOC_CONTENTS="Sample configuration: /etc/postgrest/postgrest.conf.sample.
Copy it to /etc/postgrest/postgrest.conf to run PostgREST."

src_prepare() {
	default

	sed  -i -e '/license-file/d' \
		-e '/ghc-options:        /s/-Werror //' \
		-e '/                      -O2/s/-Werror //' \
		postgrest.cabal || die "sed failed"
}

src_test() {
	set -- test "--show-details=streaming" "$@"
	echo ./setup "$@" || die "echo failed"
	test/with_tmp_db ./setup "$@" || die "cabal test failed"
}

src_install() {
	echo "LD_LIBRARY_PATH is ${LD_LIBRARY_PATH}, ED is ${ED}"
	export LD_LIBRARY_PATH="${ED}${LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
	haskell-cabal_src_install

	newinitd "${FILESDIR}"/postgrest.initd postgrest
	newconfd "${FILESDIR}"/postgrest.confd postgrest
	systemd_dounit "${FILESDIR}"/postgrest.service

	readme.gentoo_create_doc

	# Generate sample config
	insopts -o postgrest -g postgrest -m 0644
	insinto /etc/postgrest
	newins - postgrest.conf.sample < <("${ED}"/usr/bin/postgrest -e \
		|| die "posgrest failed for postgrest.conf.sample" )
	diropts -o postgrest -g postgrest -m 0750
	keepdir /var/log/postgrest
}

pkg_postinst() {
	haskell-cabal_pkg_postinst
	readme.gentoo_print_elog
}
