import yargs = require('yargs/yargs');
// import { resolve } from 'path';
// import { runCLI } from 'jest';

async function main() {
  const argv = yargs(process.argv.slice(2)).options({
    update: { type: 'boolean', default: false },
  }).argv;
  console.log(`
  
  
  HELLO WORLD!
  
    
  `, argv);
  // const { jestConfig, setupFile, files, suite } = argv;
  // const jestConfigPath = updateJestConfig(suite, jestConfig);

  // const resolvedFiles = files
  //   .split(',')
  //   .map((source) =>
  //     join(RUNFILES_HELPER.package, source).replace(/ts$/, 'js')
  //   );

  // runCLI({
  //   _: [],
  //   projects: [],

  // })

  // const { results } = await runCLI(
  //   {
  //     // /**
  //     //  * This is a hack to avoid using the jest-haste-map fs that does not support symbolic links
  //     //  * https://github.com/facebook/metro/issues/1#issuecomment-641633646
  //     //  */
  //     // _: resolvedFiles,
  //     // setupFilesAfterEnv: setupFile
  //     //   ? [resolve(setupFile).replace(/ts$/, 'js')]
  //     //   : [],
  //     // runTestsByPath: true,
  //     // verbose: true,
  //     // expand: true,
  //     // cache: false,
  //     // resolver: resolve('tools/bazel_rules/jest/jest-resolver.js'),
  //     // rootDir: resolve('./'),
  //     // colors: true,
  //   },
  //   // [jestConfigPath]
  // );

  // if (!results.success) {
  //   throw new Error(`Failed executing jest tests`);
  // }
}

main()
  .then(() => {
    process.exit(0);
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
