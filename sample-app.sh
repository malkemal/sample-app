#!/bin/bash

echo "🔧 Membuat folder tempdir..."
mkdir -p tempdir/templates
mkdir -p tempdir/static

echo "📂 Menyalin file aplikasi ke tempdir..."
cp sample_app.py tempdir/
cp -r templates/* tempdir/templates/
cp -r static/* tempdir/static/

echo "🛠️  Membuat Dockerfile..."
cat <<EOF > tempdir/Dockerfile
FROM python:3
RUN pip install flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
EXPOSE 8080
CMD ["python3", "/home/myapp/sample_app.py"]
EOF

echo "🐳 Membuild Docker image..."
cd tempdir
docker build -t sampleapp .

echo "🚀 Menjalankan container..."
docker run -t -d -p 8080:8080 --name samplerunning sampleapp

echo "📦 Container berjalan:"
docker ps -a