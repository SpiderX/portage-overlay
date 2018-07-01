# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# golang-vcs-snapshot doesn't support gitlab uri scheme, keep sources from gitlab as is
EGO_VENDOR=( "github.com/BurntSushi/toml a368813c5e648fee92e5f6c30e3944ff9d5e8895"
	"github.com/beorn7/perks 4c0e84591b9aa9e6dcfdf3e020114cd81f89d5f9"
	"github.com/certifi/gocertifi a9c833d2837d3b16888d55d5aafa9ffe9afb22b0"
	"github.com/getsentry/raven-go 4fa2ac0d29f801e79a063c0da82d37b5ff2873b2"
	"github.com/golang/protobuf 5a0f697c9ed9d68fef0116532c6e05cfeae00e55"
	"github.com/grpc-ecosystem/go-grpc-middleware 82921fcf811d228d2fa202bc31238b356bf9f8d5"
	"github.com/grpc-ecosystem/go-grpc-prometheus 6b7015e65d366bf3f19b2b2a000a831940f0f7e0"
	"github.com/kelseyhightower/envconfig 5c008110b20b657eb7e005b83d0a5f6aa6bb5f4b"
	"github.com/matttproud/golang_protobuf_extensions c12348ce28de40eed0136aa2b644d0ee0650e56c"
	"github.com/pmezard/go-difflib 792786c7400a136282c1664665ae0a8db921c6c2"
	"github.com/prometheus/client_golang 575f371f7862609249a1be4c9145f429fe065e32"
	"github.com/prometheus/client_model fa8ad6fec33561be4280a8f0514318c79d7f6cb6"
	"github.com/prometheus/common 195bde7883f7c39ea62b0d92ab7359b5327065cb"
	"github.com/prometheus/procfs fcdb11ccb4389efb1b210b7ffb623ab71c5fdd60"
	"github.com/sirupsen/logrus 89742aefa4b206dcf400792f3bd35b542998eb3b"
	"github.com/stretchr/testify 87b1dfb5b2fa649f52695dd9eae19abe404a4308"
	#"gitlab.com/gitlab-org/gitaly-proto fc6f3cc448eb578d570da9bff7a0ec76603daa6d"
	"golang.org/x/net 59a0b19b5533c7977ddeb86b017bf507ed407b12 github.com/golang/net"
	"golang.org/x/sync f52d1811a62927559de87708c8913c1650ce4f26 github.com/golang/sync"
	"golang.org/x/text ccbd3f7822129ff389f8ca4858a9b9d4d910531c github.com/golang/text"
	"google.golang.org/genproto f676e0f3ac6395ff1a529ae59a6670878a8371a6 github.com/google/go-genproto"
	"google.golang.org/grpc 7cea4cc846bcf00cbb27595b07da5de875ef7de9 github.com/grpc/grpc-go" )

EGO_PN="gitlab.com/gitlab-org/gitaly"

inherit eutils golang-vcs-snapshot systemd tmpfiles user

DESCRIPTION="Gitaly is a Git RPC service for handling GitLab git calls"
HOMEPAGE="https://gitlab.com/gitlab-org/gitaly"
SRC_URI="https://${EGO_PN}/repository/v${PV}/archive.tar.bz2 -> ${P}.tar.bz2
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# dev-go/go-protobuf is too old, use bundled version
# dev-go/go-text is too old, use bundled version
# dev-go/go-net is too old, use bundled version
CDEPEND="dev-go/go-crypto:=
	dev-go/go-spew:=
	dev-go/go-sys:="
RDEPEND="${CDEPEND}
	dev-vcs/git"
DEPEND="${CDEPEND}
	dev-ruby/bundler
	dev-util/cmake"
#dev-libs/icu?
# TODO: ruby depends

S="${WORKDIR}/${P}/src/${EGO_PN}"

RESTRICT="mirror"

DOCS=( CHANGELOG.md README.md )

pkg_setup() {
	enewgroup gitlab
	enewuser gitaly -1 -1 /var/lib/"${PN}" gitlab
}

src_prepare() {
	default

	# Change PREFIX, use a ${PV} instead of 'git describe',
	# append path to go libs and reexport GOROOT after PATH
	sed -i \
		-e '/PREFIX :=/s|/local||' \
		-e '/VERSION_PREFIXED =/s|$(shell git describe)|@VERSION@|' \
		-e "/VERSION_PREFIXED =/s|@VERSION@|v${PV}|" \
		-e '/export PATH := $(GOPATH)\/bin:$(PATH)/a export GOPATH := $(TARGET_DIR):/usr/lib/go-gentoo' \
		Makefile || die "sed failed for Makefile"
	# Modify config (socket_path, bin_dir, dir in gitlab-gitaly and gitlab-shell sections)
	sed -i \
		-e '/socket_path/s|home/git/gitlab/tmp/sockets/private/|run/gitlab-gitaly/gitlab-|' \
		-e '/bin_dir/s|home/git/gitaly|usr/bin|' \
		-e '/^path/s|home|var/lib|' \
		-e '/dir = "\/home\/git\/gitaly\//s|home/git/gitaly|var/lib/gitlab-gitaly|' \
		-e '/dir = "\/home\/git\/gitlab-shell/s|home|var/lib|' \
		config.toml.example || die "sed failed for config.toml.example"
	# Remove bundled libs to use provided by portage
	rm -rf vendor/github.com/davecgh || die "failed to remove go-spew"
	rm -rf vendor/golang.org/x/{crypto,sys} || die "failed to remove crypto or sys"
}

src_install() {
	default

# find ruby/vendor -iname 'Makefile' -delete  ?

	insinto /var/lib/"${PN}"
	doins -r ruby
	exeinto /var/lib/"${PN}"/ruby/bin
	doexe ruby/bin/{gitaly-ruby,ruby-cd}
	exeinto /var/lib/"${PN}"/ruby/vendor/bundle/ruby/2.*.0/bin
	doexe ruby/vendor/bundle/ruby/2.*.0/bin/{github-markup,git-linguist,htmldiff,ldiff,linguist,nokogiri,posix-spawn-benchmark,rake,rdoc,ri,rougify,rspec,rubocop,ruby-parse,ruby-rewrite}
# do we need this ?
	exeinto /var/lib/"${PN}"/ruby/vendor/bundle/ruby/2.*.0/gems/charlock_holmes-0.7.6/ext/charlock_holmes
	doexe ruby/vendor/bundle/ruby/2.*.0/gems/charlock_holmes-0.7.6/ext/charlock_holmes/charlock_holmes.so
	exeinto /var/lib/"${PN}"/ruby/vendor/bundle/ruby/2.*.0/gems/charlock_holmes-0.7.6/lib/charlock_holmes
	doexe ruby/vendor/bundle/ruby/2.*.0/gems/charlock_holmes-0.7.6/lib/charlock_holmes/charlock_holmes.so
	fowners -R gitaly:gitlab /var/lib/"${PN}"

	insinto /etc/"${PN}"
	doins config.toml.example
	fowners -R gitaly:gitlab /etc/"${PN}"

	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
	newtmpfiles "${FILESDIR}"/"${PN}".tmpfile "${PN}".conf

#	fperms 0755 /var/lib/gitlab-gitaly/ruby/bin/{gitaly-ruby,ruby-cd}
}

pkg_postinst() {
	tmpfiles_process "${PN}".conf
}
