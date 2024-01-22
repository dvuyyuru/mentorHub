# Base build stage
FROM golang:1.19 AS base
WORKDIR /src
COPY . .

# Build argument to pass the architecture
ARG TARGETARCH

# Will not support all architectures, but amd and arm work properly 
RUN GOOS=linux GOARCH=$TARGETARCH 

# Get branch and patch level, then create PATCH_LEVEL file
RUN BRANCH=$(git rev-parse --abbrev-ref HEAD) && \
    PATCH=$(git rev-parse HEAD) && \
    echo "$BRANCH.$PATCH" > /src/PATCH_LEVEL

# Final stage
FROM ubuntu
ARG TARGETARCH

# Copy the binary and PATCH_LEVEL from the build stage


EXPOSE 8081
CMD ["hellow world"]
