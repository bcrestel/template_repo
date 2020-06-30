###################
# PARAMETERS
IMAGE_NAME = image_name
TAG_NAME = tag_name
###################


#
# build image
#
.PHONY : build
build:
	docker build -t $(IMAGE_NAME)/$(TAG_NAME) .

#
# run shell
#
.PHONY : shell
shell:
	docker run -it --entrypoint=bash -w /home -v $(PWD):/home/ $(IMAGE_NAME)/$(TAG_NAME)

#
# start notebook
#
.PHONY : notebook
notebook:
	docker run -it -p 8888:8888 --entrypoint=bash -w /home -v $(PWD):/home/ $(IMAGE_NAME)/$(TAG_NAME) -c "jupyter notebook --ip=$(hostname -I) --no-browser --allow-root"

#
# run the unit tests in src/tests
#
.PHONY : tests
tests:
	docker run -it --entrypoint=bash -w /home -v $(PWD):/home/ $(IMAGE_NAME)/$(TAG_NAME) -c "pytest -v --rootdir=src/tests"
