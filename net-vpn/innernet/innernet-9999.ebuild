# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"

inherit cargo git-r3 pax-utils shell-completion systemd

DESCRIPTION="A private network system that uses WireGuard"
HOMEPAGE="https://github.com/tonarino/innernet"
EGIT_REPO_URI="https://github.com/tonarino/${PN}.git"

LICENSE="Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"
IUSE="+client server"
REQUIRED_USE="|| ( client server )"

RDEPEND="server? ( dev-db/sqlite:3
		virtual/zlib:0= )"

QA_PREBUILT="usr/bin/innernet
	/usr/bin/innernet-server"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_compile() {
	use client && cargo_src_compile --bin innernet
	use server && cargo_src_compile --bin innernet-server
}

src_install() {
	if use client ; then
		doman doc/innernet.8
		newbashcomp doc/innernet.completions.bash innernet
		newfishcomp doc/innernet.completions.fish innernet
		newzshcomp doc/innernet.completions.zsh _innernet
		dobin target/release/innernet
		pax-mark m "${ED}"/usr/bin/innernet
		dosym ../bin/innernet usr/bin/inn
		newinitd "${FILESDIR}"/innernet-client.initd innernet-client
		newconfd "${FILESDIR}"/innernet-client.confd innernet-client
		systemd_dounit client/innernet@.service
	fi
	if use server ; then
		doman doc/innernet-server.8
		newbashcomp doc/innernet-server.completions.bash innernet-server
		newfishcomp doc/innernet-server.completions.fish innernet-server
		newzshcomp doc/innernet-server.completions.zsh _innernet-server
		dobin target/release/innernet-server
		pax-mark m "${ED}"/usr/bin/innernet-server
		newinitd "${FILESDIR}"/innernet-server.initd innernet-server
		newconfd "${FILESDIR}"/innernet-server.confd innernet-server
		systemd_dounit server/innernet-server@.service
	fi
}
