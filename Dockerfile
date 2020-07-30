FROM python:3.7

ADD requirements.txt ./
RUN pip install -r requirements.txt

# Uncomment the following lines if you install the jupyter nbextensions
#RUN jupyter nbextensions_configurator enable --user && \
#    jupyter contrib nbextension install --user
