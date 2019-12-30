# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="TON Testnet Wallet"
HOMEPAGE="https://https://wallet.ton.org https://github.com/ton-blockchain/wallet-desktop"
SRC_URI="https://wallet.ton.org/linux/wsetup.${PV}.tar.xz"

LICENSE="GPL-3-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}"

QA_PREBUILT="usr/bin/Wallet"

src_install() {
	dobin Wallet/Wallet
}
