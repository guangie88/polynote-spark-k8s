ARG BASE_VERSION="v1"
ARG SPARK_VERSION
ARG SCALA_VERSION
ARG HADOOP_VERSION
FROM guangie88/spark-k8s-addons:${BASE_VERSION}_${SPARK_VERSION}_hadoop-${HADOOP_VERSION}_scala-${SCALA_VERSION}

ARG POLYNOTE_HOME="/opt/polynote"
ENV POLYNOTE_HOME="${POLYNOTE_HOME}"

ARG POLYNOTE_VERSION
ARG SCALA_VERSION

# Drop back to root to install
USER root

RUN set -euo pipefail && \
    # Install Polynote required deps (pyspark is part of the base image)
    conda install -y jedi virtualenv; \
    conda clean -a -y; \
    # Install remaining required deps via pip
    # jep has poor support for conda
    python -m pip install --no-cache-dir jep; \
    # Set up Polynote
    if [[ "${SCALA_VERSION}" == "2.12" ]]; then \
        TAR_FILE=polynote-dist-2.12.tar.gz; \
    else \
        TAR_FILE=polynote-dist.tar.gz; \
    fi; \
    mkdir -p "${POLYNOTE_HOME}"; \
    wget https://github.com/polynote/polynote/releases/download/${POLYNOTE_VERSION}/${TAR_FILE}; \
    tar xvf "${TAR_FILE}" -C "${POLYNOTE_HOME}"; \
    mv "${POLYNOTE_HOME}/polynote/*" "${POLYNOTE_HOME}/" && rmdir "${POLYNOTE_HOME}/polynote"; \
    :

ENTRYPOINT ["/opt/polynote/polynote.py"]
