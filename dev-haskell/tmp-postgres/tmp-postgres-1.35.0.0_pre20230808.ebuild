# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
POSTGRES_COMPAT=( {14..18} )
POSTGRES_USEDEP="server"

inherit haskell-cabal postgres

COMMIT="7f2467a6d6d5f6db7eed59919a6773fe006cf22b"

DESCRIPTION="Create temporary postgres instances"
HOMEPAGE="https://github.com/jfischoff/tmp-postgres"
SRC_URI="https://github.com/jfischoff/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"
CABAL_FILE="${S}/${PN}".cabal

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="${POSTGRES_DEP}
	dev-haskell/async:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/cryptohash-sha1:=[profile?]
	dev-haskell/generic-monoid:=[profile?]
	dev-haskell/port-utils:=[profile?]
	dev-haskell/postgres-options:=[profile?]
	dev-haskell/postgresql-simple:=[profile?]
	dev-haskell/prettyprinter:=[profile?]
	dev-haskell/temporary:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal
	test? ( dev-haskell/hspec
		dev-haskell/network )"

PATCHES=( "${FILESDIR}/${PN}"-1.35.0.0_pre20230808-tests.patch )

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' tmp-postgres.cabal || die "sed failed"
}

src_test() {
	# tmp-postgres prefers TMP over TMPDIR. Portage's TMP is too long
	# for PostgreSQL's 107-byte Unix-domain socket path limit.
	TMP=/tmp haskell-cabal_src_test
}
