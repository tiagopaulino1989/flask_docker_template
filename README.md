# Inicializar o app
 > py -m wsgi

# Pegando versionamento dos pacotes
> pip freeze > requirements.txt

# Utilizando o Dockerfile:
Executando a Build do Contêiner
> docker build -t rottina:latest .

Rodando a aplicação 
> docker run -p 80:5000 rottina:latest