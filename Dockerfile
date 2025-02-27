FROM golang:1.16-alpine

ENV home=/home/src/app

RUN mkdir -p ${home}
WORKDIR ${home}
ADD . .

# install dependencies
RUN go mod download
RUN go get github.com/githubnemo/CompileDaemon

# build bin
RUN go build -o httphub.out httphub/main.go

# run server
CMD CompileDaemon --build="go build -o httphub.out httphub/main.go" --command=./httphub.out
