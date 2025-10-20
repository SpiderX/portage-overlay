# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo pypi

DESCRIPTION="Support for many storage backends in Django"
HOMEPAGE="https://github.com/jschneier/django-storages"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/apache-libcloud[${PYTHON_USEDEP}]
	dev-python/azure-core[${PYTHON_USEDEP}]
	dev-python/azure-storage-blob[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/dropbox[${PYTHON_USEDEP}]
	dev-python/google-cloud-storage[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/moto[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE=tests.settings

src_prepare() {
	default

	# create layout for tests
	edo mkdir tests/test_files
	edo cp "${FILESDIR}"/windows-1252-encoded.txt "${S}"/tests/test_files

	# moto5 support
	sed -i 's/mock_s3/mock_aws/' tests/test_s3.py || die "sed failed"
}
