# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"

inherit haskell-cabal

DESCRIPTION="Dockerfile linter, validate inline bash"
HOMEPAGE="https://github.com/hadolint/hadolint"

LICENSE="GPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/base16-bytestring:=[profile?]
	dev-haskell/cabal:=[profile?]
	dev-haskell/colourista:=[profile?]
	dev-haskell/cryptohash-sha1:=[profile?]
	dev-haskell/data-default:=[profile?]
	dev-haskell/email-validate:=[profile?]
	dev-haskell/foldl:=[profile?]
	dev-haskell/gitrev:=[profile?]
	dev-haskell/hsyaml:=[profile?]
	dev-haskell/ilist:=[profile?]
	dev-haskell/language-docker:=[profile?]
	dev-haskell/megaparsec:=[profile?]
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
	dev-util/shellcheck:=[profile?]"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=
	test? ( dev-haskell/hspec:=[profile?]
		dev-haskell/hunit:=[profile?]
		dev-haskell/silently:=[profile?] )"

CABAL_CHDEPS=(
	'Cabal                 >=3.12.1   && <3.13' 'Cabal                 >=3.10'
	'base                  >=4.20.1   && <5' 'base                  >=4.13'
	'base                  >=4.20.1    && <5' 'base                  >=4.13    && <5'
	'bytestring            >=0.12.2   && <0.13' 'bytestring            >=0.10'
	'containers            >=0.7      && <0.8' 'containers            >=0.6'
	'containers            >=0.7       && <0.8' 'containers            >=0.6'
	'filepath              >=1.5.4    && <1.6' 'filepath              >=1.4'
	'megaparsec            >=9.7.0     && <9.8' 'megaparsec            >=9.5.0     && <9.8'
	'optparse-applicative  >=0.19.0    && <0.20' 'optparse-applicative  >=0.18.1    && <0.20'
	'parsec                >=3.1.18   && <3.2' 'parsec                >=3.1.17   && <3.2'
	'text                  >=2.1.2    && <2.2' 'text                  >=2.0    && <2.2'
	'text                  >=2.1.2     && <2.2' 'text                  >=2.0     && <2.2'
	'time                  >=1.14     && <1.15' 'time                  >=1.12     && <1.15'
	'xml-conduit           >=1.10.0   && <1.11' 'xml-conduit           >=1.9   && <1.11'
)

src_prepare() {
	haskell-cabal_src_prepare
	sed -i '/license-file/d' hadolint.cabal || die "sed failed"
}
