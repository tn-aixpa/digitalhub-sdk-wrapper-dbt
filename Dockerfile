# SPDX-FileCopyrightText: © 2025 DSLab - Fondazione Bruno Kessler
#
# SPDX-License-Identifier: Apache-2.0
FROM python:3.9

# Repo info
LABEL org.opencontainers.image.source=https://github.com/scc-digitalhub/digitalhub-sdk-wrapper-dbt

ARG ver_sdk=0.12.0
ARG ver_dbt=0.11.0

# Set working dir
WORKDIR /app/

# Install runtime and requirements
RUN python -m pip install "digitalhub[pandas]==${ver_sdk}" \
                          "digitalhub_runtime_dbt[local]==${ver_dbt}"

# Copy wrapper and set entry point
COPY wrapper.py /app/

# Add nonroot group and user
RUN useradd -r -m -u 8877 nonroot && \
    chown -R nonroot /app
USER 8877

ENTRYPOINT ["python", "wrapper.py"]
