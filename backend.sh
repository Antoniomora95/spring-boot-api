set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error

IMAGE_NAME="spring-boot-api-image"
CONTAINER_NAME="spring-boot-api-container"
PORT_NUMBER="8080"

echo "Building Docker image: ${IMAGE_NAME}..."
docker build -t "${IMAGE_NAME}" .

echo "Starting Docker container: ${CONTAINER_NAME}..."
docker run -d --name "${CONTAINER_NAME}" -p "${PORT_NUMBER}:${PORT_NUMBER}" "${IMAGE_NAME}"

echo "Checking container logs: ${CONTAINER_NAME}..."
docker logs -f "${CONTAINER_NAME}"
