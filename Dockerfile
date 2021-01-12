# Pull Sub image.
FROM ubuntu:bionic-20201119

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    python3 \
                    python3-pip &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip3 install SimpleITK
#Add a shared home folder
RUN useradd -m -s /bin/bash -G users dcmnii
WORKDIR /home/dcmnii
ENV HOME="/home/dcmnii"
#Copy Script over  
COPY docker/scripts/nif.sh /home/dcmnii/nif.sh
#Correct the Permissions
RUN find $HOME -type d -exec chmod go=u {} + && \
    find $HOME -type f -exec chmod go=u {} + && \
    rm -rf $HOME/.npm $HOME/.conda $HOME/.empty
RUN touch /home/dcmnii/nif.sh
RUN chmod -R 777 /home/dcmnii/
ENTRYPOINT ["/home/dcmnii/nif.sh"]

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="NiftiSidecar" \
      org.label-schema.description="Private Sidecar Generator" \
      org.label-schema.url="http://sphub.net" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/BrettNordin/NiftiJson" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"



