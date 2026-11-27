FROM python:3.12-slim
COPY outils/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt
WORKDIR /app
ENTRYPOINT ["python3", "outils/valider.py"]
