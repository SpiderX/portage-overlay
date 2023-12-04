# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/beurtschipper/${PN^}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A tool for recovering passwords from pixelized screenshots"
HOMEPAGE="https://github.com/beurtschipper/Depix"
SRC_URI=""

LICENSE="CC-BY-4.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/pillow[${PYTHON_USEDEP}]"

src_prepare() {
	default

	# Fix brackets
	sed -i -e '/return cast/s|\[|\(|g' \
		-e '/return cast/s|\]|\)|g' \
		depixlib/LoadedImage.py || die "sed failed for LoadedImage.py"
}
