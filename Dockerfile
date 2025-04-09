FROM amazonlinux:latest

WORKDIR /data

# System update & Python install
RUN yum -y update && \
    yum -y install python3 python3-pip gcc python3-devel && \
    yum clean all

# Install Django & other Python dependencies
COPY requirements.txt .

RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# Copy project code
COPY . .

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
