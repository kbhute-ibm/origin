#
# This is an openvswitch image meant to enable OpenShift OVS based SDN
#
# The standard name for this image is openshift/openvswitch
#
FROM ecos0003:5000/rhel:7.2

COPY scripts/* /usr/local/bin/

RUN yum install -y wget tar make gcc openssl python perl && yum clean all
# Install openvswitch from the source
RUN mkdir openvswitch && cd ./openvswitch
RUN wget http://openvswitch.org/releases/openvswitch-2.4.0.tar.gz
RUN tar -xvf openvswitch-2.4.0.tar.gz
RUN cd openvswitch-2.4.0/ && ./configure && make && make install






RUN    yum clean all && \
    chmod +x /usr/local/bin/*

LABEL io.k8s.display-name="OpenShift Origin OpenVSwitch Daemon" \
      io.k8s.description="This is a component of OpenShift Origin and runs an OpenVSwitch daemon process."
VOLUME /etc/openswitch
ENV HOME /root
ENTRYPOINT ["/usr/local/bin/ovs-run.sh"]

 ADD  scripts/* /usr/local/bin/
 RUN chmod +x /usr/local/bin/*
