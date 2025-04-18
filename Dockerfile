FROM python:3-bookworm

ARG MARKER_PDF_VERSION=1.6.2

RUN pip install torch --index-url https://download.pytorch.org/whl/cpu
RUN pip install marker-pdf[full]==${MARKER_PDF_VERSION}

# Marker Server
RUN pip install -U uvicorn fastapi python-multipart

VOLUME /data

CMD ["marker_server", "--host", "0.0.0.0", "--port", "8001"]