# The sglang Dockerfile is used to construct sglang image that
# can be directly used to run the OpenAI compatible server.

#################### SGLANG API SERVER ####################
FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime AS sglang

WORKDIR /workspace

# install additional dependencies for sglang api server
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install https://github.com/flashinfer-ai/flashinfer/releases/download/v0.0.9/flashinfer-0.0.9+cu121torch2.3-cp310-cp310-linux_x86_64.whl \
    && pip install "sglang[all]"

ENTRYPOINT ["python3", "-m", "sglang.launch_server"]
#################### SGLANG API SERVER ####################
