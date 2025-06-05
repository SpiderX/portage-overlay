# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo optfeature pypi

DESCRIPTION="Settings management using pydantic"
HOMEPAGE="https://github.com/pydantic/pydantic-settings"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/azure-identity[${PYTHON_USEDEP}]
		dev-python/azure-keyvault-secrets[${PYTHON_USEDEP}]
		dev-python/grpcio-status[${PYTHON_USEDEP}]
		dev-python/pytest-examples[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	edo ln -s /usr/bin/ruff "${BUILD_DIR}"/install/usr/bin/ruff
	distutils-r1_python_test
	edo rm "${BUILD_DIR}"/install/usr/bin/ruff
}

pkg_postinst() {
	optfeature "support for yaml" dev-python/pyyaml
	optfeature "support of toml" dev-python/tomli
	optfeature "support for azure-key-vault" dev-python/azure-keyvault-secrets dev-python/azure-identity
	optfeature "support for aws-secrets-manager" dev-python/boto3 dev-python/boto3-stubs
	optfeature "support for gcp-secret-manager" dev-python/google-cloud-secret-manager
}
