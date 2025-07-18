# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module shell-completion

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
EGIT_REPO_URI="https://github.com/99designs/${PN}.git"

LICENSE="MIT"
SLOT="0"

DOCS=( {README,USAGE}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -ldflags="-X main.Version=${PV} -s -w" -trimpath \
		-o ./bin/"${PN}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin bin/aws-vault

	newinitd "${FILESDIR}"/aws-vault.initd aws-vault
	newconfd "${FILESDIR}"/aws-vault.confd aws-vault

	newbashcomp contrib/completions/bash/aws-vault.bash aws-vault
	newfishcomp contrib/completions/fish/aws-vault.fish aws-vault
	newzshcomp contrib/completions/zsh/aws-vault.zsh _aws-vault
	dodoc contrib/scripts/aws-iam-{create,resync}-yubikey-mfa.sh
}

pkg_postinst() {
	if ! has_version app-admin/pass && ! has_version kde-apps/kwalletmanager \
		&& ! has_version gnome-base/gnome-keyring ; then
		einfo "You should consider to install app-admin/pass, gnome-base/gnome-keyring"
		einfo "or kde-apps/kwalletmanager to be able to use them as backends"
	fi
}
