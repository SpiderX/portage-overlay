# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Geographic add-ons for Django REST Framework"
HOMEPAGE="https://github.com/openwisp/django-rest-framework-gis"
EGIT_REPO_URI="https://github.com/openwisp/django-rest-framework-gis.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-filter[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/postgis
		dev-db/postgresql:* )"

distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE=settings

python_test() {
	local -x PYTHONPATH=tests
	local db="${T}/pgsql"
	initdb -U postgres -A trust -D "${db}" || die "initdb failed"
	pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'" \
		|| die "pg_ctl for start failed"
	psql -U postgres -h 127.0.0.1 -c "CREATE EXTENSION postgis;" \
		|| die "psql failed"
	epytest
	pg_ctl -w -D "${db}" stop || die "pg_ctl for stop failed"
}
