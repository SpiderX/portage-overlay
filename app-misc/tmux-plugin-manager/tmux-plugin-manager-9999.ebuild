# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/tpm.git"

inherit git-r3 readme.gentoo-r1

DESCRIPTION="Tmux Plugin Manager"
HOMEPAGE="https://github.com/tmux-plugins/tpm"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # fails
PROPERTIES="test_network"

RDEPEND="app-misc/tmux
	dev-vcs/git"
BDEPEND="test? ( dev-tcltk/expect )"

DOC_CONTENTS="Add the following into .tmux.conf:\\n
set-environment -g TMUX_PLUGIN_MANAGER_PATH '/usr/share/tmux-plugins'\\n
to install plugins via portage and manage them via tpm."

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
