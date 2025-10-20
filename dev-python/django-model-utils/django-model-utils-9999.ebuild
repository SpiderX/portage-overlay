# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Django model mixins and utilities"
HOMEPAGE="https://github.com/jazzband/django-model-utils"
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/postgresql:*
		dev-python/time-machine[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

python_test() {
	local db="${T}/pgsql"
	edo initdb -U postgres -A trust -D "${db}" || die "initdb failed"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	epytest
	edo pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}
