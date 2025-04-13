FROM amazonlinux:2023

WORKDIR /data

# System update and install dependencies
RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install \
    python3 \
    python3-pip \
    python3-devel \
    gcc \
    mysql-devel \
    pkgconfig \
    && yum clean all

# Upgrade pip first
RUN pip3 install --upgrade pip

# Copy requirements & install Python packages
COPY requirement.txt requirement.txt
RUN pip3 install -r requirement.txt

# Copy Django project
COPY . .

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
