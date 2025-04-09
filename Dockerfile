FROM amazonlinux:latest

WORKDIR /data

# System update & Python install
RUN yum -y update && \
    yum -y install python3 python3-pip gcc python3-devel && \
    yum clean all

# Install Django & other Python dependencies
COPY requirement.txt requirement.txt
RUN pip install -r requirement.txt
RUN pip install --upgrade pip

# Copy project code
COPY . .

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
