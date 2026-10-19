# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Amazon Web Services Library"
HOMEPAGE="https://github.com/boto/boto"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpretty[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-2.49.0-cloudfront.patch
	"${FILESDIR}/${PN}"-2.49.0-compat.patch
	"${FILESDIR}/${PN}"-2.49.0-dynamo.patch
	"${FILESDIR}/${PN}"-2.49.0-ecs.patch
	"${FILESDIR}/${PN}"-2.49.0-mws.patch
	"${FILESDIR}/${PN}"-2.49.0-plugin.patch
	"${FILESDIR}/${PN}"-2.49.0-pyami.patch
	"${FILESDIR}/${PN}"-2.49.0-tests.patch
	"${FILESDIR}/${PN}"-2.49.0-tests-auth.patch
	"${FILESDIR}/${PN}"-2.49.0-tests-cloudfront.patch
	"${FILESDIR}/${PN}"-2.49.0-tests-ec2.patch
	"${FILESDIR}/${PN}"-2.49.0-tests-glacier.patch
	"${FILESDIR}/${PN}"-2.49.0-tests-route53.patch
	"${FILESDIR}/${PN}"-2.49.0-tests-s3.patch
	"${FILESDIR}/${PN}"-2.49.0-tests-sqs.patch )

distutils_enable_tests unittest

src_prepare() {
	default

	# replace unittest assertion aliases removed in Python 3.11
	find tests/unit -type f -name '*.py' -exec sed -i \
		-e 's/\.assertEquals(/.assertEqual(/g' \
		-e 's/\.assertNotEquals(/.assertNotEqual(/g' \
		-e 's/\.assertRaisesRegexp(/.assertRaisesRegex(/g' \
		{} +

	rm boto/vendored/six.py || die "rm failed for six"
}

python_test() {
	"${EPYTHON}" -m unittest discover -s tests/unit -v
}
