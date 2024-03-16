// ignore_for_file: public_member_api_docs
// coverage:ignore-file

import '_io_renderer.dart'
    if (dart.library.html) '_html_renderer.dart'
    as impl;

void printRendererErrorMessageIfNecessary() => impl.printErrorMessage();
