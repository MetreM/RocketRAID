# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-mod

MY_P=rr2210-linux-src-v${PV}-091009-1018
DESCRIPTION="Kernel Module for the HighPoint RocketRaid 2210 RAID Adapter"
HOMEPAGE="http://www.highpoint-tech.com"
SRC_URI="http://www.highpoint-tech.com/BIOS_Driver/rr2210/Linux/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}
MY_S="${S}/rr2210-linux-src-v1.5"

BUILD_TARGETS=""
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="rr2210(block:${MY_S}/product/rr2210/linux:${MY_S}/product/rr2210/linux)"

src_unpack() {
	unpack ${A}
	cd "${MY_S}"
	epatch "${FILESDIR}"/rr2210-linux-src-v1.5-kernel-3.11.patch
	linux-mod_pkg_setup
	BUILD_PARMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
}

src_compile() {
	cd ${MY_S}/product/rr2210/linux
	emake || die
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "Please add \"rr2210\" to:"
	elog "/etc/conf.d/modules"
}
