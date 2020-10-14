"Jest testing macro that can compile typescript files for testing as well"

load("@npm//@bazel/typescript:index.bzl", "ts_project")
load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary", "nodejs_test")

def jest_test(
        srcs,
        tsconfig = None,
        jest_config = None,
        setup_file = None,
        name = "test",
        deps = []):
    """Jest testing rule that compiles the typescript sources and run jest tests

    Args:
      srcs: The sources passed
      tsconfig: The typescript config for compiling typescript files
      jest_config: The jest configuration file
      setup_file: The jest setup file
      name: The name of the test rule
      deps: The dependencies that are needed for the test
    """

    test_deps = []

    # compile the spec files first
    ts_project(
        name = name + "_compile",
        srcs = srcs,
        tsconfig = tsconfig or {},
        source_map = True,
        deps = [
            "@npm//tslib",
            "@npm//@types/jest",
        ] + deps,
    )

    templated_args = [
    ]

    # # Dependencies that are needed for the jest test
    dependencies = [
        "//tools/bazel_rules/jest",
        ":%s_compile" % name,
        "@npm//yargs",
    ] + deps

    # if we have a config file than add it
    if jest_config:
        test_deps.append(jest_config)
        templated_args.extend(["--config", "$(rootpath %s)" % jest_config])

    # for src in srcs:
    #     templated_args.extend(["--runTestsByPath", "$(rootpath %s)" % src])

    nodejs_test(
        name = name,
        testonly = True,
        data = dependencies,
        entry_point = "//tools/bazel_rules/jest:jest-runner.ts",
        templated_args = templated_args,
    )

    nodejs_binary(
        name = "%s.update" % name,
        data = dependencies,
        entry_point = "//tools/bazel_rules/jest:jest-runner.ts",
        templated_args = templated_args + ["--update"],
    )
