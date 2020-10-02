FROM google/cloud-sdk:272.0.0

RUN pip install grpcio
RUN pip install google-cloud-pubsub==1.6.1
RUN mkdir -p /root/bin

COPY start-pubsub.sh /root/bin
COPY pubsub-client.py /root/bin

ENV PUBSUB_EMULATOR_HOST=localhost:8432

EXPOSE 8432

CMD ["/root/bin/start-pubsub.sh"]
