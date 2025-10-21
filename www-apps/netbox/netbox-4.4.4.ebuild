# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit edo python-single-r1 readme.gentoo-r1 systemd

DESCRIPTION="IP address and data center infrastructure management tool"
HOMEPAGE="https://github.com/netbox-community/netbox"
SRC_URI="https://github.com/netbox-community/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ldap"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="acct-group/netbox
	acct-user/netbox
	${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/colorama[${PYTHON_USEDEP}]
		>=dev-python/django-5.2.6[${PYTHON_USEDEP}]
		dev-python/django-cors-headers[${PYTHON_USEDEP}]
		dev-python/django-debug-toolbar[${PYTHON_USEDEP}]
		dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/django-graphiql-debug-toolbar[${PYTHON_USEDEP}]
		dev-python/django-htmx[${PYTHON_USEDEP}]
		dev-python/django-mptt[${PYTHON_USEDEP}]
		dev-python/django-pglocks[${PYTHON_USEDEP}]
		dev-python/django-prometheus[${PYTHON_USEDEP}]
		dev-python/django-redis[${PYTHON_USEDEP}]
		dev-python/django-rich[${PYTHON_USEDEP}]
		dev-python/django-rq[${PYTHON_USEDEP}]
		dev-python/django-storages[${PYTHON_USEDEP}]
		dev-python/django-tables2[${PYTHON_USEDEP}]
		dev-python/django-taggit[${PYTHON_USEDEP}]
		dev-python/django-timezone-field[${PYTHON_USEDEP}]
		dev-python/djangorestframework[${PYTHON_USEDEP}]
		dev-python/drf-spectacular[${PYTHON_USEDEP}]
		dev-python/drf-spectacular-sidecar[${PYTHON_USEDEP}]
		dev-python/feedparser[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/mkdocs-material[${PYTHON_USEDEP}]
		dev-python/mkdocstrings[${PYTHON_USEDEP}]
		dev-python/mkdocstrings-python[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		dev-python/nh3[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/psycopg:0[${PYTHON_USEDEP},native-extensions]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/rq[${PYTHON_USEDEP}]
		dev-python/social-auth-app-django[${PYTHON_USEDEP}]
		dev-python/social-auth-core[${PYTHON_USEDEP}]
		dev-python/sorl-thumbnail[${PYTHON_USEDEP}]
		dev-python/strawberry-graphql[${PYTHON_USEDEP}]
		dev-python/strawberry-graphql-django[${PYTHON_USEDEP}]
		dev-python/svgwrite[${PYTHON_USEDEP}]
		dev-python/tablib[${PYTHON_USEDEP}]
		dev-python/tzdata[${PYTHON_USEDEP}]
		www-servers/gunicorn[${PYTHON_USEDEP}]
		ldap? ( dev-python/django-auth-ldap[${PYTHON_USEDEP}] ) ')"
DEPEND="${RDEPEND}"

DOCS=( {CHANGELOG,README}.md )

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="
netbox is installed on your system. However, there are some manual steps
you need to complete from the installation guide [1].

On Gentoo, the configuration files you need to edit are located in
/etc/netbox, not /opt/netbox as shown in the installation guide.

If this is a new installation, please follow the installation guide
other than this difference. Also, if you need ldap, set the appropriate
use flag when emerging netbox to install the dependency for it.

Once that is done, you should be able to add the netbox service to the
default runlevel and start it.

If you want to use webhooks,  you should also add the netbox-rqworker
service to the default runlevel and start it.

If this is an upgrade, follow these instructions:

Stop the netbox service. If the  netbox-rqworker service is running,
stop it as well.

Next, run the upgrade script as described in the upgrading guide[2].

Next, check for new configuration options and set them as appropriate
for your system.

Next, start the netbox service.

Finally, if you are using webhooks, start the netbox-rqworker service.

[1] https://netbox.readthedocs.io/en/stable/installation/
[2] https://netbox.readthedocs.io/en/stable/installation/upgrading/
"

src_prepare() {
	default

	# change gunicorn path
	sed -i '/ExecStart/s|opt/netbox/venv|usr|' contrib/netbox.service \
		|| die "sed failed for netbox.service"
	# change python path
	sed -i '/ExecStart/s|opt/netbox/venv|usr|' contrib/netbox-rq.service \
		|| die "sed failed for netbox-rq.service"
}

src_install() {
	dodir /opt
	edo cp -a ../"${P}" "${ED}"/opt
	dosym "${P}" /opt/netbox

	dosym ../../etc/netbox/gunicorn.py /opt/netbox/gunicorn.py
	dosym ../../../../etc/netbox/configuration.py \
		/opt/netbox/netbox/netbox/configuration.py

	keepdir /var/log/netbox
	insinto /etc/netbox
	newins netbox/netbox/configuration_example.py configuration.py
	doins contrib/gunicorn.py
	fowners -R netbox:netbox /{etc,opt,var/log}/netbox /opt/"${P}"
	fperms o= /etc/netbox/{configuration,gunicorn}.py

	newinitd "${FILESDIR}"/netbox.initd netbox
	newconfd "${FILESDIR}"/netbox.confd netbox
	systemd_dounit contrib/netbox.service
	newinitd "${FILESDIR}"/netbox-rqworker.initd netbox-rqworker
	newconfd "${FILESDIR}"/netbox-rqworker.confd netbox-rqworker
	systemd_dounit contrib/netbox-rq.service

	readme.gentoo_create_doc
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
				echo "Answer not recognized" || die "echo failed"
			fi
		done
		# Apply database migrations
		"${path}"/manage.py migrate || die "migrations failed"
	fi

	if [ ! -d "${path}/static" ] ; then
		# Collect static files
		"${path}"/manage.py collectstatic || die "collectstatic failed"
		fowners -R netbox:netbox "${path}"/static
	else
		einfo "Not managing static files since ${path}/static exists"
	fi
}

pkg_postinst() {
	readme.gentoo_print_elog
}
