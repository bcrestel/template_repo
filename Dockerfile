FROM piptools:latest

ADD requirements.txt ./
RUN pip install -r requirements.txt
