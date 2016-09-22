#
# This is the image that controls the standard build environment for releasing OpenShift Origin.
# It is responsible for performing a cross platform build of OpenShift.
#
# The standard name for this image is openshift/origin-release
#
FROM openshift/origin-base

RUN yum install --nogpgcheck -y gcc-c++ gcc glibc-devel make curl zip hg && yum clean all

ENV VERSION=1.6 \
    GOARM=5 \
    TMPDIR=/openshifttmp

ADD go/ /usr/local/go/
ENV GOROOT /usr/local/go
ENV PATH $PATH:/usr/local/go/bin/
ENV GOPATH /go

RUN mkdir $TMPDIR && \
    INSTALL_PKGS="make gcc zip mercurial krb5-devel bsdtar" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    curl https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz | tar -C /usr/local -xzf - && \
    go get golang.org/x/tools/cmd/cover github.com/tools/godep github.com/golang/lint/golint && \
    touch /os-build-image

# Allows building Origin sources mounted using volume
COPY openshift-origin-build.sh /usr/bin/openshift-origin-build.sh

WORKDIR /go/src/github.com/openshift/origin
LABEL io.k8s.display-name="OpenShift Origin Release Environment (golang-$VERSION)" \
      io.k8s.description="This is the standard release image for OpenShift Origin and contains the necessary build tools to build the platform."

# Expect a tar with the source of OpenShift Origin (and /os-version-defs in the root)
CMD bsdtar mxzf - && hack/build-cross.sh
