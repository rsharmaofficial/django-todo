FROM amazonlinux:latest

WORKDIR /data

# System update & Python + MySQL build deps
RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install \
    python3 \
    python3-pip \
    python3-devel \
    gcc \
    mariadb-devel \
    pkgconfig \
    && yum clean all

# Install Python dependencies
COPY requirement.txt requirement.txt
RUN pip install --upgrade pip && \
    pip install -r requirement.txt

# Copy project code
COPY . .

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
