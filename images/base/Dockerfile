#
# This is the base image from which all OpenShift Origin images inherit. Only packages
# common to all downstream images should be here. Depends on Centos 7.2+.
#
# The standard name for this image is openshift/origin-base
#
FROM ecos0003:5000/rhel:7.2

RUN INSTALL_PKGS="which git tar wget socat hostname sysvinit-tools util-linux ethtool bsdtar" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    mkdir -p /var/lib/origin

LABEL io.k8s.display-name="OpenShift Origin Centos 7 Base" \
      io.k8s.description="This is the base image from which all OpenShift Origin images inherit."
