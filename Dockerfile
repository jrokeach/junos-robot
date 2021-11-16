FROM python:3 AS base
WORKDIR /tmp
COPY requirements.txt .
RUN pip3 install -r requirements.txt
FROM base
WORKDIR /project
COPY project/* .
ENTRYPOINT ["robot"]
CMD ["-h"]