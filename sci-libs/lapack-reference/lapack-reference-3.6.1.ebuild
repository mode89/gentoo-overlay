# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="FORTRAN reference implementation of LAPACK Linear Algebra PACKage"
HOMEPAGE="http://www.netlib.org/lapack/index.html"
SRC_URI="http://www.netlib.org/lapack/lapack-3.6.1.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/lapack-3.6.1"

src_prepare() {
	eapply_user

	ESELECT_PROF=reference

	cp "${FILESDIR}"/eselect.lapack.reference \
		"${T}"/eselect.lapack.reference || die
	sed -i -e "s:/usr:${EPREFIX}/usr:" \
		"${T}"/eselect.lapack.reference || die
	if [[ ${CHOST} == *-darwin* ]] ; then
		sed -i -e 's/\.so\([\.0-9]\+\)\?/\1.dylib/g' \
			"${T}"/eselect.lapack.reference || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DCBLAS=ON
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS=OFF
		-DBUILD_TESTING=OFF
		-DLAPACKE=ON
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	mkdir -p "${ED}/usr/$(get_libdir)/lapack/reference" || die
	mv \
		"${ED}/usr/$(get_libdir)"/lib* \
		"${ED}/usr/$(get_libdir)/pkgconfig"/* \
		"${ED}/usr/$(get_libdir)/lapack/reference" || die
	rmdir "${ED}/usr/$(get_libdir)/pkgconfig" || die
	rm -rf "${ED}"/usr/lib/ || die

	eselect lapack add $(get_libdir) \
		"${T}"/eselect.lapack.reference ${ESELECT_PROF}
}

pkg_postinst() {
	local p=lapack
	local current_lib=$(eselect ${p} show | cut -d' ' -f2)
	if [[ ${current_lib} == ${ESELECT_PROF} || -z ${current_lib} ]]; then
		# work around eselect bug #189942
		local configfile="${EROOT}"/etc/env.d/${p}/$(get_libdir)/config
		[[ -e ${configfile} ]] && rm -f ${configfile}
		eselect ${p} set ${ESELECT_PROF}
		elog "${p} has been eselected to ${ESELECT_PROF}"
	else
		elog "Current eselected ${p} is ${current_lib}"
		elog "To use ${p} ${ESELECT_PROF} implementation, you have to issue (as root):"
		elog "\t eselect ${p} set ${ESELECT_PROF}"
	fi
}
