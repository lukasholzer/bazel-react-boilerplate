"Jest testing macro that can compile typescript files for testing as well"

load("@npm//@bazel/typescript:index.bzl", "ts_project")
load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_test")

def jest_test(
        srcs,
        tsconfig = None,
        jest_config = None,
        setup_file = None,
        name = "test",
        deps = [],
        **kwargs):
    """Jest testing rule that compiles the typescript sources and run jest tests

    Args:
      srcs: The sources passed
      tsconfig: The typescript config for compiling typescript files
      jest_config: The jest configuration file
      setup_file: The jest setup file
      name: The name of the test rule
      deps: The dependencies that are needed for the test
      **kwargs: Positional arguments
    """

    test_deps = []

    # compile the spec files first
    ts_project(
        name = name + "_compile",
        srcs = srcs,
        tsconfig = tsconfig or {},
        source_map = True,
        # testonly = True,
        deps = [
            "@npm//tslib",
            # "@npm//@types/node",
            "@npm//@types/jest",
        ] + deps,
    )

    # templated_args = [
    #     "--no-cache",
    #     "--no-watchman",
    #     "--ci",
    #     "--colors",
    # ]

    # # Dependencies that are needed for the jest test
    # test_deps = [
    #     ":%s_compile" % name,
    #     "//tools/bazel_rules/jest",
    # ] + deps

    # # if we have a config file than add it
    # if jest_config:
    #     test_deps.append(jest_config)
    #     templated_args.extend(["--config", "$(rootpath %s)" % jest_config])

    # for src in srcs:
    #     templated_args.extend(["--runTestsByPath", "$(rootpath %s)" % src])

    nodejs_test(
        name = name,
        # testonly = True,
        data = [
            ":%s_compile" % name,
        ],
        entry_point = "//tools/bazel_rules/jest:jest-runner.ts",
        templated_args = [],
    )

    # _jest_test(
    #     name = name,
    #     data = test_deps,
    #     templated_args = templated_args,
    #     **kwargs
    # )

    # # This rule is used specifically to update snapshots via `bazel run`
    # jest(
    #     name = "%s.update" % name,
    #     data = data,
    #     templated_args = templated_args + ["-u"],
    #     **kwargs
    # )
