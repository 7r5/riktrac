FROM traccar/traccar:latest

WORKDIR /opt/traccar

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]
