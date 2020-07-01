###################
# PARAMETERS TO MODIFY
IMAGE_NAME = image_name
TAG_NAME = tag_name
###################
# FIXED PARAMETERS
TEST_FOLDER = src/tests
FORMAT_FOLDER = src
DOCKER_RUN = docker run -it --entrypoint=bash -w /home -v $(PWD):/home/
DOCKER_IMAGE = $(IMAGE_NAME)/$(TAG_NAME)
###################


#
# build image
#
build: Dockerfile requirements.txt
	$(info ***** Building Image *****)
	docker build -t $(DOCKER_IMAGE) .
	touch build

#
# run shell
#
.PHONY : shell
shell: build
	$(info ***** Creating shell *****)
	$(DOCKER_RUN) $(DOCKER_IMAGE)

#
# start notebook
#
.PHONY : notebook
notebook: build
	$(DOCKER_RUN) -p 8888:8888 $(DOCKER_IMAGE) -c "jupyter notebook --ip=$(hostname -I) --no-browser --allow-root"

#
# run the unit tests in src/tests
#
.PHONY : tests
tests: build
	$(DOCKER_RUN) $(DOCKER_IMAGE) -c "pytest -v --rootdir=$(TEST_FOLDER)"

#
# formatting with black
# + ordering of imports with isort
#
.PHONY : format
format: build
	$(DOCKER_RUN) $(DOCKER_IMAGE) -c "isort -rc $(FORMAT_FOLDER)"
	$(DOCKER_RUN) $(DOCKER_IMAGE) -c "black $(FORMAT_FOLDER)"
