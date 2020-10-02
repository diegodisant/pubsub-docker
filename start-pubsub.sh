#!/bin/bash

if [[ -z "${PUBSUB_PROJECT_ID}" ]]; then
  echo "No PUBSUB_PROJECT_ID supplied, setting default of docker-gcp-project"

  export PUBSUB_PROJECT_ID=docker-gcp-project
fi

gcloud beta emulators pubsub start --host-port=0.0.0.0:8432 &

PUBSUB_PID=$!

if [[ -z "${PUBSUB_CONFIG}" ]]; then
  echo "No PUBSUB_CONFIG supplied, no additional topics or subscriptions will be created"
else
  echo "Creating topics and subscriptions"

  python /root/bin/pubsub-client.py create ${PUBSUB_PROJECT_ID} "${PUBSUB_CONFIG}"

  if [ $? -eq 1 ]; then
    exit 1
  fi
fi

echo "[pubsub] Ready for process..."

wait ${PUBSUB_PID}
