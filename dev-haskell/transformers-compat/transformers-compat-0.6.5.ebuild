# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CABAL_FEATURES="lib profile haddock hoogle hscolour nocabaldep"

inherit haskell-cabal

DESCRIPTION="A small compatibility shim for dev-haskell/transformers"
HOMEPAGE="https://github.com/ekmett/transformers-compat"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-haskell/fail:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/transformers:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"

src_configure() {
	local tf3_arg=() tf4_arg=() tf5_arg=()

	if has_version '=dev-haskell/transformers-0.3*' ; then
		tf3_arg+=('--flag=three')
	else
		tf3_arg+=('--flag=-three')
	fi

	if has_version '=dev-haskell/transformers-0.4*' ; then
		tf4_arg+=('--flag=four')
	else
		tf4_arg+=('--flag=-four')
	fi

	if has_version '=dev-haskell/transformers-0.5*' ; then
		if has_version '>dev-haskell/transformers-0.5.3' ; then
			tf5_arg+=('--flag=-five')
		else
			tf5_arg+=('--flag=five')
		fi
	else
		tf5_arg+=('--flag=-five')
	fi

	haskell-cabal_src_configure --flag=mtl --flag=-two \
		"${tf3_arg[@]}" \
		"${tf4_arg[@]}" \
		"${tf5_arg[@]}"
}
