FROM google/cloud-sdk:latest

COPY ./requirements.txt .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN mkdir -p /root/bin

COPY ./pubsub-client.py /root/bin
COPY ./start-pubsub.sh /root/bin

RUN chmod +x /root/bin/start-pubsub.sh

ENV PUBSUB_EMULATOR_HOST=localhost:8432

EXPOSE 8432

CMD ["/root/bin/start-pubsub.sh"]
