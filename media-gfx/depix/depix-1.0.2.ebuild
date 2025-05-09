# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A tool for recovering passwords from pixelized screenshots"
HOMEPAGE="https://github.com/beurtschipper/Depix"

LICENSE="CC-BY-4.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pillow[${PYTHON_USEDEP}]"

#PATCHES=( "${FILESDIR}/${PN}"-1.0.2-setup.py.patch )

src_prepare() {
	default

	# fix brackets
	sed -i -e '/return cast/s|\[|\(|g' \
		-e '/return cast/s|\]|\)|g' \
		depixlib/LoadedImage.py || die "sed failed for LoadedImage.py"

	# fix parser
	sed -i '/depix.depix/s|\.|:|' setup.py || die "sed failed for setup.py"
}
