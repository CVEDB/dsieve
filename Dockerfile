FROM golang:1.17.2-alpine AS build-env

RUN apk add git
ADD . /go/src/dsieve
WORKDIR /go/src/dsieve
RUN go build -o dsieve

FROM alpine:3.14
LABEL licenses.dsieve.name="MIT" \
      licenses.dsieve.url="https://github.com/cvedb/dsieve/blob/main/LICENSE" \
      licenses.golang.name="bsd-3-clause" \
      licenses.golang.url="https://go.dev/LICENSE?m=text"

COPY --from=build-env /go/src/dsieve/dsieve /bin/dsieve

RUN mkdir -p /hive/in /hive/out

WORKDIR /app
RUN apk add bash

ENTRYPOINT [ "dsieve" ]