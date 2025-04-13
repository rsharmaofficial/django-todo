FROM amazonlinux:2023

# 1. Update system and install core tools
RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install \
    python3 \
    python3-pip \
    pkgconf-pkg-config \
    && yum clean all

# 2. Install Python packages
RUN pip3 install \
    Django==3.2 \
    mysqlclient==2.2.0 \
    djangorestframework==3.14.0 \
    django-cors-headers==3.14.0

# 3. Create working directory
WORKDIR /app

# 4. Copy requirement file and install dependencies
COPY requirement.txt .
RUN pip install -r requirement.txt

# 5. Copy rest of the project
COPY . .

# 6. Default command
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
