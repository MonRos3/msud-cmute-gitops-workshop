FROM eclipse-temurin:21-jre

RUN apt-get update && apt-get install -y curl

RUN useradd -m -d /server minecraft
WORKDIR /server
USER minecraft

ARG PAPER_VERSION=1.21.11
ARG PAPER_BUILD=69
RUN curl -o paper.jar -H "User-Agent: msud-paper-gitops-lab (https://github.com/msud/msud-paper-gitops-lab)" \
    https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${PAPER_BUILD}/downloads/paper-${PAPER_VERSION}-${PAPER_BUILD}.jar

RUN echo "eula=true" > eula.txt

EXPOSE 25565
CMD ["java", "-Xms1G", "-Xmx2G", "-jar", "paper.jar", "--nogui"]