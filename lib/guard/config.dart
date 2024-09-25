// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: do_not_use_environment, constant_identifier_names, non_constant_identifier_names

import 'package:flutter/foundation.dart';

String get GOOGLE_CLIENT_ID {
  if (defaultTargetPlatform == TargetPlatform.macOS) {
    return 'TODO';
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    return 'TODO';
  } else if (defaultTargetPlatform == TargetPlatform.windows) {
    return 'TODO';
  } else {
    return '312983175067-13o4bs9uq05hc68885u89bdop6oct6ck.apps.googleusercontent.com';
  }
}
