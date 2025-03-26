# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="An OpenSource Cloudformation Deployment Framework"
HOMEPAGE="https://github.com/aws-ia/taskcat"
EGIT_REPO_URI="https://github.com/aws-ia/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test"

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/cfn-lint[${PYTHON_USEDEP}]
	dev-python/dataclasses-jsonschema[${PYTHON_USEDEP}]
	dev-python/docker[${PYTHON_USEDEP}]
	dev-python/dulwich[${PYTHON_USEDEP}]
	dev-python/gitpython[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/reprint[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/yattag[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# Add backend specification
	sed -i  -e '1 i[build-system]\nrequires = ["poetry>=0.12"]\nbuild-backend = "poetry.core.masonry.api"' \
		pyproject.toml || die "sed failed for pyproject.toml"

	if use test ; then
		git init > /dev/null || die "git init failed"
		git config --global user.email "${PN}@gentoo.org" || die "git config failed"
		git config --global user.name "${PN}" || die "git config failed"
		git remote add "origin" https://github.com/aws-ia/"${PN}".git || die "origin failed"
	fi

	distutils-r1_python_prepare_all
}
