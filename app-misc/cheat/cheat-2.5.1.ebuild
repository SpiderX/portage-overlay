# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6..7}} )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/cheat/cheat"
SRC_URI="https://github.com/cheat/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion fish-completion test zsh-completion"
RESTRICT="test"

DEPEND="dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	bash-completion? ( app-shells/bash-completion )
	fish-completion? ( app-shells/fish )
	zsh-completion? ( app-shells/zsh-completions )"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/unittest2[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" -m unittest discover -v tests/ || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install
	distutils-r1_python_install_all

	use bash-completion && newbashcomp cheat/autocompletion/cheat.bash cheat
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins cheat/autocompletion/cheat.zsh _cheat
	fi
	if use fish-completion ; then
		insinto /usr/share/fish/completion
		newins cheat/autocompletion/cheat.fish cheat
	fi
}
