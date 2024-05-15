# The sglang Dockerfile is used to construct sglang image that
# can be directly used to run the OpenAI compatible server.

#################### SGLANG API SERVER ####################
# prepare basic build environment
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04 AS sglang

RUN apt-get update -y \
    && apt-get install -y python3-pip git \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

# Workaround for https://github.com/openai/triton/issues/2507 and
# https://github.com/pytorch/pytorch/issues/107960 -- hopefully
# this won't be needed for future versions of this docker image
# or future versions of triton.
RUN ldconfig /usr/local/cuda-12.4/compat/

WORKDIR /workspace

# install additional dependencies for sglang api server
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install flashinfer -i https://flashinfer.ai/whl/cu121 \
    && pip install "sglang[all]"

ENTRYPOINT ["python3", "-m", "sglang.launch_server"]
#################### SGLANG API SERVER ####################