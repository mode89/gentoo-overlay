# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A collection of algorithms and sample code for various computer vision problems"
HOMEPAGE="http://www.opencv.org"

SRC_URI="mirror://sourceforge/opencvlibrary/opencv-android/${PV}/OpenCV-${PV}-android-sdk.zip"
S="${WORKDIR}/OpenCV-${PV}-android-sdk"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT=strip
OPENCV_ANDROID_DIR="/opt/${P}"

src_install() {
	dodir ${OPENCV_ANDROID_DIR}
	cp -R "${S}/." "${D}/${OPENCV_ANDROID_DIR}" || die "Install failed!"
	doenvd ${FILESDIR}/80opencv-android
	echo OPENCV_ANDROID_DIR=${OPENCV_ANDROID_DIR} > \
		${D}/etc/env.d/80opencv-android
}
