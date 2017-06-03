# Dockerfile used to run an instance of nyaa.
FROM python:3.6.1
MAINTAINER zaclimon <isaacpateau05@gmail.com>

# Preliminary setup for nyaa
RUN git clone https://github.com/nyaadevs/nyaa /root/nyaa
WORKDIR /root/nyaa
RUN pip install -r requirements.txt

# Add the wait-for-it script for the database
RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x wait-for-it.sh

# Add the setup script
ADD ./setup_nyaa.sh /root/nyaa

# Expose port. The default one is 5500
EXPOSE 5500

# Run nyaa
ENTRYPOINT ["/bin/bash", "/root/nyaa/setup_nyaa.sh"]