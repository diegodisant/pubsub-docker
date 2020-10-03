#!/bin/bash

if [[ -z "${PUBSUB_PROJECT_ID}" ]]; then
  echo "[error] No PUBSUB_PROJECT_ID supplied, setting default to docker-gcp-project"

  export PUBSUB_PROJECT_ID=docker-gcp-project
fi

gcloud beta emulators pubsub start --host-port=0.0.0.0:8432 &

PUBSUB_PID=$!

if [[ -z "${PUBSUB_TOPIC_ID}" ]]; then
  echo "[error] No PUBSUB_TOPIC_ID supplied"
else
  echo "[pubsub] Creating topics and subscriptions"

  python3 /root/bin/pubsub-client.py ${PUBSUB_PROJECT_ID} create ${PUBSUB_TOPIC_ID}

  if [ $? -eq 1 ]; then
    exit 1
  fi
fi

echo "[pubsub] Ready for process [${PUBSUB_TOPIC_ID}] topic..."

wait ${PUBSUB_PID}
