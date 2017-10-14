# Build with GNU Make

[![CircleCI](https://circleci.com/gh/Praqma/native-example-make.png?style=shield&circle-token=df3dc5f6efbc2a267f7805f05a5e91d2878be9fd)](https://circleci.com/gh/Praqma/native-example-make)
[![TravisCI Status](https://travis-ci.org/Praqma/native-example-make.svg?branch=master)](https://travis-ci.org/Praqma/native-example-make)

![](https://img.shields.io/github/stars/praqma/native-example-make.svg)
![](https://img.shields.io/github/forks/praqma/native-example-make.svg)
![](https://img.shields.io/github/watchers/praqma/native-example-make.svg)
![](https://img.shields.io/github/tag/praqma/native-example-make.svg)
![](https://img.shields.io/github/release/praqma/native-example-make.svg)
![](https://img.shields.io/github/issues/praqma/native-example-make.svg)

Building with [GNU Make](https://www.gnu.org/software/make/) inside [container](https://hub.docker.com/r/praqma/native-make/).

See [native](https://github.com/Praqma/native) repository for more examples.

## Exercise 1 - Create your own fork of this project

Make your own fork of this project for you to develop on.

## Exercise 2 - Build and test your project on the jenkins servier

    make clean
    make all
    make test

## Exercise 3 - Test results

Add a `Post Build Action` to your job to publish the junit test result.

## Exercise 4 - Publish Artifacts

Add a `Post Build Action` to your job to publish the binary.

### 5. Making the pipeline script work
Now you have made a really nice pipeline in Jenkins just using the normal jobs.
Now we want it *as code*!

First off, we need a new `Pipeline` job.

* Click on `New Item`, choose `Pipeline` type, and give it a name.
* Head down to the `Pipeline` section of the job, and click on the "try sample pipeline" and choose `Hello world`
* Save and Build it.

The result should very well be that you have a blue (successful) build, and in the main view a text saying the following will appear:

>This Pipeline has run successfully, but does not define any stages. Please use the stage step to define some stages in this Pipeline.

We have to look into that now, *don't we?*

### 6. Convert your pipeline

In pipeline, we like `stages` as they give us the ability to see where in the process things are going wrong.
So take a look at your old build script and transfer the things you did there to the jenkins script.

If you cant remember the syntax for creating stages, then here is the hello world example of it:

```
node {
    stage ('Hello'){
        echo 'Hello World'
    }
}
```

Make three stages that does the following:

* `Preparation`: Clone the repository from git.
* `Build` : Executes `make all`
* `Test` : Executes `make test`
* `Results` :  Make  display the results of `out/bin/results_junit.xml`, and archive the generated exe file in the `out/bin` folder

Run this to see that it's working. The archiving part can be verified by looking for a small blue arrow next to the build number in the overview. Make sure you get your exe file with you there.

### 7. Add the pipeline to your repository

Create a file in your repository called `Jenkinsfile` and copy your pipeline script in it.
Change your jenkins job to use the Jenkinsfile insead of the code manually entered in the configuration page.  You will need to select `Pipeline Script from SCM` in the Definition dropdown menu.

**Congratulations, now you have a version controlled pipeline!**
-----------------

# Development commands

* Run container: `./docker-run.sh`
* Build example (inside container): `make all`
* Test example (inside container): `make test`
