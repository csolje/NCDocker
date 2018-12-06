FROM mcr.microsoft.com/mssql/server:2017-latest
# Install dependencies and clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    curl \
    apt-transport-https \
    mssql-tools \
    && rm -rf /var/lib/apt/lists/*
# Import the public repository GPG keys for Microsoft
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# Register the Microsoft Ubuntu 16.04 repository
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list
# Install powershell from Microsoft Repo
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    powershell
# enable HADR and SQL Agent
RUN /opt/mssql/bin/mssql-conf set hadr.hadrenabled 1 \
    && /opt/mssql/bin/mssql-conf set sqlagent.enabled true
# make sure the configuration file is in a good state
RUN /opt/mssql/bin/mssql-conf validate
# add the mssql-tools to default path for bash login sessions and interactive/non-login sessions
ENV PATH="/opt/mssql-tools/bin:${PATH}"
ENV ACCEPT_EULA="Y"
ENV SA_PASSWORD="db@t00ls10"