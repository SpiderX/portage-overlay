# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Python library for accessing resources protected by OAuth 2.0"
HOMEPAGE="https://github.com/googleapis/oauth2client"
SRC_URI="https://github.com/googleapis/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/django[${PYTHON_USEDEP}]
		dev-python/fasteners[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/jsonpickle[${PYTHON_USEDEP}]
		dev-python/keyring[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pycryptodome[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-4.1.3-src-contrib-django_util.patch
	"${FILESDIR}/${PN}"-4.1.3-src-contrib-flask_util.patch
	"${FILESDIR}/${PN}"-4.1.3-src-contrib-xsrfutil.patch
	"${FILESDIR}/${PN}"-4.1.3-src_helpers.patch
	"${FILESDIR}/${PN}"-4.1.3-src_openssl_crypt.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-contrib-appengine.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-contrib-django_util.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-contrib-test_devshell.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-contrib-test_flask_util.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-contrib-test_keyring_storage.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-contrib-test_multiprocess_file_storage.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-contrib-test_xsrfutil.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-test_client.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-test_clientsecrets.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-test_file.patch
	"${FILESDIR}/${PN}"-4.1.3-tests-test_service_account.patch )

DOCS=( {CHANGELOG,README}.md )

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE=tests.contrib.django_util.settings
