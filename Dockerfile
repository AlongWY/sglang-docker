# The sglang Dockerfile is used to construct sglang image that
# can be directly used to run the OpenAI compatible server.

#################### SGLANG API SERVER ####################
# prepare basic build environment
FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime AS sglang

WORKDIR /workspace

# install additional dependencies for sglang api server
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install flashinfer -i https://flashinfer.ai/whl/cu121 \
    && pip install "sglang[all]"

ENTRYPOINT ["python3", "-m", "sglang.launch_server"]
#################### SGLANG API SERVER ####################