# Ollama-Docker
In the process of building a Local LLM using Ollama, this repository summarizes various methods using Docker

## Branch별 특징 설명
1. <a href="https://github.com/namkidong98/Ollama-Docker">main</a> : Docker에서 Ollama를 실행시킬 때 Huggingface의 원하는 custom LLM을 만들어서 실행시키는 Docker Image 생성

<br>

## 문제의식
- 기존의 Ollama Docker Image를 사용하면 custom LLM을 직접 다운로드하고 Modelfile을 작성해서 직접 경로를 설정해야 한다는 번거로움이 있다
- Docker의 편리함이란 docker run이라는 하나의 명령어로 복잡한 절차를 생략하고 애플리케이션을 실행하는 것인데, docker run 이후에도 파일을 다운로드하고 명령어를 입력해야 하는 번거로움이 있다
- Ollama를 사용하여 Custom LLM 모델을 만들고 이를 사용한 챗봇을 streamlit 서버로 돌리고자 할 때, 기존의 ollama/ollama 이미지를 pull해서 Docker에서 실행시키고 따로 build를 하는 방식을 간소화할 방법이 없을까

<br>

## 목표
- 기존의 Host System에서 직접 HuggingFace에서 custom llm의 gguf 파일을 다운로드 받고 Modelfile을 작성해서 ollama create해야 하는 과정을 Docker 환경 안에서 Ollama 서버가 돌아가면서 자동으로 할 수 있도록 한다

<br>

## Ollama Docker Image를 사용하는 기존의 방식
```
# 1. ollama image를 Docker에 가져와서 실행
docker pull ollama/ollama
docker run --gpus all -p 11434:11434 -it --name ollama-container ollama/ollama

# 2. custom LLM 파일 다운로드
# 2-1. 직접 다운로드 하기(Huggingface에 들어가서 원하는 디렉토리로 다운로드한 gguf 파일을 이동)
# 2-2. wget을 사용해서 다운로드
pip install wget
wget -O ggml-model-Q5_K_M.gguf https://huggingface.co/heegyu/EEVE-Korean-Instruct-10.8B-v1.0-GGUF/resolve/main/ggml-model-Q5_K_M.gguf?download=true

# 3. Modelfile 생성
# 4. Modelfile로 custom LLM 만들기
ollama create EEVE-Korean-10.8B -f Modelfile

# 5. streamlit 실행
pip install -r requirements.txt
streamlit run app.py
```

<br>

## 설치 및 실행 방법

1. Git Clone

```
git clone https://github.com/namkidong98/Ollama-Docker.git
cd Ollama-Docker
```

```
# 디렉토리 구조
Ollama-Docker
|_ app.py
|_ Dockerfile
|_ Modelfile
|_ requirements.txt
|_ run-ollama.sh
```

<br>

2. Docker Image 생성 및 Container 생성

<img width=800 src="https://github.com/namkidong98/Ollama-Docker/assets/113520117/00def7ae-2499-4bad-ba99-4baf057f3138">

```
docker build . -t ollama-eeve
docker run --gpus all -p 11434:11434 -it --name ollama-container  ollama-eeve
```

<br>

3. Streamlit 실행

```
streamlit run app.py
```
<img width=500 src="https://github.com/namkidong98/Ollama-Docker/assets/113520117/8156af65-2087-4db6-a639-1cf0ecaa9188">
<img width=500 src="https://github.com/namkidong98/Ollama-Docker/assets/113520117/54b4dc0c-0cfb-43b3-9715-aa1887317333">

<br><br>

## DockerHub Image로 바로 사용하기
- DockerHub 링크 : https://hub.docker.com/r/kidong98/ollama-eeve
```
docker pull kidong98/ollama-eeve:latest
docker images
docker run --gpus all -p 11434:11434 -it --name ollama-container kidong98/ollama-eeve
```
