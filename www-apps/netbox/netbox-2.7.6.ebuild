# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
WEBAPP_MANUAL_SLOT="yes"

inherit python-r1 webapp user

DESCRIPTION="IP address and data center infrastructure management tool"
HOMEPAGE="https://github.com/netbox-community/netbox"
SRC_URI="https://github.com/netbox-community/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap vhosts webhooks"

RDEPEND=">=dev-python/django-2.2[${PYTHON_USEDEP}]
	dev-python/django-cors-headers[${PYTHON_USEDEP}]
	>=dev-python/django-debug-toolbar-1.10[${PYTHON_USEDEP}]
	dev-python/django-filter[${PYTHON_USEDEP}]
	dev-python/django-mptt[${PYTHON_USEDEP}]
	dev-python/django-rest-framework[${PYTHON_USEDEP}]
	>=dev-python/django-tables2-2[${PYTHON_USEDEP}]
	dev-python/django-taggit[${PYTHON_USEDEP}]
	dev-python/django-taggit-serializer[${PYTHON_USEDEP}]
	dev-python/django-timezone-field[${PYTHON_USEDEP}]
	dev-python/drf-yasg[${PYTHON_USEDEP}]
	dev-python/graphviz[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/psycopg:2[${PYTHON_USEDEP}]
	dev-python/py-gfm[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	ldap? ( >=dev-python/django-auth-ldap-1.7[${PYTHON_USEDEP}] )
	webhooks? ( dev-python/django-rq[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"

DOCS=( CHANGELOG.md CONTRIBUTING.md README.md )

pkg_setup() {
	python_setup
	webapp_pkg_setup

	enewgroup netbox
	enewuser netbox -1 -1 /var/lib/netbox netbox
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r netbox/.

	exeinto "${MY_HTDOCSDIR}"
	doexe netbox/generate_secret_key.py
	doexe netbox/manage.py

	webapp_src_install

	if use webhooks ; then
		newinitd "${FILESDIR}"/netbox-rqworker.initd netbox-rqworker
		newconfd "${FILESDIR}"/netbox-rqworker.confd netbox-rqworker
	fi
	diropts -onetbox -gnetbox -m0700
	keepdir /var/log/netbox
}

pkg_postinst() {
	elog "You may need to add your web-server user to netbox group"
	elog "---"

	webapp_pkg_postinst
}

pkg_config() {
	einfo "Enter you vhost_root/vhost_htdocs. Default: localhost/htdocs"
	read -r answer
	[ -z "${answer}" ] && answer="localhost/htdocs"
	path="/var/www/${answer}/netbox"
	unset answer

	if [ -f "${path}/netbox/configuration.py" ] ; then
		einfo "Applies database migrations from ${path} ?"
		einfo
		while [ "$correct" != "true" ] ; do
			einfo "Are you ready to continue? (y/n)"
			read -r answer
			if [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]] ; then
				correct="true"
			elif [[ "$answer" =~ ^[Nn]([Oo])?$ ]] ; then
				die "Aborting migration."
			else
				echo "Answer not recognized"
			fi
		done
		# Apply database migrations
		"${path}"/manage.py migrate
	fi

	if [ ! -d "${path}/static" ] ; then
		# Collect static files
		"${path}"/manage.py collectstatic

		chown -R netbox:netbox "${path}"/static
	else
		einfo "Not managing static files since ${path}/static exists"
	fi
}
