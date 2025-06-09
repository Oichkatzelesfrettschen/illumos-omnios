/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
 * or http://www.opensolaris.org/os/licensing.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at usr/src/OPENSOLARIS.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */
/*
 * Copyright 2006 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

#pragma ident "%Z%%M%	%I%	%E% SMI"

#include <sys/hypervisor_api.h>
#include <sys/promif.h>
#include <sys/promimpl.h>

/**
 * Negotiates a sun4v API version with the firmware.
 *
 * @param api_group Identifier for the API group to negotiate.
 * @param major     Desired major version number.
 * @param minor     Desired minor version number.
 * @param supported_minor  Updated with the minor version supported by
 *                         the firmware.
 * @return Hypervisor error code from the firmware call.
 */
uint64_t prom_set_sun4v_api_version(uint64_t api_group, uint64_t major,
                                    uint64_t minor, uint64_t *supported_minor) {
  cell_t ci[8];

  if (prom_test("SUNW,set-sun4v-api-version") != 0)
    return (H_EBADTRAP);

  ci[0] = p1275_ptr2cell("SUNW,set-sun4v-api-version"); /* Service */
  ci[1] = (cell_t)3;                                    /* #argument cells */
  ci[2] = (cell_t)2;                                    /* #result cells */
  ci[3] = (cell_t)api_group;                            /* Arg1: api_group */
  ci[4] = (cell_t)major;                                /* Arg2: major */
  ci[5] = (cell_t)minor;                                /* Arg3: minor */
  ci[6] = (cell_t)-1;                                   /* Res1: status */
  ci[7] = (cell_t)-1; /* Res2: Supported minor */

  promif_preprom();
  (void)p1275_cif_handler(&ci);
  promif_postprom();

  *supported_minor = (uint64_t)(ci[7]);
  return ((uint64_t)(ci[6]));
}

/**
 * Retrieves the negotiated sun4v API version for the given group.
 *
 * @param api_group Identifier for the API group to query.
 * @param major     Updated with the negotiated major version.
 * @param minor     Updated with the negotiated minor version.
 * @return Hypervisor error code from the firmware call.
 */
uint64_t prom_get_sun4v_api_version(uint64_t api_group, uint64_t *major,
                                    uint64_t *minor) {
  cell_t ci[7];

  if (prom_test("SUNW,get-sun4v-api-version") != 0)
    return (H_EBADTRAP);

  ci[0] = p1275_ptr2cell("SUNW,get-sun4v-api-version"); /* Service */
  ci[1] = (cell_t)1;                                    /* #argument cells */
  ci[2] = (cell_t)3;                                    /* #result cells */
  ci[3] = (cell_t)api_group;                            /* Arg1: api_group */
  ci[4] = (cell_t)-1;                                   /* Res1: status */
  ci[5] = (cell_t)-1;                                   /* Res2: major number */
  ci[6] = (cell_t)-1;                                   /* Res3: minor number */

  promif_preprom();
  (void)p1275_cif_handler(&ci);
  promif_postprom();

  *major = (uint64_t)(ci[5]);
  *minor = (uint64_t)(ci[6]);
  return ((uint64_t)(ci[4]));
}
