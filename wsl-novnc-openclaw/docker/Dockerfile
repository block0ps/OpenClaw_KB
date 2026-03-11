FROM ubuntu:24.04

RUN apt update && apt install -y \
 xvfb \
 x11vnc \
 novnc \
 websockify \
 openbox

COPY ../start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5900
EXPOSE 6080

CMD ["/start.sh"]
