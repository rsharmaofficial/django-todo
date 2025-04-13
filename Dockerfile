FROM amazonlinux:latest

WORKDIR /data

# Install system dependencies
RUN yum -y update && \
    yum -y install \
        python3 \
        python3-devel \
        gcc \
        make \
        which \
        python3-pip \
        pkgconfig \
        && yum clean all

# Install virtualenv using system pip (skip upgrading pip)
RUN python3 -m pip install --user virtualenv

# Set PATH so that user installed pip packages are found
ENV PATH="/root/.local/bin:$PATH"

# Create and activate virtual environment
RUN virtualenv venv
ENV VIRTUAL_ENV=/data/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy requirements and install inside venv
COPY requirement.txt requirement.txt
RUN pip install -r requirement.txt

# Copy rest of the Django project
COPY . .

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
