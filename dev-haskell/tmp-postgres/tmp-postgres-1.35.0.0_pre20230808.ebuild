# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

COMMIT="7f2467a6d6d5f6db7eed59919a6773fe006cf22b"

DESCRIPTION="Create temporary postgres instances"
HOMEPAGE="https://github.com/jfischoff/tmp-postgres"
SRC_URI="https://github.com/jfischoff/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"
CABAL_FILE="${S}/${PN}".cabal

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # https://github.com/jfischoff/tmp-postgres/issues/283

RDEPEND="dev-haskell/async:=[profile?]
	dev-haskell/base64-bytestring:=[profile?]
	dev-haskell/cryptohash-sha1:=[profile?]
	dev-haskell/generic-monoid:=[profile?]
	dev-haskell/port-utils:=[profile?]
	dev-haskell/postgres-options:=[profile?]
	dev-haskell/postgresql-simple:=[profile?]
	dev-haskell/prettyprinter:=[profile?]
	dev-haskell/temporary:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/network:=[profile?] )"

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' tmp-postgres.cabal || die "sed failed"
}
