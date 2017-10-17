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

## Exercise 5 - Making the pipeline script work
Now you have made a really nice pipeline in Jenkins just using the normal jobs.
Now we want it *as code*!

First off, we need a new `Pipeline` job.

* Click on `New Item`, choose `Pipeline` type, and give it a name.
* Head down to the `Pipeline` section of the job, and click on the "try sample pipeline" and choose `Hello world`
* Save and Build it.

The result should very well be that you have a blue (successful) build, and in the main view a text saying the following will appear:

>This Pipeline has run successfully, but does not define any stages. Please use the stage step to define some stages in this Pipeline.

We have to look into that now, *don't we?*

## Exercise 6 - Convert your pipeline

In pipeline, we like `stages` as they give us the ability to see where in the process things are going wrong.
So take a look at your old build script and transfer the things you did there to the jenkins script.

If you cant remember the syntax for creating stages, then here is the hello world example of it:

```
pipeline {
    agent any
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

## Exercise 7 - Add the pipeline to your repository

Create a file in your repository called `Jenkinsfile` and copy your pipeline script in it.
Change your jenkins job to use the Jenkinsfile insead of the code manually entered in the configuration page.  You will need to select `Pipeline Script from SCM` in the Definition dropdown menu.

**Congratulations, now you have a version controlled pipeline!**

-----------------

## Exercise 8 - Multibranch pipeline

Convert your pipeline to Multibranch

## Exercise 9 - Run your build in a defined environment

Use the [native make docker image](https://hub.docker.com/r/praqma/native-make/) to build in a docker container.  Follow [the documentation](https://jenkins.io/doc/book/pipeline/docker/) to run your pipeline in a container.


[https://jenkins.io/doc/book/pipeline/docker/#using-multiple-containers](https://jenkins.io/doc/book/pipeline/docker/#using-multiple-containers)


### 9.5 Extra credit

Make your own image for build, share it on docker hub, and use that in your build.

-------------------

## Exercise 10 - Build with gradle

There are gradle build files to package your application.  Take a look at `build.gradle` and `build.properties`.  We are using the [VersionedBinaryArtifacts](https://github.com/Praqma/VersionedBinaryArtifacts) plugin to build a versioned zip file of the binary we produce.

If you have docker running locally, you can try running the build like this:

    docker run --rm -it -v ~/.m2:/root/.m2 -v $(pwd):/code -w /code praqma/native-gradle ./gradlew publishToMavenLocal

To build with gradle in your fork:

 1. Change your Jenkinsfile to use the `praqma/native-gradle` docker image in the build.
 2. Change your `artifact` in the `build.properties` to create a more personal artifact name.
 3. Delete the 'Test' stage of the pipeline.  We will now run the tests during build.
 4. Replace `make all` with `gradlew publishToMavenLocal`
 5. Capture the artifact `build/distributions/*.zip`

Extra Credit:

 1. Change the source code to include `version.h` and get the application to report it's version when run.



## 11. Artifactory

We have set up a artifactory server on port 8081.  Mike will give you a username/password.

### 11.1 Publish the artifact

To publish the artifact we need to do two steps:

 1. Get some publishing secrets in our docker build environment a file `~/.gradle/gradle.properties`

    docker {
        image 'praqma/native-gradle'
        args '-v $HOME/.m2:/home/jenkins/.m2'
        args '-v $HOME/.gradle:/home/jenkins/.gradle'
    }

 2. Change our gradle task from `publishToMavenLocal` to `publish`
 3. Push these changes and do a build...you should now be able to see your artifact in artifactory.

Try to publish the artifact a second time.  It should fail with a message like this:

````
Execution failed for task ':publishDefaultPubPublicationToMavenRepository'.
> Failed to publish publication 'defaultPub' to repository 'maven'
   > Could not write to resource 'http://embedded.praqma.com:8081/artifactory/libs-release-local/net/praqma/embedded-project/1.0.5/embedded-project-1.0.5.zip'.
      > Could not PUT 'http://embedded.praqma.com:8081/artifactory/libs-release-local/net/praqma/embedded-project/1.0.5/embedded-project-1.0.5.zip'. Received status code 403 from server: Forbidden
````
### 11.2 Auto-incrementing version numbers

 1. Add the [Version Increment plugin](https://github.com/Praqma/versionincrement) to the `build.gradle`.
 2. Add a stage to bump the version number as a pre-build step.  You can get some inspiration from the [example repo](https://github.com/naesheim/VBAdemo)

### 11.3 Re-use with artifactory

Split out the library `libmathy` build to it's own pipeline.  Consume that in the application build.

## Exercise 12 - Implement the Phlow

 * Follow the instructions to set up the git extention here: [https://github.com/Praqma/git-phlow](https://github.com/Praqma/git-phlow)
 * Set up the issue labels in github using the ghi tool as described here: [https://www.praqma.com/stories/a-pragmatic-workflow/](https://www.praqma.com/stories/a-pragmatic-workflow/)


------------------


# Development commands

* Run container: `./docker-run.sh`
* Build example (inside container): `make all`
* Test example (inside container): `make test`
