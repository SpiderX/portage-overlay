# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module shell-completion

DESCRIPTION="AWS IAM Roles Anywhere Credential Helper"
HOMEPAGE="https://github.com/aws/rolesanywhere-credential-helper"
SRC_URI="https://github.com/aws/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND=">=dev-lang/go-1.27.3
	test? ( dev-libs/openssl )"

src_compile() {
	LDFLAGS="-w -X github.com/aws/rolesanywhere-credential-helper/cmd.Version=${PV}"
	ego build -ldflags "${LDFLAGS}" -o bin/aws_signing_helper

	local completion
	for completion in bash fish zsh ; do
		edo ./bin/aws_signing_helper completion "${completion}" > aws_signing_helper."${completion}" \
			|| die "completion for ${completion} failed"
	done
}

src_test() {
	emake test-certs

	# PKCS#11 and TPM tests require test fixtures and emulators
	ego test ./... -skip 'TestPKCS11Signer$|TestTPMSigner'
}

src_install() {
	einstalldocs
	dobin bin/aws_signing_helper

	newbashcomp aws_signing_helper.bash aws_signing_helper
	newfishcomp aws_signing_helper.fish aws_signing_helper
	newzshcomp aws_signing_helper.zsh _aws_signing_helper
}
