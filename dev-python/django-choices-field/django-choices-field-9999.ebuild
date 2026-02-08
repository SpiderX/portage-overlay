# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Django TextChoices/IntegerChoices enum"
HOMEPAGE="https://github.com/bellini666/django-choices-field"
EGIT_REPO_URI="https://github.com/bellini666/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

src_prepare() {
	default

	# remove coverage
	sed -i '/addopts/d' pyproject.toml || die "sed failed for pyproject.toml"
}
