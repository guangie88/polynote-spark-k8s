# `polynote-spark-k8s`

Polynote set-up that builds on top of Kubernetes enabled Spark installation.

The set-up is currently based on
[guangie88/spark-k8s-addons](https://github.com/guangie88/spark-k8s-addons).

## How to build

```bash
POLYNOTE_VERSION="0.2.16"
PYTHON_VERSION="3.8"
SPARK_VERSION="2.4.4"
HADOOP_VERSION="3.1.0"
SCALA_VERSION="2.12"
docker build . -t polynote-spark-k8s \
    --build-arg POLYNOTE_VERSION="${POLYNOTE_VERSION}" \
    --build-arg PYTHON_VERSION="${PYTHON_VERSION}" \
    --build-arg SPARK_VERSION="${SPARK_VERSION}" \
    --build-arg HADOOP_VERSION="${HADOOP_VERSION}" \
    --build-arg SCALA_VERSION="${SCALA_VERSION}"
```

See [vars.yml](templates/vars.yml) to get all the possible version combinations.
