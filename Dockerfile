# base img
FROM nvidia/cuda:12.1.0-base-ubuntu20.04

# timezone 설정 : Asia/Seoul
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

# apt-get update
RUN apt-get update \
&& apt-get install -y wget curl \
&& rm -rf /var/lib/apt/lists/*

# ollama 설치
RUN curl https://ollama.ai/install.sh | sh \
&& ollama --version

# Model 만들 준비
COPY Modelfile /app/Modelfile
WORKDIR /app
RUN wget -O ggml-model-Q5_K_M.gguf https://huggingface.co/heegyu/EEVE-Korean-Instruct-10.8B-v1.0-GGUF/resolve/main/ggml-model-Q5_K_M.gguf?download=true

EXPOSE 11434

# Shell 파일 실행
COPY ./run-ollama.sh /app/run-ollama.sh
RUN chmod +x /app/run-ollama.sh
CMD ["./run-ollama.sh"]