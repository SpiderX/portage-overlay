# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="AWS Encryption SDK"
HOMEPAGE="https://github.com/aws/aws-encryption-sdk-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/wrapt[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/aws-cryptographic-material-providers[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# disable intergration tests
	rm -rf examples/test/{legacy,migration} || die "rm failed for legacy"
	rm test/integration/test_kat_commitment.py \
		test/mpl/integ/test_required_ec_cmm.py \
		test/integration/test_i_aws_encrytion_sdk_client.py \
		test/integration/test_i_thread_safety.py \
		examples/test/test_i_aws_kms_discovery_keyring_example.py \
		examples/test/test_i_aws_kms_discovery_multi_keyring_example.py \
		examples/test/test_i_aws_kms_keyring_example.py \
		examples/test/test_i_aws_kms_mrk_discovery_keyring_example.py \
		examples/test/test_i_aws_kms_mrk_discovery_multi_keyring_example.py \
		examples/test/test_i_aws_kms_mrk_keyring_example.py \
		examples/test/test_i_aws_kms_mrk_multi_keyring_example.py \
		examples/test/test_i_aws_kms_multi_keyring_example.py \
		examples/test/test_i_aws_kms_rsa_keyring_example.py \
		examples/test/test_i_custom_mpl_cmm_example.py \
		examples/test/test_i_default_cryptographic_materials_manager_example.py \
		examples/test/test_i_hierarchical_keyring_example.py \
		examples/test/test_i_multi_keyring_example.py \
		examples/test/test_i_required_encryption_context_cmm.py \
		test/unit/test_compatability.py \
		|| die "rm failed"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "support for MPL" dev-python/aws-cryptographic-material-providers
}
