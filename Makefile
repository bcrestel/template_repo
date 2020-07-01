###################
# PARAMETERS TO MODIFY
IMAGE_NAME = image_name
IMAGE_TAG = 1.0
###################
# FIXED PARAMETERS
TEST_FOLDER = src/tests
FORMAT_FOLDER = src
DOCKER_RUN = docker run -it --entrypoint=bash -w /home -v $(PWD):/home/
DOCKER_IMAGE = $(IMAGE_NAME):$(IMAGE_TAG)
###################


#
# build image
#
.PHONY : build
build: .build

.build: Dockerfile requirements.txt
	$(info ***** Building Image *****)
	@docker build -t $(DOCKER_IMAGE) .
	@touch .build

#
# run shell
#
.PHONY : shell
shell: build
	$(info ***** Creating shell *****)
	@$(DOCKER_RUN) $(DOCKER_IMAGE)

#
# start notebook
#
.PHONY : notebook
notebook: build
	$(info ***** Starting a notebook *****)
	@$(DOCKER_RUN) -p 8888:8888 $(DOCKER_IMAGE) -c "jupyter notebook --ip=$(hostname -I) --no-browser --allow-root"

#
# run the unit tests in src/tests
#
.PHONY : tests
tests: build
	$(info ***** Running all unit tests *****)
	@$(DOCKER_RUN) $(DOCKER_IMAGE) -c "pytest -v --rootdir=$(TEST_FOLDER)"

#
# formatting with black
# + ordering of imports with isort
#
.PHONY : format
format: build
	$(info ***** Formatting: running isort *****)
	@$(DOCKER_RUN) $(DOCKER_IMAGE) -c "isort -rc $(FORMAT_FOLDER)"
	$(info ***** Formatting: running black *****)
	@$(DOCKER_RUN) $(DOCKER_IMAGE) -c "black $(FORMAT_FOLDER)"
