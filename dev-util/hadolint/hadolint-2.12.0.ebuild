# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Dockerfile linter, validate inline bash"
HOMEPAGE="https://github.com/hadolint/hadolint"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/colourista:=[profile?]
	dev-haskell/cryptonite:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/email-validate:=[profile?]
	dev-haskell/foldl:=[profile?]
	dev-haskell/gitrev:=[profile?]
	dev-haskell/hsyaml:=[profile?]
	dev-haskell/ilist:=[profile?]
	dev-haskell/language-docker:=[profile?]
	dev-haskell/megaparsec:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/network-uri:=[profile?]
	dev-haskell/optparse-applicative:=[profile?]
	dev-haskell/parallel:=[profile?]
	dev-haskell/parsec:=[profile?]
	dev-haskell/prettyprinter:=[profile?]
	dev-haskell/semver:=[profile?]
	dev-haskell/spdx:=[profile?]
	dev-haskell/split:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/timerep:=[profile?]
	dev-haskell/void:=[profile?]
	dev-haskell/xml-conduit:=[profile?]
	dev-util/shellcheck:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/silently:=[profile?] )"

PATCHES=( "${FILESDIR}/${PN}"-2.12.0-language-docker.patch )

CABAL_CHDEPS=(
	'language-docker >=11.0.0 && <12' 'language-docker >=11.0.0'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hadolint.cabal || die "sed failed"
}

src_configure() {
	haskell-cabal_src_configure --flag=-static
}
