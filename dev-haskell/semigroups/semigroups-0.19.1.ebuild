# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour nocabaldep"

inherit haskell-cabal

DESCRIPTION="Anything that associates"
HOMEPAGE="https://github.com/ekmett/semigroups"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+binary +transformers"

RDEPEND="dev-haskell/hashable:=[profile?]
	dev-haskell/nats:=[profile?]
	dev-haskell/tagged:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	dev-lang/ghc:=
	transformers? ( >=dev-haskell/transformers-compat-0.5:=[profile?] )"
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_configure() {
	haskell-cabal_src_configure \
		"$(cabal_flag binary binary)" \
		"$(cabal_flag transformers transformers)" \
		--flag=bytestring \
		--flag=containers \
		--flag=deepseq \
		--flag=hashable \
		--flag=tagged \
		--flag=text \
		--flag=unordered-containers
}
