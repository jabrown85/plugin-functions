/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import { SfHook } from '@salesforce/sf-plugins-core';

type ComputeEnv = { name: string; active: boolean };

const hook: SfHook.EnvList<ComputeEnv> = async function () {
  // return [
  //   {
  //     title: 'Compute Environments',
  //     data: [
  //       { name: 'hello', active: true },
  //       { name: 'world', active: false },
  //     ],
  //   },
  // ];
  return [];
};

export default hook;