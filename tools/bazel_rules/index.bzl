"""Public API surface is re-exported here.

This file should be the package where all rules are imported from

The rules should be located in folders inside this package and re-exported
with this kind of barrel file.

Users should not load files under "/tools/bazel_rules/..."
"""

load("//tools/bazel_rules/jest:jest.bzl", _jest_test = "jest_test")

jest_test = _jest_test
