# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="A command line tool for interacting with cloud storage services"
HOMEPAGE="https://github.com/GoogleCloudPlatform/gsutil"
EGIT_REPO_URI="https://github.com/GoogleCloudPlatform/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/boto[${PYTHON_USEDEP}]
	dev-python/crcmod[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	dev-python/gcs-oauth2-boto-plugin[${PYTHON_USEDEP}]
	dev-python/google-apitools[${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/google-auth-httplib2[${PYTHON_USEDEP}]
	dev-python/google-reauth[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/retry-decorator[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-5.37-gslib.patch
	"${FILESDIR}/${PN}"-5.37-gsutil.patch
	"${FILESDIR}/${PN}"-5.37-tests.patch )

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	default

	# preserve boto's mock S3 service used by gsutil tests
	cp gslib/vendored/boto/tests/integration/s3/mock_storage_service.py \
		gslib/tests/ || die

	# remove bundled boto and oauth2client in favor of system packages
	rm -r gslib/vendored || die

	# remove obsolete monotonic dependency
	sed -i '/monotonic/d' setup.py || die "sed failed for setup.py"
}

python_test() {
	epytest -o log_cli=true -o log_cli_level=INFO gslib/tests
}
