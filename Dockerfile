FROM amazonlinux:2023

# 1. Update system and install core tools
RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install \
    python3 \
    python3-pip \
    python3-devel \
    gcc \
    mariadb105-devel \
    pkgconf-pkg-config \
    && yum clean all

# 2. Upgrade pip safely
RUN python3 -m pip install --upgrade pip

# 3. Create working directory
WORKDIR /app

# 4. Copy requirement file and install dependencies
COPY requirement.txt .
RUN pip install -r requirement.txt

# 5. Copy rest of the project
COPY . .

# 6. Default command
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
