# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
EGIT_REPO_URI="https://github.com/plinss/${PN}.git"

inherit git-r3 python-r1

DESCRIPTION="ACME protocol automatic certitificate manager"
HOMEPAGE="https://github.com/plinss/acmebot"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	app-crypt/acme[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-0.24[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pydns:3[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
	einstalldocs

	dobin acmebot
	insinto /etc/acmebot
	doins acmebot.example.{json,yaml}

	insinto /etc/logrotate.d
	doins logrotate.d/acmebot
}
