# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo readme.gentoo-r1

MY_PN="tpm"
MY_P="${MY_PN}-${PV}"
COMMIT="33fa65fbfb72ba6dd106c21bf5ee6cc353ecdbb6"

DESCRIPTION="Tmux Plugin Manager"
HOMEPAGE="https://github.com/tmux-plugins/tpm"
SRC_URI="https://github.com/tmux-plugins/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/tmux-plugins/tmux-test/archive/${COMMIT}.tar.gz -> ${P}-test.tar.gz )"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # fails
PROPERTIES="test_network"

RDEPEND="app-misc/tmux
	dev-vcs/git"
BDEPEND="test? ( dev-tcltk/expect )"

DOC_CONTENTS="Add the following into .tmux.conf:\\n
set-environment -g TMUX_PLUGIN_MANAGER_PATH '/usr/share/tmux-plugins'\\n
to install plugins via portage and manage them via tpm."

src_prepare() {
	default

	edo rmdir lib/tmux-test
	edo ln -s ../../tmux-test-"${COMMIT}" lib/tmux-test
}

src_test() {
	lib/tmux-test/setup || die "setup failed"
	HOME="${T}" ./tests/run_tests_in_isolation || die "test failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugin-manager
	doins -r bin bindings scripts tpm
	fperms -R +x /usr/share/tmux-plugin-manager/bin{,dings}/ \
		/usr/share/tmux-plugin-manager/scripts/check_tmux_version.sh \
		/usr/share/tmux-plugin-manager/scripts/{clean,install,source}_plugins.sh \
		/usr/share/tmux-plugin-manager/scripts/update_plugin{,_prompt_handler}.sh \
		/usr/share/tmux-plugin-manager/tpm
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
