# Go development
**Setup**
- run "**. ./setenv.sh**" to setup the environment for go

- run the following commands to download the dependencies
  + go get golang.org/x/net
  + go get google.golang.org/grpc
  + go get github.com/golang/protobuf

**Code generation using protoc command with grpc-java plugin**
- run "**./codegen.sh go**" to generate .go file(s) from .proto file(s)
  (examine the code in build/generated/source/proto/main/go/src)

**Build grpc server**
- run "go build" at src/main/go/src/helloworld/greeter_server

**Build grpc client**
- run "go build" at src/main/go/src/helloworld/greeter_client

**Launch grcp-go services**
- run "./greeter_server" to launch grpc server
- run "./greeter_client [input string]" to launch grpc client

# Java development
**Code generation using protoc command with grpc-java plugin**
- run "./codegen.sh java" to generate .java file(s) from .proto file(s)
  (examine the code in build/generated/source/proto/main/{java,grpc})

**Code generation using gradle and java plugin**
- run "./gradlew build"
  (examine the code in build/generated/source/proto/main/{java,grpc})

**Useful gradle tasks**
- run "./gradlew clean" to remove directories created by the build process

**Create .tar or .zip for distributions**
- run "./gradlew distTar" to compile, and build a .tar for distribution
  (examine .tar file at build/distributions)

- run "./gradlew distZip" to compile, and build a .zip for distribution
  (examine .zip file at build/distributions)

**Launch grpc-java services**
- build .tar file for distributions using the instructions above
- go to build/distributions location
- run "tar xf helloworld.tar" to untar the .tar file
- run "bin/hello-world-server &" to launch the grpc server
- run "bin/hello-world-client [input string]" to launch the grpc client

# Testing
- **scenario 1:** launch grpc-go server and client
- **scenario 2:** launch grpc-go server and grpc-java client
- **scenario 3:** launch grpc-java server and client
- **scenario 4:** launch grpc-java servver and grpc-go client

